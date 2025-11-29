import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failure.dart';
import '../domain/audio_service_interface.dart';

class AudioServiceImpl implements AudioService {
  static const _channel = MethodChannel('com.antigravity.guitarmaster/audio');

  @override
  Future<Either<Failure, Unit>> play() async {
    try {
      await _channel.invokeMethod('play');
      return right(unit);
    } on PlatformException catch (e) {
      return left(AudioFailure(e.message ?? 'Unknown error playing audio'));
    } catch (e) {
      return left(AudioFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> stop() async {
    try {
      await _channel.invokeMethod('stop');
      return right(unit);
    } on PlatformException catch (e) {
      return left(AudioFailure(e.message ?? 'Unknown error stopping audio'));
    } catch (e) {
      return left(AudioFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setBpm(int bpm) async {
    try {
      await _channel.invokeMethod('setBpm', {'bpm': bpm});
      return right(unit);
    } on PlatformException catch (e) {
      return left(AudioFailure(e.message ?? 'Unknown error setting BPM'));
    } catch (e) {
      return left(AudioFailure(e.toString()));
    }
  }
}
