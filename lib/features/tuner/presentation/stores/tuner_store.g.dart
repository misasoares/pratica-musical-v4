// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuner_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TunerStore on TunerStoreBase, Store {
  late final _$isListeningAtom =
      Atom(name: 'TunerStoreBase.isListening', context: context);

  @override
  bool get isListening {
    _$isListeningAtom.reportRead();
    return super.isListening;
  }

  @override
  set isListening(bool value) {
    _$isListeningAtom.reportWrite(value, super.isListening, () {
      super.isListening = value;
    });
  }

  late final _$currentNoteAtom =
      Atom(name: 'TunerStoreBase.currentNote', context: context);

  @override
  String get currentNote {
    _$currentNoteAtom.reportRead();
    return super.currentNote;
  }

  @override
  set currentNote(String value) {
    _$currentNoteAtom.reportWrite(value, super.currentNote, () {
      super.currentNote = value;
    });
  }

  late final _$currentFrequencyAtom =
      Atom(name: 'TunerStoreBase.currentFrequency', context: context);

  @override
  double get currentFrequency {
    _$currentFrequencyAtom.reportRead();
    return super.currentFrequency;
  }

  @override
  set currentFrequency(double value) {
    _$currentFrequencyAtom.reportWrite(value, super.currentFrequency, () {
      super.currentFrequency = value;
    });
  }

  late final _$centsDiffAtom =
      Atom(name: 'TunerStoreBase.centsDiff', context: context);

  @override
  double get centsDiff {
    _$centsDiffAtom.reportRead();
    return super.centsDiff;
  }

  @override
  set centsDiff(double value) {
    _$centsDiffAtom.reportWrite(value, super.centsDiff, () {
      super.centsDiff = value;
    });
  }

  late final _$statusAtom =
      Atom(name: 'TunerStoreBase.status', context: context);

  @override
  TunerStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(TunerStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$startAsyncAction =
      AsyncAction('TunerStoreBase.start', context: context);

  @override
  Future<void> start() {
    return _$startAsyncAction.run(() => super.start());
  }

  late final _$stopAsyncAction =
      AsyncAction('TunerStoreBase.stop', context: context);

  @override
  Future<void> stop() {
    return _$stopAsyncAction.run(() => super.stop());
  }

  late final _$TunerStoreBaseActionController =
      ActionController(name: 'TunerStoreBase', context: context);

  @override
  void _processFrequency(double frequency) {
    final _$actionInfo = _$TunerStoreBaseActionController.startAction(
        name: 'TunerStoreBase._processFrequency');
    try {
      return super._processFrequency(frequency);
    } finally {
      _$TunerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isListening: ${isListening},
currentNote: ${currentNote},
currentFrequency: ${currentFrequency},
centsDiff: ${centsDiff},
status: ${status}
    ''';
  }
}
