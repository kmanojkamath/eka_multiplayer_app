
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../game/models/game_log.dart';

import '../../screens/game_sequence_screens/game_initialiser.dart';

import 'disabled_start_game_button.dart';
import 'start_game_button.dart';

class LiveStartGameButton extends StatefulWidget {
  final String roomId;
  const LiveStartGameButton({super.key, required this.roomId});

  @override
  State<LiveStartGameButton> createState() => _LiveStartGameButtonState();
}

class _LiveStartGameButtonState extends State<LiveStartGameButton> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.roomId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const DisabledStartGameButton();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const DisabledStartGameButton();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final players = List<String>.from(data['players'] ?? []);
        final playerCount = players.length;

        if (playerCount > 1) {
          return StartGameButton(
            onPressed: () async {
              final int playerNumber = Random().nextInt(playerCount);
              final log = GameInitializationLog(
                0,
                playerCount: playerCount,
                startingPlayer: playerNumber,
              );
              await FirebaseFirestore.instance
                  .collection('rooms')
                  .doc(widget.roomId)
                  .collection('logs')
                  .doc('0')
                  .set(log.toMap());

              if (!context.mounted) return;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GameInitialiser(
                    playerCount: playerCount,
                    playerNumber: 0,
                    startingPlayer: playerNumber,
                    roomId: widget.roomId,
                  ),
                ),
              );
            },
          );
        } else {
          return const DisabledStartGameButton();
        }
      },
    );
  }
}
