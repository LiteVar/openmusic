// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicModelList _$MusicModelListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MusicModelList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['object', 'data']);
      final val = MusicModelList(
        object: $checkedConvert(
          'object',
          (v) => $enumDecode(_$MusicModelListObjectEnumEnumMap, v),
        ),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>)
              .map((e) => MusicModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MusicModelListToJson(MusicModelList instance) =>
    <String, dynamic>{
      'object': _$MusicModelListObjectEnumEnumMap[instance.object]!,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

const _$MusicModelListObjectEnumEnumMap = {
  MusicModelListObjectEnum.list: 'list',
};
