import 'dart:async';

import '../../layers/spinning_wheel_layer.dart';

import '../../helpers/colors.dart';

import 'package:flutter/material.dart';

import 'game_screen.dart';

class GameInitialiser extends StatefulWidget {
  final int playerCount;
  final int playerNumber;
  final int startingPlayer;
  final String roomId;
  const GameInitialiser({
    super.key,
    required this.playerCount,
    required this.playerNumber,
    required this.startingPlayer,
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
          MaterialPageRoute(
            builder: (context) => GameScreen(
              roomId: widget.roomId,
              playerCount: widget.playerCount,
              playerNumber: widget.playerNumber,
              startingPlayer: widget.startingPlayer,
            ),
          ),
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
            playerNumber: widget.startingPlayer,
            playerCount: widget.playerCount,
            startTurn: startTurn,
            roomId: widget.roomId,
          ),
        ),
      ),
    );
  }
}
