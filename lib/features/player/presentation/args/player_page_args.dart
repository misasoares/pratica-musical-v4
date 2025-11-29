import '../../../content/domain/entities/exercise.dart';
import '../../../content/domain/entities/schedule.dart';

class PlayerPageArgs {
  final Exercise exercise;
  final Schedule? currentSchedule;
  final int exerciseIndex;

  PlayerPageArgs({
    required this.exercise,
    this.currentSchedule,
    this.exerciseIndex = 0,
  });
}
