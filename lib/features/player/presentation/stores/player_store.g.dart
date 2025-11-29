// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerStore on PlayerStoreBase, Store {
  Computed<double>? _$progressPercentageComputed;

  @override
  double get progressPercentage => (_$progressPercentageComputed ??=
          Computed<double>(() => super.progressPercentage,
              name: 'PlayerStoreBase.progressPercentage'))
      .value;
  Computed<String>? _$phaseLabelComputed;

  @override
  String get phaseLabel =>
      (_$phaseLabelComputed ??= Computed<String>(() => super.phaseLabel,
              name: 'PlayerStoreBase.phaseLabel'))
          .value;

  late final _$currentBpmAtom =
      Atom(name: 'PlayerStoreBase.currentBpm', context: context);

  @override
  int get currentBpm {
    _$currentBpmAtom.reportRead();
    return super.currentBpm;
  }

  @override
  set currentBpm(int value) {
    _$currentBpmAtom.reportWrite(value, super.currentBpm, () {
      super.currentBpm = value;
    });
  }

  late final _$currentPhaseAtom =
      Atom(name: 'PlayerStoreBase.currentPhase', context: context);

  @override
  PracticePhase get currentPhase {
    _$currentPhaseAtom.reportRead();
    return super.currentPhase;
  }

  @override
  set currentPhase(PracticePhase value) {
    _$currentPhaseAtom.reportWrite(value, super.currentPhase, () {
      super.currentPhase = value;
    });
  }

  late final _$elapsedTimeAtom =
      Atom(name: 'PlayerStoreBase.elapsedTime', context: context);

  @override
  Duration get elapsedTime {
    _$elapsedTimeAtom.reportRead();
    return super.elapsedTime;
  }

  @override
  set elapsedTime(Duration value) {
    _$elapsedTimeAtom.reportWrite(value, super.elapsedTime, () {
      super.elapsedTime = value;
    });
  }

  late final _$targetDurationAtom =
      Atom(name: 'PlayerStoreBase.targetDuration', context: context);

  @override
  Duration get targetDuration {
    _$targetDurationAtom.reportRead();
    return super.targetDuration;
  }

  @override
  set targetDuration(Duration value) {
    _$targetDurationAtom.reportWrite(value, super.targetDuration, () {
      super.targetDuration = value;
    });
  }

  late final _$isPlayingAtom =
      Atom(name: 'PlayerStoreBase.isPlaying', context: context);

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$togglePlayAsyncAction =
      AsyncAction('PlayerStoreBase.togglePlay', context: context);

  @override
  Future<void> togglePlay() {
    return _$togglePlayAsyncAction.run(() => super.togglePlay());
  }

  late final _$setBpmAsyncAction =
      AsyncAction('PlayerStoreBase.setBpm', context: context);

  @override
  Future<void> setBpm(int value) {
    return _$setBpmAsyncAction.run(() => super.setBpm(value));
  }

  late final _$PlayerStoreBaseActionController =
      ActionController(name: 'PlayerStoreBase', context: context);

  @override
  void initSession(Exercise exercise) {
    final _$actionInfo = _$PlayerStoreBaseActionController.startAction(
        name: 'PlayerStoreBase.initSession');
    try {
      return super.initSession(exercise);
    } finally {
      _$PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _tick() {
    final _$actionInfo = _$PlayerStoreBaseActionController.startAction(
        name: 'PlayerStoreBase._tick');
    try {
      return super._tick();
    } finally {
      _$PlayerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentBpm: ${currentBpm},
currentPhase: ${currentPhase},
elapsedTime: ${elapsedTime},
targetDuration: ${targetDuration},
isPlaying: ${isPlaying},
progressPercentage: ${progressPercentage},
phaseLabel: ${phaseLabel}
    ''';
  }
}
