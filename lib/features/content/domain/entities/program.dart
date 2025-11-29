import 'package:freezed_annotation/freezed_annotation.dart';
import 'module.dart';

part 'program.freezed.dart';
part 'program.g.dart';

@freezed
class Program with _$Program {
  const factory Program({
    required String id,
    required String title,
    required List<Module> modules,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}
