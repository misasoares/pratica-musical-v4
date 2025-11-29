import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import '../../domain/audio_service_interface.dart';
import '../../domain/exercise.dart';
import '../../domain/practice_phase.dart';

part 'player_store.g.dart';

class PlayerStore = PlayerStoreBase with _$PlayerStore;

abstract class PlayerStoreBase with Store {
  final AudioService _audioService;
  Timer? _timer;

  PlayerStoreBase(this._audioService);

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

  @computed
  double get progressPercentage {
    if (targetDuration.inSeconds == 0) return 0;
    return (elapsedTime.inSeconds / targetDuration.inSeconds).clamp(0.0, 1.0);
  }

  @computed
  String get phaseLabel => currentPhase.label;

  @action
  void initSession(Exercise exercise) {
    currentBpm = exercise
        .targetBpm; // Start with target or warmup BPM? Assuming target for now or logic to be added.
    targetDuration = exercise.duration;
    elapsedTime = Duration.zero;
    currentPhase = PracticePhase.warmup;
    isPlaying = false;
    _timer?.cancel();
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
      currentPhase = PracticePhase.finished;
      togglePlay(); // Stop when finished
    } else if (progress < 0.1) {
      currentPhase = PracticePhase.warmup;
    } else if (progress < 0.2) {
      currentPhase = PracticePhase.calibration;
    } else {
      currentPhase = PracticePhase.training;
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
