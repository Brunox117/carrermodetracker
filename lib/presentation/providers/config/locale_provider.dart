import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateProvider<Locale>((ref) {
  // Obtener idioma del dispositivo o guardado en preferencias
  return const Locale('es'); // Valor inicial
});

// Método para cambiar el idioma
void changeLanguage(BuildContext context, Locale newLocale) {
  final ref = ProviderScope.containerOf(context);
  ref.read(localeProvider.notifier).state = newLocale;
}
