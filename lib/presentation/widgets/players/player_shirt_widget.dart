import 'package:carrermodetracker/domain/entities/player.dart';
import 'package:carrermodetracker/presentation/widgets/players/custom_shirt_icon.dart';
import 'package:flutter/material.dart';

class PlayerShirtWidget extends StatelessWidget {
  final Player player;

  const PlayerShirtWidget({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final number = player.number;
    double positionR = (number.length > 1) ? 69 : 80;
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        children: [
          const Center(
            child: CustomShirtIcon(
              size: 200,
            ),
          ),
          Positioned(
              top: 70,
              right: positionR,
              child: Text(
                player.number,
                style: textStyles.displayLarge,
              ))
        ],
      ),
    );
  }
}
