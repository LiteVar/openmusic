//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum AudioReferenceRole {
  @JsonValue(r'melody')
  melody(r'melody'),
  @JsonValue(r'rhythm')
  rhythm(r'rhythm'),
  @JsonValue(r'style')
  style(r'style'),
  @JsonValue(r'voice')
  voice(r'voice'),
  @JsonValue(r'composition')
  composition(r'composition'),
  @JsonValue(r'continuation')
  continuation(r'continuation');

  const AudioReferenceRole(this.value);

  final String value;

  @override
  String toString() => value;
}
