// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerationUsage _$GenerationUsageFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GenerationUsage',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['generated_tracks']);
        final val = GenerationUsage(
          generatedTracks: $checkedConvert(
            'generated_tracks',
            (v) => (v as num).toInt(),
          ),
          generatedSeconds: $checkedConvert(
            'generated_seconds',
            (v) => (v as num?)?.toDouble(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'generatedTracks': 'generated_tracks',
        'generatedSeconds': 'generated_seconds',
      },
    );

Map<String, dynamic> _$GenerationUsageToJson(GenerationUsage instance) =>
    <String, dynamic>{
      'generated_tracks': instance.generatedTracks,
      'generated_seconds': ?instance.generatedSeconds,
    };
