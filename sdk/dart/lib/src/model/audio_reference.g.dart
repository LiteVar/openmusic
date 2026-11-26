// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioReference _$AudioReferenceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AudioReference', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'audio_url', 'role']);
      final val = AudioReference(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$AudioReferenceTypeEnumEnumMap, v),
        ),
        audioUrl: $checkedConvert(
          'audio_url',
          (v) => AudioReferenceUrl.fromJson(v as Map<String, dynamic>),
        ),
        role: $checkedConvert(
          'role',
          (v) => $enumDecode(_$AudioReferenceRoleEnumMap, v),
        ),
      );
      return val;
    }, fieldKeyMap: const {'audioUrl': 'audio_url'});

Map<String, dynamic> _$AudioReferenceToJson(AudioReference instance) =>
    <String, dynamic>{
      'type': _$AudioReferenceTypeEnumEnumMap[instance.type]!,
      'audio_url': instance.audioUrl.toJson(),
      'role': _$AudioReferenceRoleEnumMap[instance.role]!,
    };

const _$AudioReferenceTypeEnumEnumMap = {
  AudioReferenceTypeEnum.audioUrl: 'audio_url',
};

const _$AudioReferenceRoleEnumMap = {
  AudioReferenceRole.melody: 'melody',
  AudioReferenceRole.rhythm: 'rhythm',
  AudioReferenceRole.style: 'style',
  AudioReferenceRole.voice: 'voice',
  AudioReferenceRole.composition: 'composition',
  AudioReferenceRole.continuation: 'continuation',
};
