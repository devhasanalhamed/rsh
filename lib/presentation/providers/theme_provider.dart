import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/core/services/storage_service.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDark = await StorageService.getThemeMode();
    state = isDark;
  }

  Future<void> toggleTheme() async {
    state = !state;
    await StorageService.setThemeMode(state);
  }
}
