import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import '../../data/models/practice_log_model.dart';
import '../../domain/audio_service_interface.dart';
import '../../domain/repositories/i_practice_repository.dart';
import '../../../content/domain/entities/exercise.dart';
import '../../domain/practice_phase.dart';

part 'player_store.g.dart';

class PlayerStore = PlayerStoreBase with _$PlayerStore;

abstract class PlayerStoreBase with Store {
  final AudioService _audioService;
  final IPracticeRepository _repository;
  Timer? _timer;

  PlayerStoreBase(this._audioService, this._repository);

  @observable
  int currentBpm = 60;

  @observable
  PracticePhase currentPhase = PracticePhase.warmup;

  @observable
  Duration elapsedTime = Duration.zero;

  @observable
  Duration targetDuration = const Duration(minutes: 5);

  @observable
  bool isPlaying = false;

  // Track the exercise for saving logs
  Exercise? _currentExercise;
  int _maxBpmReached = 0;

  @computed
  double get progressPercentage {
    if (targetDuration.inSeconds == 0) return 0;
    return (elapsedTime.inSeconds / targetDuration.inSeconds).clamp(0.0, 1.0);
  }

  @computed
  String get phaseLabel => currentPhase.label;

  @action
  Future<void> initSession(Exercise exercise) async {
    _currentExercise = exercise;
    // Default to 5 minutes if not specified (new entity doesn't have total duration yet)
    targetDuration = const Duration(minutes: 5);
    elapsedTime = Duration.zero;
    currentPhase = PracticePhase.warmup;
    isPlaying = false;
    _timer?.cancel();
    _maxBpmReached = 0;

    // Load last log to determine target BPM
    final lastLog = await _repository.getLastLog(exercise.id);
    if (lastLog != null) {
      // Logic: If last session was success, maybe increase BPM?
      // For now, just restore the target.
      currentBpm = lastLog.targetBpm;
      debugPrint('Restored BPM from history: $currentBpm');
    } else {
      currentBpm = exercise.startBpmCalibration; // Default/Calibration
      debugPrint('No history found, using default BPM: $currentBpm');
    }
  }

  @action
  Future<void> togglePlay() async {
    if (isPlaying) {
      final result = await _audioService.stop();
      result.fold(
        (l) => debugPrint(
            'Error stopping: ${l.message}'), // In real app, handle error state
        (r) {
          isPlaying = false;
          _timer?.cancel();
        },
      );
    } else {
      final result = await _audioService.play();
      result.fold(
        (l) => debugPrint('Error playing: ${l.message}'),
        (r) {
          isPlaying = true;
          _startTimer();
        },
      );
    }
  }

  @action
  Future<void> setBpm(int value) async {
    currentBpm = value;
    if (value > _maxBpmReached) {
      _maxBpmReached = value;
    }
    if (isPlaying) {
      await _audioService.setBpm(value);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _tick();
    });
  }

  @action
  void _tick() {
    elapsedTime += const Duration(seconds: 1);

    // Simple phase transition logic for demo purposes
    // Warmup (first 10%) -> Calibration (next 10%) -> Training (rest) -> Finished
    final progress = progressPercentage;

    if (progress >= 1.0 && currentPhase != PracticePhase.finished) {
      unawaited(_finishSession());
    } else if (progress < 0.1) {
      currentPhase = PracticePhase.warmup;
    } else if (progress < 0.2) {
      currentPhase = PracticePhase.calibration;
    } else {
      currentPhase = PracticePhase.training;
    }
  }

  @action
  Future<void> _finishSession() async {
    currentPhase = PracticePhase.finished;
    await togglePlay();

    if (_currentExercise != null) {
      final log = PracticeLogModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple ID
        exerciseId: _currentExercise!.id,
        date: DateTime.now(),
        mode: 'training', // Simplified
        maxBpmReached: _maxBpmReached > 0 ? _maxBpmReached : currentBpm,
        durationSeconds: elapsedTime.inSeconds,
        result: 'success',
        targetBpm: currentBpm,
      );
      await _repository.saveLog(log);
      debugPrint('Session saved to Hive');
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
