//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ParameterType {
  @JsonValue(r'string')
  string(r'string'),
  @JsonValue(r'number')
  number(r'number'),
  @JsonValue(r'integer')
  integer(r'integer'),
  @JsonValue(r'boolean')
  boolean(r'boolean'),
  @JsonValue(r'array')
  array(r'array'),
  @JsonValue(r'object')
  object(r'object');

  const ParameterType(this.value);

  final String value;

  @override
  String toString() => value;
}
