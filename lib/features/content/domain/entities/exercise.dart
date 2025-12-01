import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String title,
    required String videoUrl,
    required String tabUrl,
    @Default([]) List<String> tags,
    @Default(1) int difficulty,
    int? warmupBpm,
    int? warmupDuration,
    @Default(60) int startBpmCalibration,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
