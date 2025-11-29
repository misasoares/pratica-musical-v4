import 'package:get_it/get_it.dart';
import '../../features/player/data/audio_service_impl.dart';
import '../../features/player/domain/audio_service_interface.dart';
import '../../features/player/presentation/stores/player_store.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Services
  getIt.registerLazySingleton<AudioService>(() => AudioServiceImpl());

  // Stores
  getIt.registerLazySingleton<PlayerStore>(
      () => PlayerStore(getIt<AudioService>()));
}
