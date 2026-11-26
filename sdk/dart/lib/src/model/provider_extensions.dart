//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'provider_extensions.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProviderExtensions {
  /// Returns a new [ProviderExtensions] instance.
  ProviderExtensions({

     this.options,
  });

      /// Provider name to option object. The selected model's provider_options advertises permitted names and values. The service rejects unadvertised providers and option keys. 
  @JsonKey(
    
    name: r'options',
    required: false,
    includeIfNull: false,
  )


  final Map<String, Map<String, Object?>>? options;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ProviderExtensions &&
      other.options == options;

    @override
    int get hashCode =>
        options.hashCode;

  factory ProviderExtensions.fromJson(Map<String, dynamic> json) => _$ProviderExtensionsFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderExtensionsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

