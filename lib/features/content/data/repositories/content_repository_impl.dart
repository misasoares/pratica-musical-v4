import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/services/storage_service.dart';
import '../../domain/repositories/i_content_repository.dart';
import '../../domain/entities/program.dart';
import '../../domain/entities/exercise.dart';

class ContentRepositoryImpl implements IContentRepository {
  final FirebaseFirestore _firestore;
  final StorageService _storageService;

  ContentRepositoryImpl(this._firestore, this._storageService);

  @override
  Future<List<Program>> getPrograms() async {
    try {
      final snapshot =
          await _firestore.collection('programs').orderBy('order').get();

      return snapshot.docs.map((doc) => Program.fromJson(doc.data())).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Program> getProgram(String programId) async {
    final doc = await _firestore.collection('programs').doc(programId).get();
    if (doc.exists) {
      return Program.fromJson(doc.data()!);
    }
    throw Exception('Program not found: $programId');
  }

  @override
  Future<Exercise?> getExercise(String exerciseId) async {
    // TODO: Implement Firestore fetch for exercises
    // For now returning null as we don't have exercises collection fully set up in UI yet
    // or we can implement a basic fetch if needed.
    // The user said "remove local data", so we can't return local data.
    try {
      final doc =
          await _firestore.collection('exercises').doc(exerciseId).get();
      if (doc.exists) {
        return Exercise.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<String, Unit>> createProgram(Program program) async {
    try {
      await _firestore
          .collection('programs')
          .doc(program.id)
          .set(program.toJson());
      return const Right(unit);
    } catch (e) {
      return Left('Erro ao criar programa: $e');
    }
  }

  @override
  Future<Either<String, Unit>> updateProgram(Program program) async {
    try {
      await _firestore
          .collection('programs')
          .doc(program.id)
          .update(program.toJson());
      return const Right(unit);
    } catch (e) {
      return Left('Erro ao atualizar programa: $e');
    }
  }

  @override
  Future<Either<String, Unit>> deleteProgram(String programId) async {
    try {
      await _firestore.collection('programs').doc(programId).delete();
      return const Right(unit);
    } catch (e) {
      return Left('Erro ao deletar programa: $e');
    }
  }

  @override
  Future<Either<String, String>> uploadProgramImage(File file) {
    return _storageService.uploadFile(file: file, path: 'programs/thumbnails');
  }
}
