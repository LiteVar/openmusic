// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicRequest _$MusicRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'MusicRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['model']);
    final val = MusicRequest(
      model: $checkedConvert('model', (v) => v as String),
      prompt: $checkedConvert('prompt', (v) => v as String?),
      lyrics: $checkedConvert('lyrics', (v) => v as String?),
      title: $checkedConvert('title', (v) => v as String?),
      negativePrompt: $checkedConvert('negative_prompt', (v) => v as String?),
      duration: $checkedConvert('duration', (v) => (v as num?)?.toDouble()),
      instrumental: $checkedConvert('instrumental', (v) => v as bool?),
      bpm: $checkedConvert('bpm', (v) => (v as num?)?.toDouble()),
      key: $checkedConvert('key', (v) => v as String?),
      timeSignature: $checkedConvert('time_signature', (v) => v as String?),
      genre: $checkedConvert(
        'genre',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      style: $checkedConvert(
        'style',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      language: $checkedConvert('language', (v) => v as String?),
      seed: $checkedConvert('seed', (v) => (v as num?)?.toInt()),
      n: $checkedConvert('n', (v) => (v as num?)?.toInt()),
      outputFormat: $checkedConvert('output_format', (v) => v as String?),
      sampleRate: $checkedConvert('sample_rate', (v) => (v as num?)?.toInt()),
      bitrate: $checkedConvert('bitrate', (v) => (v as num?)?.toInt()),
      inputReferences: $checkedConvert(
        'input_references',
        (v) => (v as List<dynamic>?)
            ?.map((e) => AudioReference.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      provider: $checkedConvert(
        'provider',
        (v) => v == null
            ? null
            : ProviderExtensions.fromJson(v as Map<String, dynamic>),
      ),
      webhookUrl: $checkedConvert('webhook_url', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'negativePrompt': 'negative_prompt',
    'timeSignature': 'time_signature',
    'outputFormat': 'output_format',
    'sampleRate': 'sample_rate',
    'inputReferences': 'input_references',
    'webhookUrl': 'webhook_url',
  },
);

Map<String, dynamic> _$MusicRequestToJson(MusicRequest instance) =>
    <String, dynamic>{
      'model': instance.model,
      'prompt': ?instance.prompt,
      'lyrics': ?instance.lyrics,
      'title': ?instance.title,
      'negative_prompt': ?instance.negativePrompt,
      'duration': ?instance.duration,
      'instrumental': ?instance.instrumental,
      'bpm': ?instance.bpm,
      'key': ?instance.key,
      'time_signature': ?instance.timeSignature,
      'genre': ?instance.genre,
      'style': ?instance.style,
      'language': ?instance.language,
      'seed': ?instance.seed,
      'n': ?instance.n,
      'output_format': ?instance.outputFormat,
      'sample_rate': ?instance.sampleRate,
      'bitrate': ?instance.bitrate,
      'input_references': ?instance.inputReferences
          ?.map((e) => e.toJson())
          .toList(),
      'provider': ?instance.provider?.toJson(),
      'webhook_url': ?instance.webhookUrl,
    };
