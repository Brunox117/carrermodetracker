import 'package:carrermodetracker/config/router/app_router.dart';
import 'package:carrermodetracker/config/theme/app_theme.dart';
import 'package:carrermodetracker/presentation/providers/config/locale_provider.dart';
import 'package:carrermodetracker/presentation/providers/config/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    final locale = ref.watch(localeProvider);
    return MaterialApp.router(
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      routerConfig: appRouter,
    );
  }
}
