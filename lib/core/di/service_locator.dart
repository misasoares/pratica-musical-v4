import 'package:get_it/get_it.dart';
import '../../core/services/app_settings_service.dart';
import '../../core/services/permission_service.dart';
import '../../features/player/data/audio_service_impl.dart';
import '../../features/player/domain/audio_service_interface.dart';
import '../../features/player/presentation/stores/player_store.dart';
import '../../features/tuner/presentation/stores/tuner_store.dart';
import '../theme/theme_store.dart';
import '../../features/settings/presentation/stores/settings_store.dart';
import '../../features/player/data/repositories/practice_repository_impl.dart';
import '../../features/player/domain/repositories/i_practice_repository.dart';

import '../../features/content/data/repositories/content_repository_impl.dart';
import '../../features/content/domain/repositories/i_content_repository.dart';
import '../../features/tuner/data/repositories/tuner_repository.dart';
import '../../features/tuner/domain/repositories/i_tuner_repository.dart';

import '../../features/home/presentation/stores/home_store.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/auth/data/datasources/firebase_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/i_auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/presentation/stores/auth_store.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Services
  getIt.registerLazySingleton<AudioService>(() => AudioServiceImpl());
  getIt.registerLazySingleton<AppSettingsService>(() => AppSettingsService());
  getIt.registerLazySingleton<PermissionService>(() => PermissionService());

  // Repositories
  getIt.registerLazySingleton<IPracticeRepository>(
      () => PracticeRepositoryImpl());
  getIt
      .registerLazySingleton<IContentRepository>(() => ContentRepositoryImpl());
  getIt.registerLazySingleton<ITunerRepository>(() => TunerRepository());

  // Stores
  getIt.registerLazySingleton<PlayerStore>(() => PlayerStore(
        getIt<AudioService>(),
        getIt<IPracticeRepository>(),
      ));
  getIt.registerLazySingleton<TunerStore>(
    () => TunerStore(getIt<ITunerRepository>()),
  );
  getIt.registerLazySingleton<ThemeStore>(
    () => ThemeStore(getIt<AppSettingsService>()),
  );
  getIt.registerLazySingleton<SettingsStore>(
    () => SettingsStore(
      getIt<AppSettingsService>(),
      getIt<IPracticeRepository>(),
    ),
  );
  getIt.registerFactory<HomeStore>(() => HomeStore(
        getIt<IContentRepository>(),
        getIt<IPracticeRepository>(),
      ));
  // Auth External
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => GoogleSignIn(scopes: ['email']));

  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  // Auth Data
  getIt.registerLazySingleton<IAuthDataSource>(() => FirebaseAuthDataSource(
        getIt(),
        getIt(),
      ));

  getIt.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(
        getIt(),
        getIt(),
      ));

  // Auth UseCases
  getIt.registerLazySingleton(() => LoginWithGoogleUseCase(getIt()));

  getIt.registerLazySingleton(() => LoginWithEmailUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterWithEmailUseCase(getIt()));
  getIt.registerLazySingleton(() => RecoverPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchAuthStateUseCase(getIt()));

  // Auth Store
  getIt.registerLazySingleton<AuthStore>(() => AuthStore(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
}
