//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'music_track.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MusicTrack {
  /// Returns a new [MusicTrack] instance.
  MusicTrack({

    required  this.id,

    required  this.audioUrl,

     this.audioExpiresAt,

     this.title,

     this.duration,

     this.coverUrl,

     this.lyrics,

     this.format,

     this.sampleRate,

     this.bitrate,

     this.channels,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



      /// Same-service audio URL reference for this track. Resolve it against the service origin and authenticate the download with the same bearer token used for the task. 
  @JsonKey(
    
    name: r'audio_url',
    required: true,
    includeIfNull: false,
  )


  final String audioUrl;



      /// Expiration in Unix seconds, where applicable.
          // minimum: 0
  @JsonKey(
    
    name: r'audio_expires_at',
    required: false,
    includeIfNull: false,
  )


  final int? audioExpiresAt;



  @JsonKey(
    
    name: r'title',
    required: false,
    includeIfNull: false,
  )


  final String? title;



      /// Actual duration in seconds.
          // minimum: 0
  @JsonKey(
    
    name: r'duration',
    required: false,
    includeIfNull: false,
  )


  final double? duration;



      /// URL reference for cover artwork when available.
  @JsonKey(
    
    name: r'cover_url',
    required: false,
    includeIfNull: false,
  )


  final String? coverUrl;



  @JsonKey(
    
    name: r'lyrics',
    required: false,
    includeIfNull: false,
  )


  final String? lyrics;



  @JsonKey(
    
    name: r'format',
    required: false,
    includeIfNull: false,
  )


  final String? format;



      /// Actual sample rate in Hz.
          // minimum: 1
  @JsonKey(
    
    name: r'sample_rate',
    required: false,
    includeIfNull: false,
  )


  final int? sampleRate;



      /// Actual bitrate in bits per second.
          // minimum: 1
  @JsonKey(
    
    name: r'bitrate',
    required: false,
    includeIfNull: false,
  )


  final int? bitrate;



          // minimum: 1
  @JsonKey(
    
    name: r'channels',
    required: false,
    includeIfNull: false,
  )


  final int? channels;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MusicTrack &&
      other.id == id &&
      other.audioUrl == audioUrl &&
      other.audioExpiresAt == audioExpiresAt &&
      other.title == title &&
      other.duration == duration &&
      other.coverUrl == coverUrl &&
      other.lyrics == lyrics &&
      other.format == format &&
      other.sampleRate == sampleRate &&
      other.bitrate == bitrate &&
      other.channels == channels;

    @override
    int get hashCode =>
        id.hashCode +
        audioUrl.hashCode +
        audioExpiresAt.hashCode +
        title.hashCode +
        duration.hashCode +
        coverUrl.hashCode +
        lyrics.hashCode +
        format.hashCode +
        sampleRate.hashCode +
        bitrate.hashCode +
        channels.hashCode;

  factory MusicTrack.fromJson(Map<String, dynamic> json) => _$MusicTrackFromJson(json);

  Map<String, dynamic> toJson() => _$MusicTrackToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

