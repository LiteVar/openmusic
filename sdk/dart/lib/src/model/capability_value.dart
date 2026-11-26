//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'capability_value.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CapabilityValue {
  /// Returns a new [CapabilityValue] instance.
  CapabilityValue({

     this.string,

     this.number,

     this.boolean,

     this.strings,
  });

  @JsonKey(
    
    name: r'string',
    required: false,
    includeIfNull: false,
  )


  final String? string;



  @JsonKey(
    
    name: r'number',
    required: false,
    includeIfNull: false,
  )


  final double? number;



  @JsonKey(
    
    name: r'boolean',
    required: false,
    includeIfNull: false,
  )


  final bool? boolean;



  @JsonKey(
    
    name: r'strings',
    required: false,
    includeIfNull: false,
  )


  final List<String>? strings;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CapabilityValue &&
      other.string == string &&
      other.number == number &&
      other.boolean == boolean &&
      other.strings == strings;

    @override
    int get hashCode =>
        string.hashCode +
        number.hashCode +
        boolean.hashCode +
        strings.hashCode;

  factory CapabilityValue.fromJson(Map<String, dynamic> json) => _$CapabilityValueFromJson(json);

  Map<String, dynamic> toJson() => _$CapabilityValueToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

