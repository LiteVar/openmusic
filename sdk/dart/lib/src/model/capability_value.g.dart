// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capability_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapabilityValue _$CapabilityValueFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CapabilityValue', json, ($checkedConvert) {
      final val = CapabilityValue(
        string: $checkedConvert('string', (v) => v as String?),
        number: $checkedConvert('number', (v) => (v as num?)?.toDouble()),
        boolean: $checkedConvert('boolean', (v) => v as bool?),
        strings: $checkedConvert(
          'strings',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CapabilityValueToJson(CapabilityValue instance) =>
    <String, dynamic>{
      'string': ?instance.string,
      'number': ?instance.number,
      'boolean': ?instance.boolean,
      'strings': ?instance.strings,
    };
