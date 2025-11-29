import 'package:mobx/mobx.dart';
import '../services/app_settings_service.dart';

part 'theme_store.g.dart';

class ThemeStore = ThemeStoreBase with _$ThemeStore;

abstract class ThemeStoreBase with Store {
  final AppSettingsService _settingsService;

  ThemeStoreBase(this._settingsService);

  @observable
  bool isDarkMode = true;

  @action
  Future<void> loadTheme() async {
    isDarkMode = await _settingsService.isDarkMode();
  }

  @action
  Future<void> toggleTheme(bool value) async {
    isDarkMode = value;
    await _settingsService.setDarkMode(value);
  }
}
