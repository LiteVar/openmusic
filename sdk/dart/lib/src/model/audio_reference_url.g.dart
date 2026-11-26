// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_reference_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioReferenceUrl _$AudioReferenceUrlFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AudioReferenceUrl', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['url']);
      final val = AudioReferenceUrl(
        url: $checkedConvert('url', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AudioReferenceUrlToJson(AudioReferenceUrl instance) =>
    <String, dynamic>{'url': instance.url};
