import 'dart:io';
import 'package:fpdart/fpdart.dart';
import '../entities/program.dart';
import '../entities/exercise.dart';

abstract class IContentRepository {
  Future<List<Program>> getPrograms();
  Future<Program> getProgram(String programId);
  Future<Exercise?> getExercise(String exerciseId);

  // Admin methods
  Future<Either<String, Unit>> createProgram(Program program);
  Future<Either<String, Unit>> updateProgram(Program program);
  Future<Either<String, Unit>> deleteProgram(String programId);
  Future<Either<String, String>> uploadProgramImage(File file);
}
