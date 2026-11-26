// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_task_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicTaskList _$MusicTaskListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MusicTaskList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['object', 'data']);
      final val = MusicTaskList(
        object: $checkedConvert(
          'object',
          (v) => $enumDecode(_$MusicTaskListObjectEnumEnumMap, v),
        ),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>)
              .map((e) => MusicTask.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('next_cursor', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'nextCursor': 'next_cursor'});

Map<String, dynamic> _$MusicTaskListToJson(MusicTaskList instance) =>
    <String, dynamic>{
      'object': _$MusicTaskListObjectEnumEnumMap[instance.object]!,
      'data': instance.data.map((e) => e.toJson()).toList(),
      'next_cursor': ?instance.nextCursor,
    };

const _$MusicTaskListObjectEnumEnumMap = {MusicTaskListObjectEnum.list: 'list'};
