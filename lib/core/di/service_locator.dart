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
}
