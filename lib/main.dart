import 'package:carrermodetracker/config/router/app_router.dart';
import 'package:carrermodetracker/config/theme/app_theme.dart';
import 'package:carrermodetracker/plugins/admob_plugin.dart';
import 'package:carrermodetracker/presentation/providers/ads/admob_providers.dart';
import 'package:carrermodetracker/presentation/providers/ads/show_ads_provider.dart';
import 'package:carrermodetracker/presentation/providers/config/locale_provider.dart';
import 'package:carrermodetracker/presentation/providers/config/theme_provider.dart';
import 'package:carrermodetracker/presentation/providers/manager/managers_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_tournament_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdmobPlugin.initialize();
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeInterstitialAdsTimer();
    });
  }

  void _initializeInterstitialAdsTimer() async {
    final showAds = ref.read(showAdsProvider);
    final intervalMinutes = await ref.read(adsIntervalProvider.future);

    ref.read(interstitialAdsTimerProvider.notifier).startInterstitialTimer(
          intervalMinutes: intervalMinutes,
          showAds: showAds,
          onShowAd: () async {
            try {
              final ad = await ref.read(adInterstitialProvider.future);
              await ad.show();
            } catch (e) {
              debugPrint('Error showing interstitial ad: $e');
            }
          },
        );
  }

  void _restartInterstitialTimer() async {
    final showAds = ref.read(showAdsProvider);
    final intervalMinutes = await ref.read(adsIntervalProvider.future);

    ref.read(interstitialAdsTimerProvider.notifier).startInterstitialTimer(
          intervalMinutes: intervalMinutes,
          showAds: showAds,
          onShowAd: () async {
            try {
              final ad = await ref.read(adInterstitialProvider.future);
              await ad.show();
            } catch (e) {
              debugPrint('Error showing interstitial ad: $e');
            }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(showAdsProvider, (previous, next) {
      if (previous != next) {
        _restartInterstitialTimer();
      }
    });

    ref.listen(adsIntervalProvider, (previous, next) {
      if (previous != next) {
        _restartInterstitialTimer();
      }
    });

    ref.read(teamsProvider.notifier).loadNextPage();
    ref.read(managersProvider.notifier).getManager();
    ref.read(managerStatsProvider.notifier).loadNextPage();
    ref.read(managerTournamentStatsProvider.notifier).loadNextPage();

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
