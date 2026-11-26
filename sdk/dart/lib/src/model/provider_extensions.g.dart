// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_extensions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderExtensions _$ProviderExtensionsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProviderExtensions', json, ($checkedConvert) {
      final val = ProviderExtensions(
        options: $checkedConvert(
          'options',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as Map<String, dynamic>),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ProviderExtensionsToJson(ProviderExtensions instance) =>
    <String, dynamic>{'options': ?instance.options};
