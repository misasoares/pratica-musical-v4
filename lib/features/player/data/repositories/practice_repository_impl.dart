import 'package:hive/hive.dart';
import '../../data/models/practice_log_model.dart';
import '../../domain/repositories/i_practice_repository.dart';

class PracticeRepositoryImpl implements IPracticeRepository {
  static const String _boxName = 'practice_logs';

  Future<Box<PracticeLogModel>> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<PracticeLogModel>(_boxName);
    }
    return await Hive.openBox<PracticeLogModel>(_boxName);
  }

  @override
  Future<void> saveLog(PracticeLogModel log) async {
    final box = await _getBox();
    await box.put(log.id, log);
  }

  @override
  Future<PracticeLogModel?> getLastLog(String exerciseId) async {
    final box = await _getBox();
    // Filter logs by exerciseId and sort by date descending
    final logs =
        box.values.where((log) => log.exerciseId == exerciseId).toList();
    if (logs.isEmpty) return null;

    logs.sort((a, b) => b.date.compareTo(a.date));
    return logs.first;
  }

  @override
  Future<List<PracticeLogModel>> getAllLogs() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> clearAllLogs() async {
    final box = await _getBox();
    await box.clear();
  }
}
