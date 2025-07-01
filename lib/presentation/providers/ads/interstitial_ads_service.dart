import 'dart:math';
import 'package:carrermodetracker/plugins/admob_plugin.dart';
import 'package:carrermodetracker/plugins/shared_preferences_plugin.dart';
import 'package:flutter/foundation.dart';

class InterstitialAdsService {
  static const String _showAdsKey = 'showAds';

  static Future<bool> showInterstitialAdIfNeeded({double? probability}) async {
    final showAds = await SharePreferencesPlugin.getBool(_showAdsKey) ?? true;
    if (!showAds) return false;
    final probabilityToShowAd = probability ?? 0.3;
    final random = Random();
    final shouldShowAd = random.nextDouble() < probabilityToShowAd;

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
}
