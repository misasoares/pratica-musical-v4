enum PracticePhase {
  warmup,
  calibration,
  training,
  finished;

  String get label {
    switch (this) {
      case PracticePhase.warmup:
        return 'Aquecimento';
      case PracticePhase.calibration:
        return 'Calibragem';
      case PracticePhase.training:
        return 'Treino';
      case PracticePhase.finished:
        return 'Concluído';
    }
  }
}
