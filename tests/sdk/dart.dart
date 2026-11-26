import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:openmusic_sdk/openmusic_sdk.dart';

Future<void> main() async {
  final client = OpenmusicSdk(
    basePathOverride: Platform.environment['OPENMUSIC_TEST_URL']!,
  );
  client.setBearerAuth('BearerAuth', 'openmusic-test-token');
  final api = client.getMusicApi();
  const modelId = 'example/studio-v1';
  const lyrics = '[Verse]\nLast light over the harbor';

  try {
    assert((await api.listMusicModels()).data!.data.first.id == modelId);
    final model = (await api.getMusicModel(modelId: modelId)).data!;
    assert(model.capabilities['duration']!.defaultValue!.number == 60);
    assert(model.capabilities['instrumental']!.defaultValue!.boolean == false);
    assert(model.constraints!.first.require!.single == MusicParameter.prompt);

    final request = MusicRequest(
      model: modelId,
      prompt: 'Acoustic ballad',
      lyrics: lyrics,
      duration: 60.5,
      instrumental: false,
      n: 2,
      provider: ProviderExtensions(
        options: {
          'example': {
            'guidance_scale': 4.5,
            'composition': {
              'sections': ['verse'],
              'offset': null,
            },
          },
        },
      ),
    );
    final submitted = (await api.createMusicTask(
      musicRequest: request,
      idempotencyKey: 'smoke',
    )).data!;
    assert(submitted.status == MusicTaskStatus.queued);
    final replay = await api.createMusicTask(
      musicRequest: request,
      idempotencyKey: 'smoke',
    );
    assert(replay.data!.id == submitted.id);
    final running = (await api.getMusicTask(id: submitted.id)).data!;
    assert(
      running.status == MusicTaskStatus.inProgress && running.progress == null,
    );
    final completed = (await api.getMusicTask(id: submitted.id)).data!;
    assert(
      completed.status == MusicTaskStatus.completed &&
          completed.data!.length == 2,
    );
    assert(completed.data![1].lyrics == lyrics);
    assert(completed.usage!.generatedTracks == 2);

    final audio = await api.downloadMusicTrack(
      id: completed.id,
      trackId: completed.data![1].id,
    );
    assert(audio.headers.value('content-type') == 'audio/wav');
    assert(
      base64Encode(audio.data!) ==
          'UklGRigAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQQAAAAA/4B/',
    );
    assert(
      (await api.listMusicTasks(limit: 20)).data!.data.first.id == completed.id,
    );

    try {
      await api.createMusicTask(
        musicRequest: MusicRequest(model: modelId, bpm: 120),
      );
      throw StateError('Unsupported BPM should be rejected');
    } on DioException catch (error) {
      final response = error.response!;
      assert(response.statusCode == 400);
      assert(
        ErrorResponse.fromJson(response.data).error.code ==
            'unsupported_parameter',
      );
    }

    final pending = (await api.createMusicTask(
      musicRequest: MusicRequest(model: modelId, prompt: 'Piano'),
    )).data!;
    assert(
      (await api.cancelMusicTask(id: pending.id)).data!.status ==
          MusicTaskStatus.cancelled,
    );
    await api.deleteMusicTask(id: pending.id);
  } finally {
    client.dio.close();
  }
}
