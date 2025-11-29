import 'dart:math';

class NoteCalculator {
  static const List<String> noteNames = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B'
  ];

  /// Returns the note name (e.g., "A", "C#") closest to the frequency.
  String getNoteFromFrequency(double frequency) {
    final noteNum = 12 * (log(frequency / 440) / log(2));
    final roundedNote = (noteNum.round() + 69).toInt();
    return noteNames[roundedNote % 12];
  }

  /// Returns the difference in cents from the closest perfect note.
  /// Range: -50 to +50
  double getCentsDiff(double frequency) {
    final noteNum = 12 * (log(frequency / 440) / log(2));
    final roundedNote = noteNum.round();
    final diff = noteNum - roundedNote;
    return diff * 100;
  }

  /// Returns the octave of the note
  int getOctave(double frequency) {
    final noteNum = 12 * (log(frequency / 440) / log(2));
    final roundedNote = (noteNum.round() + 69).toInt();
    return (roundedNote / 12).floor() - 1;
  }
}
