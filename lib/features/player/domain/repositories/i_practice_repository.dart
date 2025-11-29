import '../../data/models/practice_log_model.dart';

abstract class IPracticeRepository {
  Future<void> saveLog(PracticeLogModel log);
  Future<PracticeLogModel?> getLastLog(String exerciseId);
  Future<List<PracticeLogModel>> getAllLogs();
}
