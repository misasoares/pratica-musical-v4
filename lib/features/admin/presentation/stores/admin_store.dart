import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:mobx/mobx.dart';
import '../../../content/domain/entities/program.dart';
import '../../../content/domain/repositories/i_content_repository.dart';

part 'admin_store.g.dart';

class AdminStore = AdminStoreBase with _$AdminStore;

abstract class AdminStoreBase with Store {
  final IContentRepository _contentRepository;

  AdminStoreBase(this._contentRepository);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  ObservableList<Program> programs = ObservableList<Program>();

  @action
  Future<void> loadPrograms() async {
    isLoading = true;
    errorMessage = null;
    try {
      final result = await _contentRepository.getPrograms();
      programs = ObservableList.of(result);
    } catch (e) {
      errorMessage = 'Erro ao carregar programas: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<Either<String, Unit>> createProgram(
      Program program, File? imageFile) async {
    isLoading = true;
    errorMessage = null;
    try {
      Program programToSave = program;

      if (imageFile != null) {
        final uploadResult =
            await _contentRepository.uploadProgramImage(imageFile);
        uploadResult.fold(
          (l) => throw Exception(l),
          (url) => programToSave = programToSave.copyWith(thumbnailUrl: url),
        );
      }

      final result = await _contentRepository.createProgram(programToSave);
      return result.fold(
        (l) {
          errorMessage = l;
          return Left(l);
        },
        (r) {
          programs.add(programToSave);
          return const Right(unit);
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      return Left(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<Either<String, Unit>> updateProgram(
      Program program, File? newImageFile) async {
    isLoading = true;
    errorMessage = null;
    try {
      Program programToSave = program;

      if (newImageFile != null) {
        final uploadResult =
            await _contentRepository.uploadProgramImage(newImageFile);
        uploadResult.fold(
          (l) => throw Exception(l),
          (url) => programToSave = programToSave.copyWith(thumbnailUrl: url),
        );
      }

      final result = await _contentRepository.updateProgram(programToSave);
      return result.fold(
        (l) {
          errorMessage = l;
          return Left(l);
        },
        (r) {
          final index = programs.indexWhere((p) => p.id == program.id);
          if (index != -1) {
            programs[index] = programToSave;
          }
          return const Right(unit);
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      return Left(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<Either<String, Unit>> deleteProgram(String programId) async {
    isLoading = true;
    errorMessage = null;
    try {
      final result = await _contentRepository.deleteProgram(programId);
      return result.fold(
        (l) {
          errorMessage = l;
          return Left(l);
        },
        (r) {
          programs.removeWhere((p) => p.id == programId);
          return const Right(unit);
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      return Left(e.toString());
    } finally {
      isLoading = false;
    }
  }
}
