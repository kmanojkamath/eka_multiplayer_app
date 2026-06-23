import 'package:flutter/material.dart';

import '../../game/models/positions.dart';
import 'name_plate.dart';

class TimedNamePlate extends StatelessWidget {
  final Positions positions;
  final String playerName;
  final AnimationController timer;
  final ValueNotifier<int> turn;
  final int playerNumber;

  const TimedNamePlate({
    super.key,
    required this.positions,
    required this.playerName,
    required this.timer,
    required this.turn,
    required this.playerNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([timer, turn]),
      builder: (_, _) {
        return Stack(
          children: [
            NamePlate(positions, playerName),

            if (turn.value == playerNumber)
              Positioned(
                left: 5,
                right: 5,
                bottom: 0,
                child: LinearProgressIndicator(value: timer.value),
              ),
          ],
        );
      },
    );
  }
}
