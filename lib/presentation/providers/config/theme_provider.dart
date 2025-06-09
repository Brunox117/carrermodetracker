import 'package:carrermodetracker/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeController, AppTheme>(
  (ref) => ThemeController(),
);

class ThemeController extends StateNotifier<AppTheme> {
  ThemeController() : super(AppTheme()) {
    initializeTheme();
  }

  static const String _themeKey = 'isDarkMode';

  Future<void> toggleDarkMode() async {
    final newState = state.copyWith(isDarkMode: !state.isDarkMode);
    state = newState;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, newState.isDarkMode);
    } catch (e) {
      state = state.copyWith(isDarkMode: !newState.isDarkMode);
      rethrow;
    }
  }

  Future<void> initializeTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;
      state = state.copyWith(isDarkMode: isDarkMode);
    } catch (e) {
      // Si hay un error al leer, mantenemos el tema por defecto
      state = state.copyWith(isDarkMode: false);
    }
  }
}