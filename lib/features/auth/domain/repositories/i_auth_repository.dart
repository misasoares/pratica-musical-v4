import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';

abstract class IAuthRepository {
  Stream<AuthUser?> get authStateChanges;
  Future<AuthUser?> get currentUser;

  Future<Either<String, AuthUser>> loginWithGoogle();

  Future<Either<String, AuthUser>> loginWithEmail(
      String email, String password);
  Future<Either<String, AuthUser>> registerWithEmail(
      String email, String password);
  Future<Either<String, Unit>> recoverPassword(String email);
  Future<Either<String, Unit>> logout();
}
