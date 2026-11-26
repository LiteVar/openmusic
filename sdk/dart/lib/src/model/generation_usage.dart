//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'generation_usage.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GenerationUsage {
  /// Returns a new [GenerationUsage] instance.
  GenerationUsage({

    required  this.generatedTracks,

     this.generatedSeconds,
  });

          // minimum: 1
  @JsonKey(
    
    name: r'generated_tracks',
    required: true,
    includeIfNull: false,
  )


  final int generatedTracks;



      /// Total duration when the duration of every generated track is known.
          // minimum: 0
  @JsonKey(
    
    name: r'generated_seconds',
    required: false,
    includeIfNull: false,
  )


  final double? generatedSeconds;





    @override
    bool operator ==(Object other) => identical(this, other) || other is GenerationUsage &&
      other.generatedTracks == generatedTracks &&
      other.generatedSeconds == generatedSeconds;

    @override
    int get hashCode =>
        generatedTracks.hashCode +
        generatedSeconds.hashCode;

  factory GenerationUsage.fromJson(Map<String, dynamic> json) => _$GenerationUsageFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationUsageToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

