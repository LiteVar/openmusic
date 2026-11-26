//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum MusicParameter {
  @JsonValue(r'prompt')
  prompt(r'prompt'),
  @JsonValue(r'lyrics')
  lyrics(r'lyrics'),
  @JsonValue(r'title')
  title(r'title'),
  @JsonValue(r'negative_prompt')
  negativePrompt(r'negative_prompt'),
  @JsonValue(r'duration')
  duration(r'duration'),
  @JsonValue(r'instrumental')
  instrumental(r'instrumental'),
  @JsonValue(r'bpm')
  bpm(r'bpm'),
  @JsonValue(r'key')
  key(r'key'),
  @JsonValue(r'time_signature')
  timeSignature(r'time_signature'),
  @JsonValue(r'genre')
  genre(r'genre'),
  @JsonValue(r'style')
  style(r'style'),
  @JsonValue(r'language')
  language(r'language'),
  @JsonValue(r'seed')
  seed(r'seed'),
  @JsonValue(r'n')
  n(r'n'),
  @JsonValue(r'output_format')
  outputFormat(r'output_format'),
  @JsonValue(r'sample_rate')
  sampleRate(r'sample_rate'),
  @JsonValue(r'bitrate')
  bitrate(r'bitrate'),
  @JsonValue(r'input_references')
  inputReferences(r'input_references'),
  @JsonValue(r'webhook_url')
  webhookUrl(r'webhook_url');

  const MusicParameter(this.value);

  final String value;

  @override
  String toString() => value;
}
