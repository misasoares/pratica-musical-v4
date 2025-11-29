import 'package:mobx/mobx.dart';
import '../../../content/domain/entities/program.dart';
import '../../../content/domain/entities/exercise.dart';
import '../../../content/domain/repositories/i_content_repository.dart';
import '../../../player/domain/repositories/i_practice_repository.dart';
import '../../../player/data/models/practice_log_model.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IContentRepository _contentRepository;
  final IPracticeRepository _practiceRepository;

  HomeStoreBase(this._contentRepository, this._practiceRepository);

  @observable
  List<Program> programs = [];

  @observable
  Program? program;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  int weeklyPractices = 0;

  @observable
  int maxBpm = 0;

  @observable
  PracticeLogModel? lastPracticedLog;

  @action
  Future<void> loadPrograms() async {
    isLoading = true;
    errorMessage = null;
    try {
      programs = await _contentRepository.getPrograms();
      await loadDashboardStats();
    } catch (e) {
      errorMessage = 'Erro ao carregar cursos: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadDashboardStats() async {
    try {
      final logs = await _practiceRepository.getAllLogs();

      // Calculate Max BPM
      if (logs.isNotEmpty) {
        maxBpm =
            logs.map((l) => l.maxBpmReached).reduce((a, b) => a > b ? a : b);
      } else {
        maxBpm = 0;
      }

      // Calculate Weekly Practices
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      weeklyPractices = logs.where((l) => l.date.isAfter(startOfWeek)).length;

      // Get Last Practiced Log
      if (logs.isNotEmpty) {
        logs.sort((a, b) => b.date.compareTo(a.date));
        lastPracticedLog = logs.first;
      } else {
        lastPracticedLog = null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error loading stats: $e');
    }
  }

  @action
  Future<Exercise?> getExercise(String exerciseId) async {
    try {
      return await _contentRepository.getExercise(exerciseId);
    } catch (e) {
      // ignore: avoid_print
      print('Error loading exercise: $e');
      return null;
    }
  }

  @action
  Future<void> loadProgram(String programId) async {
    isLoading = true;
    errorMessage = null;
    try {
      program = await _contentRepository.getProgram(programId);
    } catch (e) {
      errorMessage = 'Erro ao carregar curso: $e';
    } finally {
      isLoading = false;
    }
  }
}
