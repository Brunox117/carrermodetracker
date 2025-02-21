import 'package:carrermodetracker/presentation/widgets/home/add_team_view.dart';
import 'package:carrermodetracker/presentation/widgets/home/team_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Widget> listaPrueba = [
  const TeamGeneralWidget(
    nombreEquipo: 'BVB',
    id: "1",
  ),
  const TeamGeneralWidget(
    nombreEquipo: 'Real Madrid',
    id: "2",
  ),
  const TeamGeneralWidget(
    nombreEquipo: 'FCB',
    id: "3",
  ),
  const AddTeamButton(),
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
