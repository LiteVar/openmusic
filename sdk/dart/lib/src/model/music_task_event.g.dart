// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_task_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicTaskEvent _$MusicTaskEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MusicTaskEvent', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'type', 'created_at', 'data'],
      );
      final val = MusicTaskEvent(
        id: $checkedConvert('id', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$MusicTaskEventTypeEnumEnumMap, v),
        ),
        createdAt: $checkedConvert('created_at', (v) => (v as num).toInt()),
        data: $checkedConvert(
          'data',
          (v) => MusicTask.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'createdAt': 'created_at'});

Map<String, dynamic> _$MusicTaskEventToJson(MusicTaskEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MusicTaskEventTypeEnumEnumMap[instance.type]!,
      'created_at': instance.createdAt,
      'data': instance.data.toJson(),
    };

const _$MusicTaskEventTypeEnumEnumMap = {
  MusicTaskEventTypeEnum.musicPeriodTaskPeriodFinished: 'music.task.finished',
};
