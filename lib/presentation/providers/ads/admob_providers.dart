import 'package:carrermodetracker/plugins/admob_plugin.dart';
import 'package:carrermodetracker/presentation/providers/ads/show_ads_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final adInterstitialProvider =
    FutureProvider.autoDispose<InterstitialAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw 'Ads bloqueados';
  final ad = await AdmobPlugin.loadInterstitialAd();

  return ad;
});
