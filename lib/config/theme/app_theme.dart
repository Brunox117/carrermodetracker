import 'package:flutter/material.dart';

const seedColor = Color.fromARGB(255, 193, 110, 220);

class AppTheme {
  final bool isDarkMode;
  AppTheme({this.isDarkMode = false});
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        textTheme: _buildCustomTextTheme(isDarkMode),
      );

  AppTheme copyWith({bool? isDarkMode}) =>
      AppTheme(isDarkMode: isDarkMode ?? this.isDarkMode);
}

TextTheme _buildCustomTextTheme(bool isDarkMode) {
  final baseTextTheme = isDarkMode
      ? Typography.material2018().white
      : Typography.material2018().black;

  return baseTextTheme.copyWith(
    bodyMedium: baseTextTheme.bodyMedium?.merge(
      const TextStyle(fontSize: 14),
    ),
  );
}
