import 'package:openmusic_sdk/src/model/api_error.dart';
import 'package:openmusic_sdk/src/model/audio_reference.dart';
import 'package:openmusic_sdk/src/model/audio_reference_url.dart';
import 'package:openmusic_sdk/src/model/capability_value.dart';
import 'package:openmusic_sdk/src/model/error_response.dart';
import 'package:openmusic_sdk/src/model/generation_usage.dart';
import 'package:openmusic_sdk/src/model/music_model.dart';
import 'package:openmusic_sdk/src/model/music_model_features.dart';
import 'package:openmusic_sdk/src/model/music_model_list.dart';
import 'package:openmusic_sdk/src/model/music_request.dart';
import 'package:openmusic_sdk/src/model/music_task.dart';
import 'package:openmusic_sdk/src/model/music_task_event.dart';
import 'package:openmusic_sdk/src/model/music_task_list.dart';
import 'package:openmusic_sdk/src/model/music_track.dart';
import 'package:openmusic_sdk/src/model/parameter_capability.dart';
import 'package:openmusic_sdk/src/model/parameter_condition.dart';
import 'package:openmusic_sdk/src/model/parameter_rule.dart';
import 'package:openmusic_sdk/src/model/provider_extensions.dart';
import 'package:openmusic_sdk/src/model/provider_options_capability.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
      switch (targetType) {
        case 'String':
          return '$value' as ReturnType;
        case 'int':
          return (value is int ? value : int.parse('$value')) as ReturnType;
        case 'bool':
          if (value is bool) {
            return value as ReturnType;
          }
          final valueString = '$value'.toLowerCase();
          return (valueString == 'true' || valueString == '1') as ReturnType;
        case 'double':
          return (value is double ? value : double.parse('$value')) as ReturnType;
        case 'ApiError':
          return ApiError.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AudioReference':
          return AudioReference.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AudioReferenceRole':
          
          
        case 'AudioReferenceUrl':
          return AudioReferenceUrl.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CapabilityValue':
          return CapabilityValue.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ErrorResponse':
          return ErrorResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GenerationUsage':
          return GenerationUsage.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MusicModel':
          return MusicModel.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MusicModelFeatures':
          return MusicModelFeatures.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MusicModelList':
          return MusicModelList.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MusicParameter':
          
          
        case 'MusicRequest':
          return MusicRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MusicTask':
          return MusicTask.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MusicTaskEvent':
          return MusicTaskEvent.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MusicTaskList':
          return MusicTaskList.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MusicTaskStatus':
          
          
        case 'MusicTrack':
          return MusicTrack.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ParameterCapability':
          return ParameterCapability.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ParameterCondition':
          return ParameterCondition.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ParameterRule':
          return ParameterRule.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ParameterSupport':
          
          
        case 'ParameterType':
          
          
        case 'ProviderExtensions':
          return ProviderExtensions.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ProviderOptionsCapability':
          return ProviderOptionsCapability.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!.trim(); // ignore: parameter_assignments
            return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    }
    throw Exception('Cannot deserialize');
  }