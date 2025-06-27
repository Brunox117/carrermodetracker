import 'package:carrermodetracker/plugins/shared_preferences_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const storeKey = 'showAds';
const intervalKey = 'adsInterval';

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

  static Future<int> getAdsInterval() async {
    int interval = await SharePreferencesPlugin.getInt(intervalKey) ?? 5;
    print("se muestran anuncios cada: $interval");
    return interval;
  }

  static Future<void> setAdsInterval(int minutes) async {
    await SharePreferencesPlugin.setInt(intervalKey, minutes);
  }
}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});

final adsIntervalProvider = FutureProvider<int>((ref) async {
  return await ShowAdsNotifier.getAdsInterval();
});
