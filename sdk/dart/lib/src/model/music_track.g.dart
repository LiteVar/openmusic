// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicTrack _$MusicTrackFromJson(Map<String, dynamic> json) => $checkedCreate(
  'MusicTrack',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['id', 'audio_url']);
    final val = MusicTrack(
      id: $checkedConvert('id', (v) => v as String),
      audioUrl: $checkedConvert('audio_url', (v) => v as String),
      audioExpiresAt: $checkedConvert(
        'audio_expires_at',
        (v) => (v as num?)?.toInt(),
      ),
      title: $checkedConvert('title', (v) => v as String?),
      duration: $checkedConvert('duration', (v) => (v as num?)?.toDouble()),
      coverUrl: $checkedConvert('cover_url', (v) => v as String?),
      lyrics: $checkedConvert('lyrics', (v) => v as String?),
      format: $checkedConvert('format', (v) => v as String?),
      sampleRate: $checkedConvert('sample_rate', (v) => (v as num?)?.toInt()),
      bitrate: $checkedConvert('bitrate', (v) => (v as num?)?.toInt()),
      channels: $checkedConvert('channels', (v) => (v as num?)?.toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'audioUrl': 'audio_url',
    'audioExpiresAt': 'audio_expires_at',
    'coverUrl': 'cover_url',
    'sampleRate': 'sample_rate',
  },
);

Map<String, dynamic> _$MusicTrackToJson(MusicTrack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'audio_url': instance.audioUrl,
      'audio_expires_at': ?instance.audioExpiresAt,
      'title': ?instance.title,
      'duration': ?instance.duration,
      'cover_url': ?instance.coverUrl,
      'lyrics': ?instance.lyrics,
      'format': ?instance.format,
      'sample_rate': ?instance.sampleRate,
      'bitrate': ?instance.bitrate,
      'channels': ?instance.channels,
    };
