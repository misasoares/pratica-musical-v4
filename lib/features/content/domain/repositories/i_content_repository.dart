import '../entities/program.dart';
import '../entities/exercise.dart';

abstract class IContentRepository {
  Future<Program> getProgram(String programId);
  Future<Exercise?> getExercise(String exerciseId);
}
