import 'package:hive/hive.dart';

class AppSettingsService {
  static const String _boxName = 'app_settings';
  static const String _keyHasSeenPracticeOnboarding =
      'hasSeenPracticeOnboarding';

  Future<Box> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }
    return await Hive.openBox(_boxName);
  }

  Future<bool> hasSeenPracticeOnboarding() async {
    final box = await _getBox();
    return box.get(_keyHasSeenPracticeOnboarding, defaultValue: false);
  }

  Future<void> setSeenPracticeOnboarding() async {
    final box = await _getBox();
    await box.put(_keyHasSeenPracticeOnboarding, true);
  }
}
