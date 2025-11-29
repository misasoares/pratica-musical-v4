// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$programsAtom =
      Atom(name: 'HomeStoreBase.programs', context: context);

  @override
  List<Program> get programs {
    _$programsAtom.reportRead();
    return super.programs;
  }

  @override
  set programs(List<Program> value) {
    _$programsAtom.reportWrite(value, super.programs, () {
      super.programs = value;
    });
  }

  late final _$programAtom =
      Atom(name: 'HomeStoreBase.program', context: context);

  @override
  Program? get program {
    _$programAtom.reportRead();
    return super.program;
  }

  @override
  set program(Program? value) {
    _$programAtom.reportWrite(value, super.program, () {
      super.program = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'HomeStoreBase.isLoading', context: context);

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
      Atom(name: 'HomeStoreBase.errorMessage', context: context);

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

  late final _$loadProgramsAsyncAction =
      AsyncAction('HomeStoreBase.loadPrograms', context: context);

  @override
  Future<void> loadPrograms() {
    return _$loadProgramsAsyncAction.run(() => super.loadPrograms());
  }

  late final _$loadProgramAsyncAction =
      AsyncAction('HomeStoreBase.loadProgram', context: context);

  @override
  Future<void> loadProgram(String programId) {
    return _$loadProgramAsyncAction.run(() => super.loadProgram(programId));
  }

  @override
  String toString() {
    return '''
programs: ${programs},
program: ${program},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
