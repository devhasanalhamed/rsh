import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _presetTimersKey = 'present_timers';
  static const String _themeKey = 'is_dark_mode';

  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // Theme storage
  static Future<bool> getThemeMode() async {
    final prefs = await _prefs;
    return prefs.getBool(_themeKey) ?? false;
  }

  static Future<void> setThemeMode(bool isDark) async {
    final prefs = await _prefs;
    prefs.setBool(_themeKey, isDark);
  }

  // Present timers storage
  static Future<List<String>> getPresetTimers() async {
    final prefs = await _prefs;
    return prefs.getStringList(_presetTimersKey) ?? [];
  }

  static Future<void> savePresetTimers(List<String> presets) async {
    final prefs = await _prefs;
    await prefs.setStringList(_presetTimersKey, presets);
  }
}
