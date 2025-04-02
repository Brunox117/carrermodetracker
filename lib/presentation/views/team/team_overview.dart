import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/player_info_row.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamOverview extends ConsumerStatefulWidget {
  final String id;
  const TeamOverview({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeamOverviewState();
}

class _TeamOverviewState extends ConsumerState<TeamOverview> {
  @override
  void initState() {
    super.initState();
    ref.read(playersProvider.notifier).getPlayersByTeam(int.parse(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.read(playersProvider).values.toList();
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.1), // Posición
          1: FlexColumnWidth(2), // Nombre
          2: FlexColumnWidth(.9), // PJ
          3: FlexColumnWidth(.9), // Goles
          4: FlexColumnWidth(.9), // As.
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
              decoration: BoxDecoration(
                  color: colors.secondary.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              children: const [
                TableCell(
                    child: TableText(
                  'Posición',
                  isHeader: true,
                )),
                TableCell(
                    child: TableText(
                  'Nombre',
                  isHeader: true,
                )),
                TableCell(
                    child: TableText(
                  'PJ',
                  isHeader: true,
                )),
                TableCell(
                    child: TableText(
                  'Goles',
                  isHeader: true,
                )),
                TableCell(
                    child: TableText(
                  'As.',
                  isHeader: true,
                )),
                // TableCell(child: Center(child: Text('PI'))),
              ]),
          ...players.map((player) => buildTableRow(context, player)),
        ],
      ),
    );
  }
}
