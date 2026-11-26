//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/music_task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_task_event.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MusicTaskEvent {
  /// Returns a new [MusicTaskEvent] instance.
  MusicTaskEvent({

    required  this.id,

    required  this.type,

    required  this.createdAt,

    required  this.data,
  });

      /// Stable identifier for deduplication across deliveries of the event.
  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final MusicTaskEventTypeEnum type;



      /// Event creation time in Unix seconds.
          // minimum: 0
  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final int createdAt;



      /// Task in a terminal state.
  @JsonKey(
    
    name: r'data',
    required: true,
    includeIfNull: false,
  )


  final MusicTask data;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MusicTaskEvent &&
      other.id == id &&
      other.type == type &&
      other.createdAt == createdAt &&
      other.data == data;

    @override
    int get hashCode =>
        id.hashCode +
        type.hashCode +
        createdAt.hashCode +
        data.hashCode;

  factory MusicTaskEvent.fromJson(Map<String, dynamic> json) => _$MusicTaskEventFromJson(json);

  Map<String, dynamic> toJson() => _$MusicTaskEventToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum MusicTaskEventTypeEnum {
@JsonValue(r'music.task.finished')
musicPeriodTaskPeriodFinished(r'music.task.finished');

const MusicTaskEventTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


