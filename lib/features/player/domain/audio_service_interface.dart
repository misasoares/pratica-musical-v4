import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failure.dart';

abstract class AudioService {
  Future<Either<Failure, Unit>> play();
  Future<Either<Failure, Unit>> stop();
  Future<Either<Failure, Unit>> setBpm(int bpm);
}
