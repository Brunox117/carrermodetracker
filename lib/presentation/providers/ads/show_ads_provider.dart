import 'package:carrermodetracker/plugins/shared_preferences_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const storeKey = 'showAds';
const probabilityKey = 'adsProbability';

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(false) {
    checkAdsState();
  }

  void checkAdsState() async {
    state = await SharePreferencesPlugin.getBool(storeKey) ?? true;
  }

  void removeAds() {
    SharePreferencesPlugin.setBool(storeKey, false);
    state = false;
  }

  void showAds() {
    SharePreferencesPlugin.setBool(storeKey, true);
    state = true;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }
}

class AdsProbabilityNotifier extends StateNotifier<double> {
  AdsProbabilityNotifier() : super(0.3) {
    checkProbabilityState();
  }

  void checkProbabilityState() async {
    final probability = await SharePreferencesPlugin.getDouble(probabilityKey);
    if (probability != null) {
      state = probability;
    }
  }

  void setProbability(double probability) {
    final clampedProbability = probability.clamp(0.0, 1.0);
    SharePreferencesPlugin.setDouble(probabilityKey, clampedProbability);
    state = clampedProbability;
  }
}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});

final adsProbabilityProvider =
    StateNotifierProvider<AdsProbabilityNotifier, double>((ref) {
  return AdsProbabilityNotifier();
});
