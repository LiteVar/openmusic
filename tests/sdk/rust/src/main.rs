use std::collections::HashMap;

use openmusic_sdk::apis::configuration::Configuration;
use openmusic_sdk::apis::{music_api as api, Error};
use openmusic_sdk::models::{MusicParameter, MusicRequest, MusicTaskStatus, ProviderExtensions};
use serde_json::json;

#[tokio::main(flavor = "current_thread")]
async fn main() {
    let configuration = Configuration {
        base_path: std::env::var("OPENMUSIC_TEST_URL").unwrap(),
        bearer_access_token: Some("openmusic-test-token".into()),
        ..Configuration::new()
    };
    let model_id = "example/studio-v1";
    let lyrics = "[Verse]\nLast light over the harbor";
    let catalog = api::list_music_models(&configuration).await.unwrap();
    assert_eq!(catalog.data[0].id, model_id);
    let model = api::get_music_model(&configuration, model_id)
        .await
        .unwrap();
    assert_eq!(
        model.capabilities["duration"]
            .default_value
            .as_ref()
            .unwrap()
            .number,
        Some(60.0)
    );
    assert_eq!(
        model.capabilities["instrumental"]
            .default_value
            .as_ref()
            .unwrap()
            .boolean,
        Some(false)
    );
    assert_eq!(
        model.constraints.unwrap()[0].require.as_deref(),
        Some(&[MusicParameter::Prompt][..])
    );

    let mut request = MusicRequest::new(model_id.into());
    request.prompt = Some("Acoustic ballad".into());
    request.lyrics = Some(lyrics.into());
    request.duration = Some(60.5);
    request.instrumental = Some(false);
    request.n = Some(2);
    request.provider = Some(ProviderExtensions {
        options: Some(HashMap::from([(
            "example".into(),
            HashMap::from([
                ("guidance_scale".into(), json!(4.5)),
                (
                    "composition".into(),
                    json!({"sections": ["verse"], "offset": null}),
                ),
            ]),
        )])),
    });
    let submitted = api::create_music_task(&configuration, request.clone(), Some("smoke"))
        .await
        .unwrap();
    assert_eq!(submitted.status, MusicTaskStatus::Queued);
    let replay = api::create_music_task(&configuration, request, Some("smoke"))
        .await
        .unwrap();
    assert_eq!(replay.id, submitted.id);
    let running = api::get_music_task(&configuration, &submitted.id)
        .await
        .unwrap();
    assert_eq!(running.status, MusicTaskStatus::InProgress);
    assert_eq!(running.progress, Some(None));
    let completed = api::get_music_task(&configuration, &submitted.id)
        .await
        .unwrap();
    assert_eq!(completed.status, MusicTaskStatus::Completed);
    let tracks = completed.data.unwrap();
    assert_eq!(tracks.len(), 2);
    assert_eq!(tracks[1].lyrics.as_deref(), Some(lyrics));
    assert_eq!(completed.usage.unwrap().generated_tracks, 2);

    let audio = api::download_music_track(&configuration, &completed.id, Some(&tracks[1].id))
        .await
        .unwrap();
    assert_eq!(audio.headers()["content-type"], "audio/wav");
    assert_eq!(
        &audio.bytes().await.unwrap()[..],
        b"RIFF(\0\0\0WAVEfmt \x10\0\0\0\x01\0\x01\0@\x1f\0\0@\x1f\0\0\x01\0\x08\0data\x04\0\0\0\0\xff\x80\x7f"
    );
    assert_eq!(
        api::list_music_tasks(&configuration, Some(20), None)
            .await
            .unwrap()
            .data[0]
            .id,
        completed.id
    );

    let mut invalid = MusicRequest::new(model_id.into());
    invalid.bpm = Some(120.0);
    let Err(Error::ResponseError(error)) =
        api::create_music_task(&configuration, invalid, None).await
    else {
        panic!("Unsupported BPM should be rejected");
    };
    assert_eq!(error.status.as_u16(), 400);
    assert!(matches!(
        error.entity,
        Some(api::CreateMusicTaskError::Status400(body)) if body.error.code == "unsupported_parameter"
    ));

    let mut pending = MusicRequest::new(model_id.into());
    pending.prompt = Some("Piano".into());
    let pending = api::create_music_task(&configuration, pending, None)
        .await
        .unwrap();
    let cancelled = api::cancel_music_task(&configuration, &pending.id)
        .await
        .unwrap();
    assert_eq!(cancelled.status, MusicTaskStatus::Cancelled);
    api::delete_music_task(&configuration, &pending.id)
        .await
        .unwrap();
    let Err(Error::ResponseError(error)) = api::get_music_task(&configuration, &pending.id).await
    else {
        panic!("Deleted tasks should return 404");
    };
    assert_eq!(error.status.as_u16(), 404);
    assert!(matches!(
        error.entity,
        Some(api::GetMusicTaskError::Status404(body)) if body.error.code == "task_not_found"
    ));
}
