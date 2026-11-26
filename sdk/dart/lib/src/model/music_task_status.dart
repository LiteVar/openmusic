//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

/// Queued tasks can start, fail, or be cancelled. Running tasks can complete, fail, or be cancelled. Completed, failed, and cancelled are terminal states. 
enum MusicTaskStatus {
  @JsonValue(r'queued')
  queued(r'queued'),
  @JsonValue(r'in_progress')
  inProgress(r'in_progress'),
  @JsonValue(r'completed')
  completed(r'completed'),
  @JsonValue(r'failed')
  failed(r'failed'),
  @JsonValue(r'cancelled')
  cancelled(r'cancelled');

  const MusicTaskStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
