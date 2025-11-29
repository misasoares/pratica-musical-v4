import 'package:get_it/get_it.dart';
import '../../features/player/data/audio_service_impl.dart';
import '../../features/player/domain/audio_service_interface.dart';
import '../../features/player/presentation/stores/player_store.dart';

import '../../features/player/data/repositories/practice_repository_impl.dart';
import '../../features/player/domain/repositories/i_practice_repository.dart';

import '../../features/content/data/repositories/content_repository_impl.dart';
import '../../features/content/domain/repositories/i_content_repository.dart';
import '../../features/home/presentation/stores/home_store.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Services
  getIt.registerLazySingleton<AudioService>(() => AudioServiceImpl());

  // Repositories
  getIt.registerLazySingleton<IPracticeRepository>(
      () => PracticeRepositoryImpl());
  getIt
      .registerLazySingleton<IContentRepository>(() => ContentRepositoryImpl());

  // Stores
  getIt.registerLazySingleton<PlayerStore>(() => PlayerStore(
        getIt<AudioService>(),
        getIt<IPracticeRepository>(),
      ));
  getIt
      .registerFactory<HomeStore>(() => HomeStore(getIt<IContentRepository>()));
}
