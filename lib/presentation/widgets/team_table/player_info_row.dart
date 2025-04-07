import 'package:carrermodetracker/config/theme/app_text_styles.dart';
import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//NOT A WIDGET
TableRow buildTableRow(BuildContext context, Player player,
    List<int> selectedSeasonIDs, List<int> selectedTournamentIDs) {
  final textStyles = Theme.of(context).textTheme;
  int totalGoals = 0;
  int totalMatches = 0;
  int totalAssist = 0;

  for (var element in player.stats) {
    bool seasonMatch = selectedSeasonIDs.isEmpty ||
        (element.season.value != null &&
            selectedSeasonIDs.contains(element.season.value!.id));
    bool tournamentMatch = selectedTournamentIDs.isEmpty ||
        (element.tournament.value != null &&
            selectedTournamentIDs.contains(element.tournament.value!.id));

    if (seasonMatch && tournamentMatch) {
      totalGoals += element.goals;
      totalAssist += element.assists;
      totalMatches += element.playedMatches;
    }
  }
  return TableRow(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    children: [
      TableCell(child: TableText(player.position)),
      TableCell(
          child: GestureDetector(
            onTap: () => context.push('/playerview/${player.id}'),
        child: Row(
          children: [
            const Icon(Icons.person),
            Flexible(child: Text(player.name, style: textStyles.tableBodyText)),
          ],
        ),
      )),
      TableCell(child: TableText(totalMatches.toString())),
      TableCell(child: TableText(totalGoals.toString())),
      TableCell(child: TableText(totalAssist.toString())),
    ],
  );
}
