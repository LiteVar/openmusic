//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'music_model_features.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MusicModelFeatures {
  /// Returns a new [MusicModelFeatures] instance.
  MusicModelFeatures({

     this.textToMusic,

     this.lyricsToMusic,

     this.instrumental,

     this.referenceAudio,

     this.continuation,

     this.cancellation,

     this.webhooks,

     this.streaming,
  });

  @JsonKey(
    
    name: r'text_to_music',
    required: false,
    includeIfNull: false,
  )


  final bool? textToMusic;



  @JsonKey(
    
    name: r'lyrics_to_music',
    required: false,
    includeIfNull: false,
  )


  final bool? lyricsToMusic;



  @JsonKey(
    
    name: r'instrumental',
    required: false,
    includeIfNull: false,
  )


  final bool? instrumental;



  @JsonKey(
    
    name: r'reference_audio',
    required: false,
    includeIfNull: false,
  )


  final bool? referenceAudio;



  @JsonKey(
    
    name: r'continuation',
    required: false,
    includeIfNull: false,
  )


  final bool? continuation;



  @JsonKey(
    
    name: r'cancellation',
    required: false,
    includeIfNull: false,
  )


  final bool? cancellation;



  @JsonKey(
    
    name: r'webhooks',
    required: false,
    includeIfNull: false,
  )


  final bool? webhooks;



      /// The service offers an independently documented streaming extension.
  @JsonKey(
    
    name: r'streaming',
    required: false,
    includeIfNull: false,
  )


  final bool? streaming;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MusicModelFeatures &&
      other.textToMusic == textToMusic &&
      other.lyricsToMusic == lyricsToMusic &&
      other.instrumental == instrumental &&
      other.referenceAudio == referenceAudio &&
      other.continuation == continuation &&
      other.cancellation == cancellation &&
      other.webhooks == webhooks &&
      other.streaming == streaming;

    @override
    int get hashCode =>
        textToMusic.hashCode +
        lyricsToMusic.hashCode +
        instrumental.hashCode +
        referenceAudio.hashCode +
        continuation.hashCode +
        cancellation.hashCode +
        webhooks.hashCode +
        streaming.hashCode;

  factory MusicModelFeatures.fromJson(Map<String, dynamic> json) => _$MusicModelFeaturesFromJson(json);

  Map<String, dynamic> toJson() => _$MusicModelFeaturesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

