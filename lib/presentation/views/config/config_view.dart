import 'package:carrermodetracker/presentation/providers/config/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
              HapticFeedback.lightImpact();
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('isDarkMode', value);
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            },
          ),
          ListTile(
            title: const Text(
              'Cambiar color',
            ),
            onTap: () {
              colorPickerDialog(context, ref);
            },
          )
        ],
      ),
    );
  }
}

Future colorPickerDialog(BuildContext context, WidgetRef ref) {
  final colors = Theme.of(context).colorScheme;
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: SingleChildScrollView(
        child: BlockPicker(
          availableColors: const [
            Color(0xff29B6F6),
            Color(0xff4CAF50),
            Color(0xffF57F17),
            Color(0xffD50000),
            Color.fromARGB(255, 193, 110, 220),
          ],
          pickerColor: colors.primary,
          onColorChanged: (value) {
            print("$value");
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              padding: const EdgeInsets.only(
                  left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('CERRAR', style: TextStyle(color: colors.primary)),
        ),
      ],
    ),
  );
}
