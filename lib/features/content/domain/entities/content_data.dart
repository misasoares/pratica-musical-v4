// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'program.dart';
import 'exercise.dart';

part 'content_data.freezed.dart';
part 'content_data.g.dart';

@freezed
class ContentData with _$ContentData {
  const factory ContentData({
    required List<Program> programs,
    @JsonKey(name: 'exercises_db') required List<Exercise> exercisesDb,
  }) = _ContentData;

  factory ContentData.fromJson(Map<String, dynamic> json) =>
      _$ContentDataFromJson(json);
}
