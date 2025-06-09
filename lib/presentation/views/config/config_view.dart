import 'package:carrermodetracker/presentation/providers/config/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigView extends ConsumerWidget {
  const ConfigView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = AppLocalizations.of(context)!;
    bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.config_view_title),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(
            height: 5,
          ),
          SwitchListTile(
            title: const Text(
              'Modo oscuro',
            ),
            value: isDarkMode,
            onChanged: (value) async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('isDarkMode', value);
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            },
          ),
        ],
      ),
    );
  }
}
