// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParameterCapability _$ParameterCapabilityFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ParameterCapability',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['type', 'support']);
        final val = ParameterCapability(
          type: $checkedConvert(
            'type',
            (v) => $enumDecode(_$ParameterTypeEnumMap, v),
          ),
          support: $checkedConvert(
            'support',
            (v) => $enumDecode(_$ParameterSupportEnumMap, v),
          ),
          required_: $checkedConvert('required', (v) => v as bool?),
          unit: $checkedConvert('unit', (v) => v as String?),
          min: $checkedConvert('min', (v) => (v as num?)?.toDouble()),
          max: $checkedConvert('max', (v) => (v as num?)?.toDouble()),
          minLength: $checkedConvert('min_length', (v) => (v as num?)?.toInt()),
          maxLength: $checkedConvert('max_length', (v) => (v as num?)?.toInt()),
          defaultValue: $checkedConvert(
            'default_value',
            (v) => v == null
                ? null
                : CapabilityValue.fromJson(v as Map<String, dynamic>),
          ),
          allowedValues: $checkedConvert(
            'allowed_values',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) => CapabilityValue.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          maxItems: $checkedConvert('max_items', (v) => (v as num?)?.toInt()),
          roles: $checkedConvert(
            'roles',
            (v) => (v as List<dynamic>?)
                ?.map((e) => $enumDecode(_$AudioReferenceRoleEnumMap, e))
                .toList(),
          ),
          mediaTypes: $checkedConvert(
            'media_types',
            (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
          ),
          maxBytes: $checkedConvert('max_bytes', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'required_': 'required',
        'minLength': 'min_length',
        'maxLength': 'max_length',
        'defaultValue': 'default_value',
        'allowedValues': 'allowed_values',
        'maxItems': 'max_items',
        'mediaTypes': 'media_types',
        'maxBytes': 'max_bytes',
      },
    );

Map<String, dynamic> _$ParameterCapabilityToJson(
  ParameterCapability instance,
) => <String, dynamic>{
  'type': _$ParameterTypeEnumMap[instance.type]!,
  'support': _$ParameterSupportEnumMap[instance.support]!,
  'required': ?instance.required_,
  'unit': ?instance.unit,
  'min': ?instance.min,
  'max': ?instance.max,
  'min_length': ?instance.minLength,
  'max_length': ?instance.maxLength,
  'default_value': ?instance.defaultValue?.toJson(),
  'allowed_values': ?instance.allowedValues?.map((e) => e.toJson()).toList(),
  'max_items': ?instance.maxItems,
  'roles': ?instance.roles
      ?.map((e) => _$AudioReferenceRoleEnumMap[e]!)
      .toList(),
  'media_types': ?instance.mediaTypes,
  'max_bytes': ?instance.maxBytes,
};

const _$ParameterTypeEnumMap = {
  ParameterType.string: 'string',
  ParameterType.number: 'number',
  ParameterType.integer: 'integer',
  ParameterType.boolean: 'boolean',
  ParameterType.array: 'array',
  ParameterType.object: 'object',
};

const _$ParameterSupportEnumMap = {
  ParameterSupport.native_: 'native',
  ParameterSupport.prompt: 'prompt',
  ParameterSupport.postprocess: 'postprocess',
  ParameterSupport.unsupported: 'unsupported',
};

const _$AudioReferenceRoleEnumMap = {
  AudioReferenceRole.melody: 'melody',
  AudioReferenceRole.rhythm: 'rhythm',
  AudioReferenceRole.style: 'style',
  AudioReferenceRole.voice: 'voice',
  AudioReferenceRole.composition: 'composition',
  AudioReferenceRole.continuation: 'continuation',
};
