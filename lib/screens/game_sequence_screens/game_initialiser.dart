import 'dart:async';

import '../../layers/spinning_wheel_layer.dart';

import '../../logics/colors.dart';

import 'package:flutter/material.dart';

import 'game_screen.dart';

class GameInitialiser extends StatefulWidget {
  final int playerCount;
  final int playerNumber;
  final String roomId;
  const GameInitialiser({
    super.key,
    required this.playerCount,
    required this.playerNumber,
    required this.roomId,
  });

  @override
  State<GameInitialiser> createState() => _GameInitialiserState();
}

class _GameInitialiserState extends State<GameInitialiser> {
  bool startTurn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => startTurn = true);
      Timer(Duration(milliseconds: 4725), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GameScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            colors: [
              color(CardColor.blue),
              color(CardColor.green),
              color(CardColor.yellow),
              color(CardColor.red),
            ],
          ),
        ),
        child: Center(
          child: SpinningCircle(
            playerNumber: widget.playerNumber,
            playerCount: widget.playerCount,
            startTurn: startTurn,
            roomId: widget.roomId,
          ),
        ),
      ),
    );
  }
}
