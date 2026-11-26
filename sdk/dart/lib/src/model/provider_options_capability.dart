//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/parameter_capability.dart';
import 'package:json_annotation/json_annotation.dart';

part 'provider_options_capability.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProviderOptionsCapability {
  /// Returns a new [ProviderOptionsCapability] instance.
  ProviderOptionsCapability({

    required  this.options,
  });

  @JsonKey(
    
    name: r'options',
    required: true,
    includeIfNull: false,
  )


  final Map<String, ParameterCapability> options;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ProviderOptionsCapability &&
      other.options == options;

    @override
    int get hashCode =>
        options.hashCode;

  factory ProviderOptionsCapability.fromJson(Map<String, dynamic> json) => _$ProviderOptionsCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderOptionsCapabilityToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

