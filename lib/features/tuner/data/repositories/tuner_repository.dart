import 'package:flutter/foundation.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import '../../domain/repositories/i_tuner_repository.dart';

class TunerRepository implements ITunerRepository {
  final FlutterAudioCapture _audioCapture = FlutterAudioCapture();
  final PitchDetector _pitchDetector = PitchDetector();
  Function(double frequency)? _onNoteDetected;

  @override
  Future<void> startListening(Function(double frequency) onNoteDetected) async {
    _onNoteDetected = onNoteDetected;
    await _audioCapture.init();
    await _audioCapture.start(_listener, _onError,
        sampleRate: 44100, bufferSize: 3000);
  }

  @override
  Future<void> stopListening() async {
    await _audioCapture.stop();
  }

  Future<void> _listener(dynamic obj) async {
    // flutter_audio_capture returns Float64List or Float32List depending on platform
    // We need to convert to List<double> for pitch_detector_dart
    final buffer = Float64List.fromList(obj.cast<double>());
    final List<double> audioSample = buffer.toList();

    final result = await _pitchDetector.getPitchFromFloatBuffer(audioSample);

    if (result.pitched && _onNoteDetected != null) {
      _onNoteDetected!(result.pitch);
    }
  }

  void _onError(Object e) {
    debugPrint('Error capturing audio: $e');
  }
}
