import 'dart:math';
import 'package:carrermodetracker/plugins/admob_plugin.dart';
import 'package:carrermodetracker/plugins/shared_preferences_plugin.dart';
import 'package:flutter/foundation.dart';

class InterstitialAdsService {
  static const String _probabilityKey = 'adsProbability';
  static const String _showAdsKey = 'showAds';

  static Future<bool> showInterstitialAdIfNeeded(
      {double? probabilityToShowAd}) async {
    final showAds = await SharePreferencesPlugin.getBool(_showAdsKey) ?? true;
    if (!showAds) return false;

    final probability = probabilityToShowAd ?? 0.3;

    final random = Random();
    final shouldShowAd = random.nextDouble() < probability;
    if (shouldShowAd) {
      try {
        final ad = await AdmobPlugin.loadInterstitialAd();
        await ad.show();
        return true;
      } catch (e) {
        debugPrint('Error showing interstitial ad: $e');
        return false;
      }
    }

    return false;
  }

  static Future<bool> forceShowInterstitialAd() async {
    try {
      final ad = await AdmobPlugin.loadInterstitialAd();
      await ad.show();
      return true;
    } catch (e) {
      debugPrint('Error showing interstitial ad: $e');
      return false;
    }
  }

  static Future<double> getProbability() async {
    return await SharePreferencesPlugin.getDouble(_probabilityKey) ?? 0.5;
  }

  static Future<void> setProbability(double probability) async {
    final clampedProbability = probability.clamp(0.0, 1.0);
    await SharePreferencesPlugin.setDouble(_probabilityKey, clampedProbability);
  }

  static Future<bool> areAdsEnabled() async {
    return await SharePreferencesPlugin.getBool(_showAdsKey) ?? true;
  }
}
