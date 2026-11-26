// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParameterCondition _$ParameterConditionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ParameterCondition', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['parameter', 'operator']);
      final val = ParameterCondition(
        parameter: $checkedConvert(
          'parameter',
          (v) => $enumDecode(_$MusicParameterEnumMap, v),
        ),
        operator_: $checkedConvert(
          'operator',
          (v) => $enumDecode(_$ParameterConditionOperator_EnumEnumMap, v),
        ),
        value: $checkedConvert(
          'value',
          (v) => v == null
              ? null
              : CapabilityValue.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'operator_': 'operator'});

Map<String, dynamic> _$ParameterConditionToJson(ParameterCondition instance) =>
    <String, dynamic>{
      'parameter': _$MusicParameterEnumMap[instance.parameter]!,
      'operator': _$ParameterConditionOperator_EnumEnumMap[instance.operator_]!,
      'value': ?instance.value?.toJson(),
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

const _$ParameterConditionOperator_EnumEnumMap = {
  ParameterConditionOperator_Enum.present: 'present',
  ParameterConditionOperator_Enum.absent: 'absent',
  ParameterConditionOperator_Enum.equals: 'equals',
  ParameterConditionOperator_Enum.notEquals: 'not_equals',
};
