import 'package:flutter/material.dart';

const seedColor = Colors.lightBlue;

class AppTheme {
  final bool isDarkMode;
  AppTheme({this.isDarkMode = false});
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      brightness: isDarkMode ? Brightness.dark : Brightness.light
      //EJEMPLO DE COMO SOBRESCRIBIR EL TEMA DE LOS TEXTOS
      // textTheme: const TextTheme(
      //   displayLarge: TextStyle(
      //     fontSize: 32,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.black, // Color para modo claro
      //   ),
      // ),
      //EJEMPLO DE COMO SOBRESCRIBIR LOS TEMA ESPECIFICOS DE ALGUN WIDGET
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: Colors.red,
      //     foregroundColor: Colors.white,
      //     elevation: 2,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //   ),
      // ),
      );

  AppTheme copyWith({bool? isDarkMode}) =>
      AppTheme(isDarkMode: isDarkMode ?? this.isDarkMode);
}
