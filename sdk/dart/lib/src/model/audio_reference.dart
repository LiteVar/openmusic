//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/audio_reference_url.dart';
import 'package:openmusic_sdk/src/model/audio_reference_role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_reference.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AudioReference {
  /// Returns a new [AudioReference] instance.
  AudioReference({

    required  this.type,

    required  this.audioUrl,

    required  this.role,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final AudioReferenceTypeEnum type;



  @JsonKey(
    
    name: r'audio_url',
    required: true,
    includeIfNull: false,
  )


  final AudioReferenceUrl audioUrl;



  @JsonKey(
    
    name: r'role',
    required: true,
    includeIfNull: false,
  )


  final AudioReferenceRole role;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AudioReference &&
      other.type == type &&
      other.audioUrl == audioUrl &&
      other.role == role;

    @override
    int get hashCode =>
        type.hashCode +
        audioUrl.hashCode +
        role.hashCode;

  factory AudioReference.fromJson(Map<String, dynamic> json) => _$AudioReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$AudioReferenceToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum AudioReferenceTypeEnum {
@JsonValue(r'audio_url')
audioUrl(r'audio_url');

const AudioReferenceTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


