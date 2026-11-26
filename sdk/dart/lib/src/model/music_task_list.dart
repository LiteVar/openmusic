//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/music_task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_task_list.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MusicTaskList {
  /// Returns a new [MusicTaskList] instance.
  MusicTaskList({

    required  this.object,

    required  this.data,

     this.nextCursor,
  });

  @JsonKey(
    
    name: r'object',
    required: true,
    includeIfNull: false,
  )


  final MusicTaskListObjectEnum object;



  @JsonKey(
    
    name: r'data',
    required: true,
    includeIfNull: false,
  )


  final List<MusicTask> data;



      /// Opaque pagination cursor. Omitted on the last page.
  @JsonKey(
    
    name: r'next_cursor',
    required: false,
    includeIfNull: false,
  )


  final String? nextCursor;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MusicTaskList &&
      other.object == object &&
      other.data == data &&
      other.nextCursor == nextCursor;

    @override
    int get hashCode =>
        object.hashCode +
        data.hashCode +
        nextCursor.hashCode;

  factory MusicTaskList.fromJson(Map<String, dynamic> json) => _$MusicTaskListFromJson(json);

  Map<String, dynamic> toJson() => _$MusicTaskListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum MusicTaskListObjectEnum {
@JsonValue(r'list')
list(r'list');

const MusicTaskListObjectEnum(this.value);

final String value;

@override
String toString() => value;
}


