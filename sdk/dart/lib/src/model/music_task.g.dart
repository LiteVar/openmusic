// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicTask _$MusicTaskFromJson(Map<String, dynamic> json) => $checkedCreate(
  'MusicTask',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['id', 'object', 'model', 'status', 'created_at'],
    );
    final val = MusicTask(
      id: $checkedConvert('id', (v) => v as String),
      object: $checkedConvert(
        'object',
        (v) => $enumDecode(_$MusicTaskObjectEnumEnumMap, v),
      ),
      model: $checkedConvert('model', (v) => v as String),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$MusicTaskStatusEnumMap, v),
      ),
      progress: $checkedConvert('progress', (v) => (v as num?)?.toInt()),
      createdAt: $checkedConvert('created_at', (v) => (v as num).toInt()),
      completedAt: $checkedConvert('completed_at', (v) => (v as num?)?.toInt()),
      data: $checkedConvert(
        'data',
        (v) => (v as List<dynamic>?)
            ?.map((e) => MusicTrack.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      usage: $checkedConvert(
        'usage',
        (v) => v == null
            ? null
            : GenerationUsage.fromJson(v as Map<String, dynamic>),
      ),
      error: $checkedConvert(
        'error',
        (v) => v == null ? null : ApiError.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'createdAt': 'created_at', 'completedAt': 'completed_at'},
);

Map<String, dynamic> _$MusicTaskToJson(MusicTask instance) => <String, dynamic>{
  'id': instance.id,
  'object': _$MusicTaskObjectEnumEnumMap[instance.object]!,
  'model': instance.model,
  'status': _$MusicTaskStatusEnumMap[instance.status]!,
  'progress': ?instance.progress,
  'created_at': instance.createdAt,
  'completed_at': ?instance.completedAt,
  'data': ?instance.data?.map((e) => e.toJson()).toList(),
  'usage': ?instance.usage?.toJson(),
  'error': ?instance.error?.toJson(),
};

const _$MusicTaskObjectEnumEnumMap = {MusicTaskObjectEnum.music: 'music'};

const _$MusicTaskStatusEnumMap = {
  MusicTaskStatus.queued: 'queued',
  MusicTaskStatus.inProgress: 'in_progress',
  MusicTaskStatus.completed: 'completed',
  MusicTaskStatus.failed: 'failed',
  MusicTaskStatus.cancelled: 'cancelled',
};
