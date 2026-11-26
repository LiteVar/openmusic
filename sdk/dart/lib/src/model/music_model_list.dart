//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openmusic_sdk/src/model/music_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_model_list.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MusicModelList {
  /// Returns a new [MusicModelList] instance.
  MusicModelList({

    required  this.object,

    required  this.data,
  });

  @JsonKey(
    
    name: r'object',
    required: true,
    includeIfNull: false,
  )


  final MusicModelListObjectEnum object;



  @JsonKey(
    
    name: r'data',
    required: true,
    includeIfNull: false,
  )


  final List<MusicModel> data;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MusicModelList &&
      other.object == object &&
      other.data == data;

    @override
    int get hashCode =>
        object.hashCode +
        data.hashCode;

  factory MusicModelList.fromJson(Map<String, dynamic> json) => _$MusicModelListFromJson(json);

  Map<String, dynamic> toJson() => _$MusicModelListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum MusicModelListObjectEnum {
@JsonValue(r'list')
list(r'list');

const MusicModelListObjectEnum(this.value);

final String value;

@override
String toString() => value;
}


