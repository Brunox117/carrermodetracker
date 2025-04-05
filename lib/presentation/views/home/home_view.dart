import 'package:carrermodetracker/presentation/providers/teams/teams_provider.dart';
import 'package:carrermodetracker/presentation/widgets/home/add_team_button.dart';
import 'package:carrermodetracker/presentation/widgets/home/team_general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsMap = ref.watch(teamsProvider);
    final teams = teamsMap.values.toList();

    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref.read(teamsProvider.notifier).loadNextPage();
      }
    });

    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)!.home_view_title)),
      body: GridView.builder(
        controller: scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: teams.length + 1,
        itemBuilder: (context, index) {
          if (index == teams.length) {
            return const AddTeamButton();
          } else if (index >= teams.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final team = teams[index];
          return TeamGeneralWidget(
            nombreEquipo: team.acronimos,
            id: team.id.toString(),
            logoURL: team.logoURL,
          );
        },
      ),
    );
  }
}
