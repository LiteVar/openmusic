// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model_features.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicModelFeatures _$MusicModelFeaturesFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MusicModelFeatures',
      json,
      ($checkedConvert) {
        final val = MusicModelFeatures(
          textToMusic: $checkedConvert('text_to_music', (v) => v as bool?),
          lyricsToMusic: $checkedConvert('lyrics_to_music', (v) => v as bool?),
          instrumental: $checkedConvert('instrumental', (v) => v as bool?),
          referenceAudio: $checkedConvert('reference_audio', (v) => v as bool?),
          continuation: $checkedConvert('continuation', (v) => v as bool?),
          cancellation: $checkedConvert('cancellation', (v) => v as bool?),
          webhooks: $checkedConvert('webhooks', (v) => v as bool?),
          streaming: $checkedConvert('streaming', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'textToMusic': 'text_to_music',
        'lyricsToMusic': 'lyrics_to_music',
        'referenceAudio': 'reference_audio',
      },
    );

Map<String, dynamic> _$MusicModelFeaturesToJson(MusicModelFeatures instance) =>
    <String, dynamic>{
      'text_to_music': ?instance.textToMusic,
      'lyrics_to_music': ?instance.lyricsToMusic,
      'instrumental': ?instance.instrumental,
      'reference_audio': ?instance.referenceAudio,
      'continuation': ?instance.continuation,
      'cancellation': ?instance.cancellation,
      'webhooks': ?instance.webhooks,
      'streaming': ?instance.streaming,
    };
