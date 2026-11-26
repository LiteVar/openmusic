//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/music_track.dart';
import 'package:openmusic_sdk/src/model/generation_usage.dart';
import 'package:openmusic_sdk/src/model/music_task_status.dart';
import 'package:openmusic_sdk/src/model/api_error.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_task.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MusicTask {
  /// Returns a new [MusicTask] instance.
  MusicTask({

    required  this.id,

    required  this.object,

    required  this.model,

    required  this.status,

     this.progress,

    required  this.createdAt,

     this.completedAt,

     this.data,

     this.usage,

     this.error,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'object',
    required: true,
    includeIfNull: false,
  )


  final MusicTaskObjectEnum object;



  @JsonKey(
    
    name: r'model',
    required: true,
    includeIfNull: false,
  )


  final String model;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final MusicTaskStatus status;



      /// Real percentage when available. Null or omission means unknown.
          // minimum: 0
          // maximum: 100
  @JsonKey(
    
    name: r'progress',
    required: false,
    includeIfNull: false,
  )


  final int? progress;



      /// Creation time in Unix seconds.
          // minimum: 0
  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final int createdAt;



      /// Required when status is completed. Unix seconds.
          // minimum: 0
  @JsonKey(
    
    name: r'completed_at',
    required: false,
    includeIfNull: false,
  )


  final int? completedAt;



      /// Generated tracks. Required when status is completed.
  @JsonKey(
    
    name: r'data',
    required: false,
    includeIfNull: false,
  )


  final List<MusicTrack>? data;



  @JsonKey(
    
    name: r'usage',
    required: false,
    includeIfNull: false,
  )


  final GenerationUsage? usage;



      /// Required when status is failed.
  @JsonKey(
    
    name: r'error',
    required: false,
    includeIfNull: false,
  )


  final ApiError? error;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MusicTask &&
      other.id == id &&
      other.object == object &&
      other.model == model &&
      other.status == status &&
      other.progress == progress &&
      other.createdAt == createdAt &&
      other.completedAt == completedAt &&
      other.data == data &&
      other.usage == usage &&
      other.error == error;

    @override
    int get hashCode =>
        id.hashCode +
        object.hashCode +
        model.hashCode +
        status.hashCode +
        (progress == null ? 0 : progress.hashCode) +
        createdAt.hashCode +
        completedAt.hashCode +
        data.hashCode +
        usage.hashCode +
        error.hashCode;

  factory MusicTask.fromJson(Map<String, dynamic> json) => _$MusicTaskFromJson(json);

  Map<String, dynamic> toJson() => _$MusicTaskToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum MusicTaskObjectEnum {
@JsonValue(r'music')
music(r'music');

const MusicTaskObjectEnum(this.value);

final String value;

@override
String toString() => value;
}


