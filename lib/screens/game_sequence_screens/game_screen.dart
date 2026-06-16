import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/logics/game_play.dart';
import 'package:flutter/material.dart';

import '../../animations/card_animations/card_animations.dart';

import '../../layers/cards_layers/player_n_cards_layer.dart';
import '../../logics/positions.dart';
import '../../logics/card_storage.dart';

import '../../layers/background.dart';
import '../../layers/cards_layers/draw_card_layer.dart';
import '../../layers/cards_layers/player_cards_layer.dart';
import '../../layers/cards_layers/top_card.dart';
import '../../layers/color_selector.dart';

class GameScreen extends StatefulWidget {
  final String roomId;
  final int playerCount;
  final int playerNumber;
  const GameScreen({
    super.key,
    required this.roomId,
    required this.playerCount,
    required this.playerNumber,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late CardStorage cardStorage;
  late CardAnimations cardAnimations;
  late HostGamePlay hostGamePlay;

  @override
  void initState() {
    super.initState();
    cardStorage = CardStorage(widget.playerCount);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cardAnimations = CardAnimations(
        Positions(cardStorage, MediaQuery.sizeOf(context)),
      );
      DocumentReference roomRef = FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.roomId);
      hostGamePlay = HostGamePlay(
        cardAnimations,
        roomRef,
        startingPlayer: widget.playerNumber,
      );

      await hostGamePlay.gameStart();
      await hostGamePlay.hostTurn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Background(),
            TopCard(cardStorage),
            ...List.generate(widget.playerCount - 1, (i) {
              return PlayerNCardsLayer(
                cardStorage,
                uiPlayerNumber: i + 1,
                roomId: widget.roomId,
              );
            }),
            DrawCardLayer(cardStorage),
            ColorSelector(cardStorage),
            PlayerCardsLayer(cardStorage),
          ],
        ),
      ),
    );
  }
}
