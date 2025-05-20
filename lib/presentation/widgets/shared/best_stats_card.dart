import 'package:flutter/material.dart';

class BestStatsCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> players;
  final String statKey;
  final bool useTable;

  const BestStatsCard({
    super.key,
    required this.title,
    required this.players,
    required this.statKey,
    this.useTable = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textStyles.titleMedium),
            const SizedBox(height: 8),
            if (useTable)
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  ...players.map((player) {
                    return TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            player['name'],
                            style: textStyles.bodyMedium,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            '${player[statKey]}',
                            style: textStyles.bodyMedium,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              )
            else
              ...players.map((player) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          player['name'],
                          style: textStyles.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${player[statKey]}',
                        style: textStyles.bodyMedium?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}