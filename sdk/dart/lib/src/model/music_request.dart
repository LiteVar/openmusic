//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/provider_extensions.dart';
import 'package:openmusic_sdk/src/model/audio_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_request.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MusicRequest {
  /// Returns a new [MusicRequest] instance.
  MusicRequest({

    required  this.model,

     this.prompt,

     this.lyrics,

     this.title,

     this.negativePrompt,

     this.duration,

     this.instrumental,

     this.bpm,

     this.key,

     this.timeSignature,

     this.genre,

     this.style,

     this.language,

     this.seed,

     this.n,

     this.outputFormat,

     this.sampleRate,

     this.bitrate,

     this.inputReferences,

     this.provider,

     this.webhookUrl,
  });

      /// Model ID returned by model discovery.
  @JsonKey(
    
    name: r'model',
    required: true,
    includeIfNull: false,
  )


  final String model;



      /// The style, mood, instruments, or creative direction.
  @JsonKey(
    
    name: r'prompt',
    required: false,
    includeIfNull: false,
  )


  final String? prompt;



      /// The verbatim lyrics the caller wants sung.
  @JsonKey(
    
    name: r'lyrics',
    required: false,
    includeIfNull: false,
  )


  final String? lyrics;



      /// Requested track title.
  @JsonKey(
    
    name: r'title',
    required: false,
    includeIfNull: false,
  )


  final String? title;



      /// Musical features to avoid.
  @JsonKey(
    
    name: r'negative_prompt',
    required: false,
    includeIfNull: false,
  )


  final String? negativePrompt;



      /// Target audio duration in seconds. Measured duration can differ.
          // minimum: 0
  @JsonKey(
    
    name: r'duration',
    required: false,
    includeIfNull: false,
  )


  final double? duration;



      /// True requests music without sung vocals. False allows vocals.
  @JsonKey(
    
    name: r'instrumental',
    required: false,
    includeIfNull: false,
  )


  final bool? instrumental;



      /// Target tempo in beats per minute.
          // minimum: 0
  @JsonKey(
    
    name: r'bpm',
    required: false,
    includeIfNull: false,
  )


  final double? bpm;



      /// Musical key, such as C major.
  @JsonKey(
    
    name: r'key',
    required: false,
    includeIfNull: false,
  )


  final String? key;



      /// Meter, such as 4/4.
  @JsonKey(
    
    name: r'time_signature',
    required: false,
    includeIfNull: false,
  )


  final String? timeSignature;



      /// Requested genres.
  @JsonKey(
    
    name: r'genre',
    required: false,
    includeIfNull: false,
  )


  final List<String>? genre;



      /// Requested style descriptors.
  @JsonKey(
    
    name: r'style',
    required: false,
    includeIfNull: false,
  )


  final List<String>? style;



      /// Language of the lyrics, written as a BCP 47 language tag.
  @JsonKey(
    
    name: r'language',
    required: false,
    includeIfNull: false,
  )


  final String? language;



      /// Random seed when supported. Reproducibility is model-specific.
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(
    
    name: r'seed',
    required: false,
    includeIfNull: false,
  )


  final int? seed;



      /// Requested number of generated tracks.
          // minimum: 1
  @JsonKey(
    
    name: r'n',
    required: false,
    includeIfNull: false,
  )


  final int? n;



      /// Requested audio format, such as mp3, wav, or flac.
  @JsonKey(
    
    name: r'output_format',
    required: false,
    includeIfNull: false,
  )


  final String? outputFormat;



      /// Requested sample rate in Hz.
          // minimum: 1
  @JsonKey(
    
    name: r'sample_rate',
    required: false,
    includeIfNull: false,
  )


  final int? sampleRate;



      /// Requested bitrate in bits per second.
          // minimum: 1
  @JsonKey(
    
    name: r'bitrate',
    required: false,
    includeIfNull: false,
  )


  final int? bitrate;



  @JsonKey(
    
    name: r'input_references',
    required: false,
    includeIfNull: false,
  )


  final List<AudioReference>? inputReferences;



  @JsonKey(
    
    name: r'provider',
    required: false,
    includeIfNull: false,
  )


  final ProviderExtensions? provider;



      /// Optional HTTPS callback URL for terminal task events. Use only when the model's features include webhooks. Services validate callback destinations and enforce redirect and timeout limits. 
  @JsonKey(
    
    name: r'webhook_url',
    required: false,
    includeIfNull: false,
  )


  final String? webhookUrl;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MusicRequest &&
      other.model == model &&
      other.prompt == prompt &&
      other.lyrics == lyrics &&
      other.title == title &&
      other.negativePrompt == negativePrompt &&
      other.duration == duration &&
      other.instrumental == instrumental &&
      other.bpm == bpm &&
      other.key == key &&
      other.timeSignature == timeSignature &&
      other.genre == genre &&
      other.style == style &&
      other.language == language &&
      other.seed == seed &&
      other.n == n &&
      other.outputFormat == outputFormat &&
      other.sampleRate == sampleRate &&
      other.bitrate == bitrate &&
      other.inputReferences == inputReferences &&
      other.provider == provider &&
      other.webhookUrl == webhookUrl;

    @override
    int get hashCode =>
        model.hashCode +
        prompt.hashCode +
        lyrics.hashCode +
        title.hashCode +
        negativePrompt.hashCode +
        duration.hashCode +
        instrumental.hashCode +
        bpm.hashCode +
        key.hashCode +
        timeSignature.hashCode +
        genre.hashCode +
        style.hashCode +
        language.hashCode +
        seed.hashCode +
        n.hashCode +
        outputFormat.hashCode +
        sampleRate.hashCode +
        bitrate.hashCode +
        inputReferences.hashCode +
        provider.hashCode +
        webhookUrl.hashCode;

  factory MusicRequest.fromJson(Map<String, dynamic> json) => _$MusicRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MusicRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

