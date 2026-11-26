import base64
import os

from openmusic_sdk import ApiClient, Configuration, MusicApi, MusicRequest, ProviderExtensions
from openmusic_sdk.exceptions import ApiException


MODEL_ID = "example/studio-v1"
LYRICS = "[Verse]\nLast light over the harbor"
AUDIO = base64.b64decode("UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQQAAAAA/4B/")


def main():
    configuration = Configuration(
        host=os.environ["OPENMUSIC_TEST_URL"], access_token="openmusic-test-token"
    )
    with ApiClient(configuration) as client:
        api = MusicApi(client)
        assert api.list_music_models().data[0].id == MODEL_ID
        model = api.get_music_model(MODEL_ID)
        assert model.capabilities["duration"].default_value.number == 60
        assert model.capabilities["instrumental"].default_value.boolean is False
        assert model.constraints[0].require == ["prompt"]

        request = MusicRequest(
            model=MODEL_ID,
            prompt="Acoustic ballad",
            lyrics=LYRICS,
            duration=60.5,
            instrumental=False,
            n=2,
            provider=ProviderExtensions(options={
                "example": {
                    "guidance_scale": 4.5,
                    "composition": {"sections": ["verse"], "offset": None},
                },
            }),
        )
        submitted = api.create_music_task(request, idempotency_key="smoke")
        assert submitted.status == "queued"
        assert api.create_music_task(request, idempotency_key="smoke").id == submitted.id
        running = api.get_music_task(submitted.id)
        assert running.status == "in_progress" and running.progress is None
        completed = api.get_music_task(submitted.id)
        assert completed.status == "completed" and len(completed.data) == 2
        assert completed.data[1].lyrics == LYRICS
        assert completed.usage.generated_tracks == 2
        assert api.download_music_track(completed.id, track_id=completed.data[1].id) == AUDIO
        assert api.list_music_tasks(limit=20).data[0].id == completed.id

        try:
            api.create_music_task(MusicRequest(model=MODEL_ID, bpm=120))
        except ApiException as error:
            assert error.status == 400 and error.data.error.code == "unsupported_parameter"
        else:
            raise AssertionError("Unsupported BPM should be rejected")

        pending = api.create_music_task(MusicRequest(model=MODEL_ID, prompt="Piano"))
        assert api.cancel_music_task(pending.id).status == "cancelled"
        api.delete_music_task(pending.id)


if __name__ == "__main__":
    main()
