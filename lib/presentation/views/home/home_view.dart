import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/widgets/home/add_team_button.dart';
import 'package:carrermodetracker/presentation/widgets/home/team_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  bool isLoading = false;
  List<Team> teams = [];
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    setState(() {
      isLoading = true;
    });
    await ref.read(teamsProvider.notifier).loadNextPage();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final teamsMap = ref.watch(teamsProvider);
    teams = teamsMap.values.toList();
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.home_view_title),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: teams.length + 1,
          itemBuilder: (context, index) {
            if (index == teams.length) {
              return const AddTeamButton();
            }
            Team team = teams[index];
            return TeamGeneralWidget(
              nombreEquipo: team.acronimos,
              id: team.id.toString(),
              logoURL: team.logoURL,
            );
          },
        ));
  }
}
