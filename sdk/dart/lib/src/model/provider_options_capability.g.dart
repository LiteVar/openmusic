// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_options_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderOptionsCapability _$ProviderOptionsCapabilityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ProviderOptionsCapability', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['options']);
  final val = ProviderOptionsCapability(
    options: $checkedConvert(
      'options',
      (v) => (v as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          ParameterCapability.fromJson(e as Map<String, dynamic>),
        ),
      ),
    ),
  );
  return val;
});

Map<String, dynamic> _$ProviderOptionsCapabilityToJson(
  ProviderOptionsCapability instance,
) => <String, dynamic>{
  'options': instance.options.map((k, e) => MapEntry(k, e.toJson())),
};
