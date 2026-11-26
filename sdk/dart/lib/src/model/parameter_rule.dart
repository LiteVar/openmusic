//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/music_parameter.dart';
import 'package:openmusic_sdk/src/model/parameter_condition.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parameter_rule.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ParameterRule {
  /// Returns a new [ParameterRule] instance.
  ParameterRule({

    required  this.when_,

     this.require,

     this.forbid,
  });

  @JsonKey(
    
    name: r'when',
    required: true,
    includeIfNull: false,
  )


  final List<ParameterCondition> when_;



  @JsonKey(
    
    name: r'require',
    required: false,
    includeIfNull: false,
  )


  final List<MusicParameter>? require;



  @JsonKey(
    
    name: r'forbid',
    required: false,
    includeIfNull: false,
  )


  final List<MusicParameter>? forbid;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ParameterRule &&
      other.when_ == when_ &&
      other.require == require &&
      other.forbid == forbid;

    @override
    int get hashCode =>
        when_.hashCode +
        require.hashCode +
        forbid.hashCode;

  factory ParameterRule.fromJson(Map<String, dynamic> json) => _$ParameterRuleFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterRuleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

