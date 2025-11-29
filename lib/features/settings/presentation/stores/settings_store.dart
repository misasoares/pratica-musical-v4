import 'package:mobx/mobx.dart';
import '../../../../core/services/app_settings_service.dart';
import '../../../player/domain/repositories/i_practice_repository.dart';

part 'settings_store.g.dart';

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  final AppSettingsService _appSettingsService;
  final IPracticeRepository _practiceRepository;

  SettingsStoreBase(this._appSettingsService, this._practiceRepository);

  @observable
  bool isLoading = false;

  @action
  Future<void> resetProgress() async {
    isLoading = true;
    try {
      await _practiceRepository.clearAllLogs();
      await _appSettingsService.resetOnboarding();
    } finally {
      isLoading = false;
    }
  }
}
