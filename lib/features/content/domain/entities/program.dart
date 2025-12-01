import 'package:freezed_annotation/freezed_annotation.dart';
import 'module.dart';

part 'program.freezed.dart';
part 'program.g.dart';

@freezed
class Program with _$Program {
  const factory Program({
    required String id,
    required String title,
    required String description,
    required String thumbnailUrl,
    required int order,
    @Default(false) bool isVisible,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<Module> modules,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}
