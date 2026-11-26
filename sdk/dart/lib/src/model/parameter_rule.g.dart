// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParameterRule _$ParameterRuleFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ParameterRule', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['when']);
      final val = ParameterRule(
        when_: $checkedConvert(
          'when',
          (v) => (v as List<dynamic>)
              .map(
                (e) => ParameterCondition.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        require: $checkedConvert(
          'require',
          (v) => (v as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MusicParameterEnumMap, e))
              .toList(),
        ),
        forbid: $checkedConvert(
          'forbid',
          (v) => (v as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MusicParameterEnumMap, e))
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'when_': 'when'});

Map<String, dynamic> _$ParameterRuleToJson(
  ParameterRule instance,
) => <String, dynamic>{
  'when': instance.when_.map((e) => e.toJson()).toList(),
  'require': ?instance.require
      ?.map((e) => _$MusicParameterEnumMap[e]!)
      .toList(),
  'forbid': ?instance.forbid?.map((e) => _$MusicParameterEnumMap[e]!).toList(),
};

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
