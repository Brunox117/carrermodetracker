import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/widgets/home/add_team_button.dart';
import 'package:carrermodetracker/presentation/widgets/home/team_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    setState(() {
      isLoading = true;
    });
    final teams = ref.read(teamsProvider.notifier).loadNextPage();
    setState(() {
      isLoading = false;
    });
  }

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
