import 'package:carrermodetracker/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeNotifierProvider = StateNotifierProvider<ThemeController, AppTheme>(
  (ref) => ThemeController(),
);

class ThemeController extends StateNotifier<AppTheme> {
  ThemeController() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void initializeTheme(bool isDarkMode) {
    state = state.copyWith(isDarkMode: isDarkMode);
  }
}
