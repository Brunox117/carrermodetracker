import 'dart:math';
import 'package:carrermodetracker/plugins/admob_plugin.dart';
import 'package:carrermodetracker/plugins/shared_preferences_plugin.dart';

class InterstitialAdsService {
  static const String _probabilityKey = 'adsProbability';
  static const String _showAdsKey = 'showAds';

  // Shows an interstitial ad based on the configured probability
  // Returns true if the ad was shown, false otherwise
  static Future<bool> showInterstitialAdIfNeeded() async {
    // Check if ads are enabled
    final showAds = await SharePreferencesPlugin.getBool(_showAdsKey) ?? true;
    if (!showAds) return false;

    // Get current probability
    // final probability =
    //     await SharePreferencesPlugin.getDouble(_probabilityKey) ?? 0.3;
    const probability = 0.3;

    // Generate random number and check if we should show ad
    final random = Random();
    final shouldShowAd = random.nextDouble() < probability;
    if (shouldShowAd) {
      try {
        final ad = await AdmobPlugin.loadInterstitialAd();
        await ad.show();
        return true;
      } catch (e) {
        // Handle error silently or log it
        print('Error showing interstitial ad: $e');
        return false;
      }
    }

    return false;
  }

  /// Forces the display of an interstitial ad regardless of probability
  static Future<bool> forceShowInterstitialAd() async {
    try {
      final ad = await AdmobPlugin.loadInterstitialAd();
      await ad.show();
      return true;
    } catch (e) {
      // Handle error silently or log it
      print('Error showing interstitial ad: $e');
      return false;
    }
  }

  /// Gets the current probability for showing ads
  static Future<double> getProbability() async {
    return await SharePreferencesPlugin.getDouble(_probabilityKey) ?? 0.5;
  }

  /// Sets the probability for showing ads (0.0 to 1.0)
  static Future<void> setProbability(double probability) async {
    // Ensure probability is between 0.0 and 1.0
    final clampedProbability = probability.clamp(0.0, 1.0);
    await SharePreferencesPlugin.setDouble(_probabilityKey, clampedProbability);
  }

  /// Checks if ads are enabled
  static Future<bool> areAdsEnabled() async {
    return await SharePreferencesPlugin.getBool(_showAdsKey) ?? true;
  }
}
