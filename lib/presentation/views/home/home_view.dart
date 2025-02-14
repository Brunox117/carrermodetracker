import 'package:carrermodetracker/presentation/widgets/home/team_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<TeamGeneralWidget> listaPrueba = [
  const TeamGeneralWidget(
    nombreEquipo: 'BVB',
  ),
  const TeamGeneralWidget(
    nombreEquipo: 'Real Madrid',
  ),
  const TeamGeneralWidget(
    nombreEquipo: 'FCB',
  ),
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.home_view_title),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: listaPrueba.length,
          itemBuilder: (context, index) {
            return listaPrueba[index];
          },
        ));
  }
}
