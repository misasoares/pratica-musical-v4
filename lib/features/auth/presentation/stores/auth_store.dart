import 'package:mobx/mobx.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecases.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LoginWithGoogleUseCase _loginWithGoogle;

  final LoginWithEmailUseCase _loginWithEmail;
  final RegisterWithEmailUseCase _registerWithEmail;
  final RecoverPasswordUseCase _recoverPassword;
  final LogoutUseCase _logout;
  final GetCurrentUserUseCase _getCurrentUser;
  final WatchAuthStateUseCase _watchAuthState;

  AuthStoreBase(
    this._loginWithGoogle,
    this._loginWithEmail,
    this._registerWithEmail,
    this._recoverPassword,
    this._logout,
    this._getCurrentUser,
    this._watchAuthState,
  ) {
    _init();
  }

  @observable
  AuthUser? user;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> _init() async {
    user = await _getCurrentUser();
    _watchAuthState().listen((newUser) {
      user = newUser;
    });
  }

  @action
  Future<void> loginWithGoogle() async {
    isLoading = true;
    errorMessage = null;
    final result = await _loginWithGoogle();
    result.fold(
      (l) => errorMessage = l,
      (r) => user = r,
    );
    isLoading = false;
  }

  @action
  Future<void> loginWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    final result = await _loginWithEmail(email, password);
    result.fold(
      (l) => errorMessage = l,
      (r) => user = r,
    );
    isLoading = false;
  }

  @action
  Future<void> registerWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    final result = await _registerWithEmail(email, password);
    result.fold(
      (l) => errorMessage = l,
      (r) => user = r,
    );
    isLoading = false;
  }

  @action
  Future<void> recoverPassword(String email) async {
    isLoading = true;
    errorMessage = null;
    final result = await _recoverPassword(email);
    result.fold(
      (l) => errorMessage = l,
      (r) => null, // Success
    );
    isLoading = false;
  }

  @action
  Future<void> logout() async {
    isLoading = true;
    await _logout();
    user = null;
    isLoading = false;
  }
}
