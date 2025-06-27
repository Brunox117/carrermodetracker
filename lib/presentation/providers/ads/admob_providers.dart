import 'package:carrermodetracker/plugins/admob_plugin.dart';
import 'package:carrermodetracker/presentation/providers/ads/show_ads_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';

final adInterstitialProvider =
    FutureProvider.autoDispose<InterstitialAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw 'Ads bloqueados';
  final ad = await AdmobPlugin.loadInterstitialAd();

  return ad;
});

class InterstitialAdsTimerNotifier extends StateNotifier<Timer?> {
  InterstitialAdsTimerNotifier() : super(null);

  void startInterstitialTimer({
    required int intervalMinutes,
    required bool showAds,
    required VoidCallback onShowAd,
  }) {
    state?.cancel();

    if (!showAds) return;

    state = Timer.periodic(Duration(minutes: intervalMinutes), (timer) async {
      try {
        onShowAd();
      } catch (e) {
        debugPrint('Error showing interstitial ad: $e');
      }
    });
  }

  void stopInterstitialTimer() {
    state?.cancel();
    state = null;
  }

  void resetInterstitialTimer() {
    stopInterstitialTimer();
  }

  @override
  void dispose() {
    state?.cancel();
    super.dispose();
  }
}

final interstitialAdsTimerProvider =
    StateNotifierProvider<InterstitialAdsTimerNotifier, Timer?>((ref) {
  return InterstitialAdsTimerNotifier();
});
