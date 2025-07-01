import 'package:carrermodetracker/presentation/providers/ads/interstitial_ads_service.dart';
import 'package:drops/drops.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaveFormButton extends StatelessWidget {
  final void Function() submitForm;
  final String? onSaveTextAlert;
  const SaveFormButton({
    super.key,
    required this.submitForm,
    this.onSaveTextAlert,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: IconButton(
        onPressed: () async {
          HapticFeedback.mediumImpact();
          submitForm();
          if (onSaveTextAlert != null) {
            Drops.show(
              shape: DropShape.squared,
              context,
              title: onSaveTextAlert!,
            );
          }
          await InterstitialAdsService.showInterstitialAdIfNeeded();
        },
        icon: Icon(
          Icons.save,
          size: 70,
          color: colors.secondary,
        ),
      ),
    );
  }
}
