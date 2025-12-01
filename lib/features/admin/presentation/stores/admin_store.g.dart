// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AdminStore on AdminStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'AdminStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'AdminStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$programsAtom =
      Atom(name: 'AdminStoreBase.programs', context: context);

  @override
  ObservableList<Program> get programs {
    _$programsAtom.reportRead();
    return super.programs;
  }

  @override
  set programs(ObservableList<Program> value) {
    _$programsAtom.reportWrite(value, super.programs, () {
      super.programs = value;
    });
  }

  late final _$loadProgramsAsyncAction =
      AsyncAction('AdminStoreBase.loadPrograms', context: context);

  @override
  Future<void> loadPrograms() {
    return _$loadProgramsAsyncAction.run(() => super.loadPrograms());
  }

  late final _$createProgramAsyncAction =
      AsyncAction('AdminStoreBase.createProgram', context: context);

  @override
  Future<Either<String, Unit>> createProgram(Program program, File? imageFile) {
    return _$createProgramAsyncAction
        .run(() => super.createProgram(program, imageFile));
  }

  late final _$updateProgramAsyncAction =
      AsyncAction('AdminStoreBase.updateProgram', context: context);

  @override
  Future<Either<String, Unit>> updateProgram(
      Program program, File? newImageFile) {
    return _$updateProgramAsyncAction
        .run(() => super.updateProgram(program, newImageFile));
  }

  late final _$deleteProgramAsyncAction =
      AsyncAction('AdminStoreBase.deleteProgram', context: context);

  @override
  Future<Either<String, Unit>> deleteProgram(String programId) {
    return _$deleteProgramAsyncAction.run(() => super.deleteProgram(programId));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
programs: ${programs}
    ''';
  }
}
