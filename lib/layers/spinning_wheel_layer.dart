import 'dart:math';

import 'package:eka_multiplayer_app/game/models/card_storage.dart';
import 'package:eka_multiplayer_app/game/models/positions.dart';
import 'package:eka_multiplayer_app/widgets/name_plate/name_plate.dart';
import 'package:flutter/material.dart';

import '../widgets/name_plate/color_square.dart';
import '../widgets/spinning_wheel/pointer_circle.dart';
import '../widgets/spinning_wheel/spinning_wheel.dart';
import '../widgets/spinning_wheel/toss_wheel.dart';

class SpinningCircle extends StatelessWidget {
  final int playerNumber;
  final int playerCount;
  final bool startTurn;
  final List<String> players;
  const SpinningCircle({
    super.key,
    required this.playerNumber,
    required this.playerCount,
    required this.startTurn,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Row(
      children: [
        SizedBox(
          width: screenSize.width / 2,
          height: screenSize.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SpinningWheel(
                playerNumber: playerNumber,
                playerCount: playerCount,
                size: min(screenSize.width / 3, screenSize.height / 2),
                startTurn: startTurn,
              ),
              SizedBox(
                width: min(screenSize.width / 3, screenSize.height / 2),
                height: min(screenSize.width / 3, screenSize.height / 2),
                child: CustomPaint(painter: PointerCircle()),
              ),
            ],
          ),
        ),
        SizedBox(
          width: screenSize.width / 2,
          height: screenSize.height,
          child: Column(
            children: [
              const Spacer(flex: 5),
              ...List.generate(playerCount * 2, (index) {
                if (index.isOdd) {
                  return const Spacer(flex: 2);
                }

                final playerIndex = index ~/ 2;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ColorSquare(color: colors[playerIndex]),
                    NamePlate(
                      Positions(CardStorage(playerCount), screenSize),
                      players[playerIndex],
                    ),
                    const Spacer(),
                  ],
                );
              }),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ],
    );
  }
}
