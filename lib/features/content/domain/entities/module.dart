import 'package:freezed_annotation/freezed_annotation.dart';
import 'schedule.dart';
import 'theory_content.dart';

part 'module.freezed.dart';
part 'module.g.dart';

@freezed
class Module with _$Module {
  const factory Module({
    required String id,
    required String title,
    required String type,
    List<Schedule>? schedules,
    List<TheoryContent>? contents,
  }) = _Module;

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);
}
