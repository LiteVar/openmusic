//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/music_parameter.dart';
import 'package:openmusic_sdk/src/model/capability_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parameter_condition.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ParameterCondition {
  /// Returns a new [ParameterCondition] instance.
  ParameterCondition({

    required  this.parameter,

    required  this.operator_,

     this.value,
  });

  @JsonKey(
    
    name: r'parameter',
    required: true,
    includeIfNull: false,
  )


  final MusicParameter parameter;



      /// Equals and not_equals match only when the field is explicitly supplied.
  @JsonKey(
    
    name: r'operator',
    required: true,
    includeIfNull: false,
  )


  final ParameterConditionOperator_Enum operator_;



      /// Required for equals and not_equals. Omit for present and absent.
  @JsonKey(
    
    name: r'value',
    required: false,
    includeIfNull: false,
  )


  final CapabilityValue? value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ParameterCondition &&
      other.parameter == parameter &&
      other.operator_ == operator_ &&
      other.value == value;

    @override
    int get hashCode =>
        parameter.hashCode +
        operator_.hashCode +
        value.hashCode;

  factory ParameterCondition.fromJson(Map<String, dynamic> json) => _$ParameterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterConditionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

/// Equals and not_equals match only when the field is explicitly supplied.
enum ParameterConditionOperator_Enum {
@JsonValue(r'present')
present(r'present'),
@JsonValue(r'absent')
absent(r'absent'),
@JsonValue(r'equals')
equals(r'equals'),
@JsonValue(r'not_equals')
notEquals(r'not_equals');

const ParameterConditionOperator_Enum(this.value);

final String value;

@override
String toString() => value;
}


