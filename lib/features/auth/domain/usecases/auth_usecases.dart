import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class LoginWithGoogleUseCase {
  final IAuthRepository _repository;
  LoginWithGoogleUseCase(this._repository);

  Future<Either<String, AuthUser>> call() => _repository.loginWithGoogle();
}

class LoginWithEmailUseCase {
  final IAuthRepository _repository;
  LoginWithEmailUseCase(this._repository);

  Future<Either<String, AuthUser>> call(String email, String password) =>
      _repository.loginWithEmail(email, password);
}

class RegisterWithEmailUseCase {
  final IAuthRepository _repository;
  RegisterWithEmailUseCase(this._repository);

  Future<Either<String, AuthUser>> call(String email, String password) =>
      _repository.registerWithEmail(email, password);
}

class RecoverPasswordUseCase {
  final IAuthRepository _repository;
  RecoverPasswordUseCase(this._repository);

  Future<Either<String, Unit>> call(String email) =>
      _repository.recoverPassword(email);
}

class LogoutUseCase {
  final IAuthRepository _repository;
  LogoutUseCase(this._repository);

  Future<Either<String, Unit>> call() => _repository.logout();
}

class GetCurrentUserUseCase {
  final IAuthRepository _repository;
  GetCurrentUserUseCase(this._repository);

  Future<AuthUser?> call() => _repository.currentUser;
}

class WatchAuthStateUseCase {
  final IAuthRepository _repository;
  WatchAuthStateUseCase(this._repository);

  Stream<AuthUser?> call() => _repository.authStateChanges;
}
