//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/parameter_support.dart';
import 'package:openmusic_sdk/src/model/audio_reference_role.dart';
import 'package:openmusic_sdk/src/model/parameter_type.dart';
import 'package:openmusic_sdk/src/model/capability_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parameter_capability.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ParameterCapability {
  /// Returns a new [ParameterCapability] instance.
  ParameterCapability({

    required  this.type,

    required  this.support,

     this.required_,

     this.unit,

     this.min,

     this.max,

     this.minLength,

     this.maxLength,

     this.defaultValue,

     this.allowedValues,

     this.maxItems,

     this.roles,

     this.mediaTypes,

     this.maxBytes,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final ParameterType type;



  @JsonKey(
    
    name: r'support',
    required: true,
    includeIfNull: false,
  )


  final ParameterSupport support;



      /// Required for all requests to this model when true.
  @JsonKey(
    
    name: r'required',
    required: false,
    includeIfNull: false,
  )


  final bool? required_;



  @JsonKey(
    
    name: r'unit',
    required: false,
    includeIfNull: false,
  )


  final String? unit;



      /// Inclusive lower bound for a numeric value.
  @JsonKey(
    
    name: r'min',
    required: false,
    includeIfNull: false,
  )


  final double? min;



      /// Inclusive upper bound for a numeric value.
  @JsonKey(
    
    name: r'max',
    required: false,
    includeIfNull: false,
  )


  final double? max;



          // minimum: 0
  @JsonKey(
    
    name: r'min_length',
    required: false,
    includeIfNull: false,
  )


  final int? minLength;



          // minimum: 0
  @JsonKey(
    
    name: r'max_length',
    required: false,
    includeIfNull: false,
  )


  final int? maxLength;



  @JsonKey(
    
    name: r'default_value',
    required: false,
    includeIfNull: false,
  )


  final CapabilityValue? defaultValue;



  @JsonKey(
    
    name: r'allowed_values',
    required: false,
    includeIfNull: false,
  )


  final List<CapabilityValue>? allowedValues;



          // minimum: 0
  @JsonKey(
    
    name: r'max_items',
    required: false,
    includeIfNull: false,
  )


  final int? maxItems;



  @JsonKey(
    
    name: r'roles',
    required: false,
    includeIfNull: false,
  )


  final List<AudioReferenceRole>? roles;



      /// Accepted media types for each reference.
  @JsonKey(
    
    name: r'media_types',
    required: false,
    includeIfNull: false,
  )


  final List<String>? mediaTypes;



      /// Maximum decoded bytes per reference.
          // minimum: 1
  @JsonKey(
    
    name: r'max_bytes',
    required: false,
    includeIfNull: false,
  )


  final int? maxBytes;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ParameterCapability &&
      other.type == type &&
      other.support == support &&
      other.required_ == required_ &&
      other.unit == unit &&
      other.min == min &&
      other.max == max &&
      other.minLength == minLength &&
      other.maxLength == maxLength &&
      other.defaultValue == defaultValue &&
      other.allowedValues == allowedValues &&
      other.maxItems == maxItems &&
      other.roles == roles &&
      other.mediaTypes == mediaTypes &&
      other.maxBytes == maxBytes;

    @override
    int get hashCode =>
        type.hashCode +
        support.hashCode +
        required_.hashCode +
        unit.hashCode +
        min.hashCode +
        max.hashCode +
        minLength.hashCode +
        maxLength.hashCode +
        defaultValue.hashCode +
        allowedValues.hashCode +
        maxItems.hashCode +
        roles.hashCode +
        mediaTypes.hashCode +
        maxBytes.hashCode;

  factory ParameterCapability.fromJson(Map<String, dynamic> json) => _$ParameterCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterCapabilityToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

