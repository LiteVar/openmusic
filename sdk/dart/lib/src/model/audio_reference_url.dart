//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'audio_reference_url.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AudioReferenceUrl {
  /// Returns a new [AudioReferenceUrl] instance.
  AudioReferenceUrl({

    required  this.url,
  });

      /// HTTP(S) URL or a Base64 audio data URL, as accepted by the model. Services fetching URLs validate destinations and redirects and enforce time, size, and media-type limits. 
  @JsonKey(
    
    name: r'url',
    required: true,
    includeIfNull: false,
  )


  final String url;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AudioReferenceUrl &&
      other.url == url;

    @override
    int get hashCode =>
        url.hashCode;

  factory AudioReferenceUrl.fromJson(Map<String, dynamic> json) => _$AudioReferenceUrlFromJson(json);

  Map<String, dynamic> toJson() => _$AudioReferenceUrlToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

