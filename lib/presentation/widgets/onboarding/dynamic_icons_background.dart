import 'package:flutter/material.dart';
import 'dart:math';

class DynamicIconsBackground extends StatelessWidget {
  const DynamicIconsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final screenSize = MediaQuery.of(context).size;

    final List<IconData> footballIcons = [
      Icons.sports_soccer,
      Icons.emoji_events,
      Icons.analytics,
      Icons.people,
      Icons.star,
      Icons.trending_up,
      Icons.sports,
      Icons.leaderboard,
      Icons.assessment,
      Icons.group,
      Icons.flag,
      Icons.timer,
      Icons.score,
      Icons.visibility,
    ];

    const int gridColumns = 8;
    const int gridRows = 6;
    final double cellWidth = screenSize.width / gridColumns;
    final double cellHeight = (screenSize.height * 0.7) / gridRows;

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      color: Colors.black87,
      child: Stack(
        children: List.generate(30, (index) {
          final int gridX = index % gridColumns;
          final int gridY = (index ~/ gridColumns) % gridRows;

          final double baseLeft = gridX * cellWidth;
          final double baseTop = gridY * cellHeight;

          final double randomOffsetX =
              (random.nextDouble() - 0.5) * cellWidth * 0.6;
          final double randomOffsetY =
              (random.nextDouble() - 0.5) * cellHeight * 0.6;

          final double left = baseLeft + randomOffsetX;
          final double top = baseTop + randomOffsetY;

          final double size = 15 + random.nextDouble() * 35;
          final double opacity = 0.08 + random.nextDouble() * 0.15;
          final IconData icon =
              footballIcons[random.nextInt(footballIcons.length)];

          return Positioned(
            left: left,
            top: top,
            child: Opacity(
              opacity: opacity,
              child: Icon(
                icon,
                size: size,
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }
}
