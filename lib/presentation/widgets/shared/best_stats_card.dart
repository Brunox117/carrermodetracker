import 'package:flutter/material.dart';

class BestStatsCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> players;
  final String statKey;

  const BestStatsCard({
    super.key,
    required this.title,
    required this.players,
    required this.statKey,
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
