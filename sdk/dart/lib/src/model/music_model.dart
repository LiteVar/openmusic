//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/music_model_features.dart';
import 'package:openmusic_sdk/src/model/music_parameter.dart';
import 'package:openmusic_sdk/src/model/parameter_capability.dart';
import 'package:openmusic_sdk/src/model/parameter_rule.dart';
import 'package:openmusic_sdk/src/model/provider_options_capability.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_model.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MusicModel {
  /// Returns a new [MusicModel] instance.
  MusicModel({

    required  this.id,

    required  this.object,

    required  this.name,

    required  this.type,

    required  this.supportedParameters,

    required  this.capabilities,

     this.constraints,

    required  this.features,

     this.providerOptions,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'object',
    required: true,
    includeIfNull: false,
  )


  final MusicModelObjectEnum object;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final MusicModelTypeEnum type;



      /// Common fields with a support level other than unsupported.
  @JsonKey(
    
    name: r'supported_parameters',
    required: true,
    includeIfNull: false,
  )


  final List<MusicParameter> supportedParameters;



      /// Capabilities keyed by common field name. An absent field is unsupported.
  @JsonKey(
    
    name: r'capabilities',
    required: true,
    includeIfNull: false,
  )


  final Map<String, ParameterCapability> capabilities;



  @JsonKey(
    
    name: r'constraints',
    required: false,
    includeIfNull: false,
  )


  final List<ParameterRule>? constraints;



  @JsonKey(
    
    name: r'features',
    required: true,
    includeIfNull: false,
  )


  final MusicModelFeatures features;



      /// Allowed extension options keyed by provider name.
  @JsonKey(
    
    name: r'provider_options',
    required: false,
    includeIfNull: false,
  )


  final Map<String, ProviderOptionsCapability>? providerOptions;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MusicModel &&
      other.id == id &&
      other.object == object &&
      other.name == name &&
      other.type == type &&
      other.supportedParameters == supportedParameters &&
      other.capabilities == capabilities &&
      other.constraints == constraints &&
      other.features == features &&
      other.providerOptions == providerOptions;

    @override
    int get hashCode =>
        id.hashCode +
        object.hashCode +
        name.hashCode +
        type.hashCode +
        supportedParameters.hashCode +
        capabilities.hashCode +
        constraints.hashCode +
        features.hashCode +
        providerOptions.hashCode;

  factory MusicModel.fromJson(Map<String, dynamic> json) => _$MusicModelFromJson(json);

  Map<String, dynamic> toJson() => _$MusicModelToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum MusicModelObjectEnum {
@JsonValue(r'model')
model(r'model');

const MusicModelObjectEnum(this.value);

final String value;

@override
String toString() => value;
}


enum MusicModelTypeEnum {
@JsonValue(r'music')
music(r'music');

const MusicModelTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


