// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicModel _$MusicModelFromJson(Map<String, dynamic> json) => $checkedCreate(
  'MusicModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'id',
        'object',
        'name',
        'type',
        'supported_parameters',
        'capabilities',
        'features',
      ],
    );
    final val = MusicModel(
      id: $checkedConvert('id', (v) => v as String),
      object: $checkedConvert(
        'object',
        (v) => $enumDecode(_$MusicModelObjectEnumEnumMap, v),
      ),
      name: $checkedConvert('name', (v) => v as String),
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$MusicModelTypeEnumEnumMap, v),
      ),
      supportedParameters: $checkedConvert(
        'supported_parameters',
        (v) => (v as List<dynamic>)
            .map((e) => $enumDecode(_$MusicParameterEnumMap, e))
            .toList(),
      ),
      capabilities: $checkedConvert(
        'capabilities',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            k,
            ParameterCapability.fromJson(e as Map<String, dynamic>),
          ),
        ),
      ),
      constraints: $checkedConvert(
        'constraints',
        (v) => (v as List<dynamic>?)
            ?.map((e) => ParameterRule.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      features: $checkedConvert(
        'features',
        (v) => MusicModelFeatures.fromJson(v as Map<String, dynamic>),
      ),
      providerOptions: $checkedConvert(
        'provider_options',
        (v) => (v as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
            k,
            ProviderOptionsCapability.fromJson(e as Map<String, dynamic>),
          ),
        ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'supportedParameters': 'supported_parameters',
    'providerOptions': 'provider_options',
  },
);

Map<String, dynamic> _$MusicModelToJson(
  MusicModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'object': _$MusicModelObjectEnumEnumMap[instance.object]!,
  'name': instance.name,
  'type': _$MusicModelTypeEnumEnumMap[instance.type]!,
  'supported_parameters': instance.supportedParameters
      .map((e) => _$MusicParameterEnumMap[e]!)
      .toList(),
  'capabilities': instance.capabilities.map((k, e) => MapEntry(k, e.toJson())),
  'constraints': ?instance.constraints?.map((e) => e.toJson()).toList(),
  'features': instance.features.toJson(),
  'provider_options': ?instance.providerOptions?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
};

const _$MusicModelObjectEnumEnumMap = {MusicModelObjectEnum.model: 'model'};

const _$MusicModelTypeEnumEnumMap = {MusicModelTypeEnum.music: 'music'};

const _$MusicParameterEnumMap = {
  MusicParameter.prompt: 'prompt',
  MusicParameter.lyrics: 'lyrics',
  MusicParameter.title: 'title',
  MusicParameter.negativePrompt: 'negative_prompt',
  MusicParameter.duration: 'duration',
  MusicParameter.instrumental: 'instrumental',
  MusicParameter.bpm: 'bpm',
  MusicParameter.key: 'key',
  MusicParameter.timeSignature: 'time_signature',
  MusicParameter.genre: 'genre',
  MusicParameter.style: 'style',
  MusicParameter.language: 'language',
  MusicParameter.seed: 'seed',
  MusicParameter.n: 'n',
  MusicParameter.outputFormat: 'output_format',
  MusicParameter.sampleRate: 'sample_rate',
  MusicParameter.bitrate: 'bitrate',
  MusicParameter.inputReferences: 'input_references',
  MusicParameter.webhookUrl: 'webhook_url',
};
