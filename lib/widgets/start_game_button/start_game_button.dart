import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/game/models/game_log.dart';
import 'package:flutter/material.dart';

import '../../screens/game_sequence_screens/game_initialiser.dart';

class StartGameButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartGameButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.red,
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.yellow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onPressed,
              child: const Padding(
                padding: EdgeInsets.all(22),
                child: Icon(
                  Icons.play_arrow_rounded,
                  size: 52,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "START GAME",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class DisabledStartGameButton extends StatelessWidget {
  const DisabledStartGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Color(0xFF9E9E9E),
                  Color(0xFF757575),
                  Color(0xFFBDBDBD),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(22),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 52,
                color: Colors.white70,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "START GAME",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

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
