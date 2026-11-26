import 'dart:io';

import 'package:openmusic_sdk/openmusic_sdk.dart';

String requiredEnvironment(String name) {
  final value = Platform.environment[name];
  if (value == null || value.isEmpty) {
    throw StateError('Set $name before running this example.');
  }
  return value;
}

Future<void> main() async {
  final client = OpenmusicSdk(
    basePathOverride: requiredEnvironment('OPENMUSIC_BASE_URL')
        .replaceFirst(RegExp(r'/+$'), ''),
  );
  client.setBearerAuth('BearerAuth', requiredEnvironment('OPENMUSIC_TOKEN'));
  final api = client.getMusicApi();

  try {
    final modelId = Platform.environment['OPENMUSIC_MODEL'];
    if (modelId == null || modelId.isEmpty) {
      final models = (await api.listMusicModels()).data!.data;
      for (final model in models) {
        stdout.writeln(model.id);
      }
      return;
    }

    final model = (await api.getMusicModel(modelId: modelId)).data!;
    if (!model.supportedParameters.contains(MusicParameter.prompt)) {
      throw StateError('Model $modelId does not accept a prompt.');
    }

    var task = (await api.createMusicTask(
      musicRequest: MusicRequest(
        model: modelId,
        prompt: 'A gentle acoustic instrumental with piano and guitar',
      ),
    )).data!;
    stdout.writeln('Task ${task.id}');

    for (var attempt = 0; attempt < 150; attempt++) {
      if (task.status != MusicTaskStatus.queued &&
          task.status != MusicTaskStatus.inProgress) {
        break;
      }
      await Future<void>.delayed(const Duration(seconds: 2));
      task = (await api.getMusicTask(id: task.id)).data!;
    }
    if (task.status != MusicTaskStatus.completed) {
      throw StateError(
        task.error?.message ?? 'Task ${task.id} is ${task.status}.',
      );
    }

    final tracks = task.data;
    if (tracks == null || tracks.isEmpty) {
      throw StateError('Task ${task.id} returned no tracks.');
    }
    final track = tracks.first;
    final audio = await api.downloadMusicTrack(id: task.id, trackId: track.id);
    final bytes = audio.data;
    if (bytes == null || bytes.isEmpty) {
      throw StateError('Track ${track.id} returned no audio.');
    }

    final format =
        RegExp(r'^[A-Za-z0-9]+$').stringMatch(track.format ?? '') ?? 'audio';
    final safeId = task.id.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
    final file = File('$safeId.$format');
    await file.writeAsBytes(bytes);
    stdout.writeln('Saved ${file.path}');
  } finally {
    client.dio.close();
  }
}
