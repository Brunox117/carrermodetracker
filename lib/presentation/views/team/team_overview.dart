import 'package:carrermodetracker/presentation/widgets/team_table/player_info_row.dart';
import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
import 'package:flutter/material.dart';

class TeamOverview extends StatelessWidget {
  final String id;
  const TeamOverview({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.1), // Posición
            1: FlexColumnWidth(2), // Nombre 
            2: FlexColumnWidth(1), // PJ
            3: FlexColumnWidth(1), // Goles
            4: FlexColumnWidth(1), // As.
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
            buildTableRow(context),
          ],
        ),
      ),
    );
  }
}
