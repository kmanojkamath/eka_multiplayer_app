import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/name_plate/color_square.dart';
import '../widgets/name_plate/room_name_plate.dart';
import '../widgets/spinning_wheel/pointer_circle.dart';
import '../widgets/spinning_wheel/spinning_wheel.dart';
import '../widgets/spinning_wheel/toss_wheel.dart';

class SpinningCircle extends StatelessWidget {
  final int playerNumber;
  final int playerCount;
  final bool startTurn;
  final String roomId;
  const SpinningCircle({
    super.key,
    required this.playerNumber,
    required this.playerCount,
    required this.startTurn,
    required this.roomId,
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
                    RoomNamePlate(
                      playerNumber: playerIndex,
                      roomId: roomId,
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
