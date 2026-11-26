//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

/// Native maps to an upstream parameter. Prompt expresses an approximate control in the generation prompt. Postprocess applies an audio transformation after generation. Unsupported rejects the field. 
enum ParameterSupport {
  @JsonValue(r'native')
  native_(r'native'),
  @JsonValue(r'prompt')
  prompt(r'prompt'),
  @JsonValue(r'postprocess')
  postprocess(r'postprocess'),
  @JsonValue(r'unsupported')
  unsupported(r'unsupported');

  const ParameterSupport(this.value);

  final String value;

  @override
  String toString() => value;
}
