import 'package:hive/hive.dart';

part 'practice_log_model.g.dart';

@HiveType(typeId: 1)
class PracticeLogModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String exerciseId;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String mode; // 'calibration' | 'training'

  @HiveField(4)
  final int maxBpmReached;

  @HiveField(5)
  final int durationSeconds;

  @HiveField(6)
  final String result; // 'success' | 'fail'

  @HiveField(7)
  final int targetBpm;

  PracticeLogModel({
    required this.id,
    required this.exerciseId,
    required this.date,
    required this.mode,
    required this.maxBpmReached,
    required this.durationSeconds,
    required this.result,
    required this.targetBpm,
  });
}
