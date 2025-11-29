abstract class ITunerRepository {
  Future<void> startListening(Function(double frequency) onNoteDetected);
  Future<void> stopListening();
}
