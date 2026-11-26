//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ApiError {
  /// Returns a new [ApiError] instance.
  ApiError({

    required  this.code,

    required  this.message,

     this.param,
  });

      /// Stable machine-readable error code.
  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



      /// Human-readable description.
  @JsonKey(
    
    name: r'message',
    required: true,
    includeIfNull: false,
  )


  final String message;



      /// Relevant field path when the error applies to a parameter.
  @JsonKey(
    
    name: r'param',
    required: false,
    includeIfNull: false,
  )


  final String? param;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ApiError &&
      other.code == code &&
      other.message == message &&
      other.param == param;

    @override
    int get hashCode =>
        code.hashCode +
        message.hashCode +
        param.hashCode;

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

