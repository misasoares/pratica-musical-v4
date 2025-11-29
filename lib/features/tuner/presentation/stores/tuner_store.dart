import 'package:mobx/mobx.dart';
import '../../domain/repositories/i_tuner_repository.dart';
import '../../domain/note_calculator.dart';

part 'tuner_store.g.dart';

class TunerStore = TunerStoreBase with _$TunerStore;

enum TunerStatus { flat, sharp, inTune, none }

abstract class TunerStoreBase with Store {
  final ITunerRepository _repository;
  final NoteCalculator _noteCalculator = NoteCalculator();

  TunerStoreBase(this._repository);

  @observable
  bool isListening = false;

  @observable
  String currentNote = '-';

  @observable
  double currentFrequency = 0.0;

  @observable
  double centsDiff = 0.0;

  @observable
  TunerStatus status = TunerStatus.none;

  @action
  Future<void> start() async {
    if (isListening) return;
    isListening = true;
    await _repository.startListening((frequency) {
      _processFrequency(frequency);
    });
  }

  @action
  Future<void> stop() async {
    if (!isListening) return;
    await _repository.stopListening();
    isListening = false;
    currentNote = '-';
    status = TunerStatus.none;
    centsDiff = 0.0;
  }

  @action
  void _processFrequency(double frequency) {
    if (frequency < 20) return; // Ignore low noise

    currentFrequency = frequency;
    currentNote = _noteCalculator.getNoteFromFrequency(frequency);
    centsDiff = _noteCalculator.getCentsDiff(frequency);

    if (centsDiff.abs() < 5) {
      status = TunerStatus.inTune;
    } else if (centsDiff < 0) {
      status = TunerStatus.flat;
    } else {
      status = TunerStatus.sharp;
    }
  }
}
