import 'dart:math';

import 'package:flutter/material.dart';

import 'toss_wheel.dart';

class SpinningWheel extends StatelessWidget {
  final double size;
  final int playerNumber;
  final int playerCount;
  final bool startTurn;
  const SpinningWheel({super.key, required this.size, required this.playerCount, required this.playerNumber, required this.startTurn});

  double get numberOfTurns {
    final random = Random();
    return 9.75 + random.nextInt(5) + playerNumber / playerCount - random.nextDouble()/playerCount;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: startTurn ? numberOfTurns : 0,
      curve: Cubic(0.0, 0.95, 0.05, 1.0),
      duration: Duration(milliseconds: (numberOfTurns * 300).toInt()),
      child: TossWheelWidget(size: size, playerCount: playerCount),
    );
  }
}