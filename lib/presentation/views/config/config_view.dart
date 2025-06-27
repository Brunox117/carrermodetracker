import 'package:carrermodetracker/presentation/providers/ads/show_ads_provider.dart';
import 'package:carrermodetracker/presentation/providers/config/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigView extends ConsumerWidget {
  const ConfigView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appLocalizations = AppLocalizations.of(context)!;
    final themeState = ref.watch(themeNotifierProvider);
    final showAds = ref.watch(showAdsProvider);
    final adsInterval = ref.watch(adsIntervalProvider);

    bool isDarkMode = themeState.isDarkMode;
    Color selectedColor = themeState.seedColor;

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cambiar color',
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              colorPickerDialog(context, ref);
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text(
              'Mostrar anuncios',
            ),
            value: showAds,
            onChanged: (value) {
              HapticFeedback.lightImpact();
              if (value) {
                ref.read(showAdsProvider.notifier).showAds();
              } else {
                ref.read(showAdsProvider.notifier).removeAds();
              }
            },
          ),
          adsInterval.when(
            data: (interval) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'Selecciona cada cuántos minutos mostrar anuncios:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$interval minutos',
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          "Sobre el temporizador de anuncios"),
                                      content: const Text(
                                        'Los anuncios ayudan a mantener la app gratuita y con actualizaciones constantes. Puedes desactivarlos con una suscripción mensual o configurar su frecuencia. Si eliges menor frecuencia de anuncios, la app mostrará siempre un anuncio al iniciar.',
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: const Text("Entendido")),
                                        // FilledButton(
                                        //     onPressed: () {
                                        //       context.pop();
                                        //     },
                                        //     child: const Text("Suscribirse"))
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.info))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        Slider(
                          value: interval.toDouble(),
                          min: 5,
                          max: 15,
                          divisions: 1,
                          onChanged: (value) async {
                            final newInterval = value.toInt();
                            await ShowAdsNotifier.setAdsInterval(newInterval);
                            ref.invalidate(adsIntervalProvider);
                          },
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('5 min'),
                            Text('15 min'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const ListTile(
              title: Text('Cargando configuración...'),
            ),
            error: (error, stack) => ListTile(
              title: Text('Error: $error'),
            ),
          ),
        ],
      ),
    );
  }
}

Future colorPickerDialog(BuildContext context, WidgetRef ref) {
  final colors = Theme.of(context).colorScheme;
  final currentColor = ref.read(themeNotifierProvider).seedColor;

  const availableColors = [
    Color(0xff29B6F6),
    Color(0xff4CAF50),
    Color(0xffF57F17),
    Color(0xffD50000),
    Color.fromARGB(255, 193, 110, 220),
    Color.fromARGB(255, 176, 123, 39),
    Color.fromARGB(255, 11, 0, 212),
    Color.fromARGB(255, 255, 251, 0),
  ];

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Selecciona un color',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: availableColors.map((color) {
              final isSelected = color == currentColor;
              return GestureDetector(
                onTap: () async {
                  Navigator.of(context).pop();
                  await ref
                      .read(themeNotifierProvider.notifier)
                      .changeSeedColor(color);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              padding: const EdgeInsets.only(
                  left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCELAR', style: TextStyle(color: colors.primary)),
        ),
      ],
    ),
  );
}
