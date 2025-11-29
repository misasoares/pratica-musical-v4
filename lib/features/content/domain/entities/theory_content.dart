import 'package:freezed_annotation/freezed_annotation.dart';

part 'theory_content.freezed.dart';
part 'theory_content.g.dart';

@freezed
class TheoryContent with _$TheoryContent {
  const factory TheoryContent({
    required String id,
    required String title,
    required String videoUrl,
    required String type,
  }) = _TheoryContent;

  factory TheoryContent.fromJson(Map<String, dynamic> json) =>
      _$TheoryContentFromJson(json);
}
