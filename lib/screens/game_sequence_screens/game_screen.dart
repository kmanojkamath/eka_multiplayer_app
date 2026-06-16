import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/logics/game_play.dart';
import 'package:eka_multiplayer_app/logics/name_generator.dart';
import 'package:eka_multiplayer_app/screens/result_screen.dart';
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

  Future<void> processMove(Move nextMove, HostGamePlay hostGamePlay) async {
    if (nextMove == Move.hostTurn) {
      nextMove = await hostGamePlay.hostTurn();
    } else if (nextMove == Move.gameWin) {
      final roomDoc = await FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.roomId)
          .get();

      List<dynamic> players = roomDoc['players'];

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(players[cardStorage.winner])
          .get();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            winnerName: getNameFromNumber(userDoc['name']),
            didWin: cardStorage.winner == 0,
          ),
        ),
      );
    } else {
      nextMove = await hostGamePlay.processLog();
    }
    await processMove(nextMove, hostGamePlay);
  }

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
      await processMove(Move.values[widget.playerNumber], hostGamePlay);
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
