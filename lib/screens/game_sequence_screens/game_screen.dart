import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/game/player_logic/player_game_play.dart';
import 'package:eka_multiplayer_app/game/models/move.dart';
import 'package:eka_multiplayer_app/helpers/name_generator.dart';
import 'package:eka_multiplayer_app/screens/result_screen.dart';
import 'package:flutter/material.dart';

import '../../animations/card_animations/card_animations.dart';

import '../../game/host_logic/host_game_play.dart';
import '../../layers/cards_layers/player_n_cards_layer.dart';
import '../../game/models/positions.dart';
import '../../game/models/card_storage.dart';

import '../../layers/background.dart';
import '../../layers/cards_layers/draw_card_layer.dart';
import '../../layers/cards_layers/player_cards_layer.dart';
import '../../layers/cards_layers/top_card.dart';
import '../../layers/color_selector.dart';

class GameScreen extends StatefulWidget {
  final String roomId;
  final int playerCount;
  final int startingPlayer;
  final int playerNumber;
  const GameScreen({
    super.key,
    required this.roomId,
    required this.playerCount,
    required this.startingPlayer,
    required this.playerNumber,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late CardStorage cardStorage;
  late CardAnimations cardAnimations;
  late HostGamePlay hostGamePlay;

  Future<void> processHostMove(Move nextMove, HostGamePlay hostGamePlay) async {
    if (nextMove == Move.playerTurn) {
      nextMove = await hostGamePlay.playerTurn();
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
            didWin: cardStorage.winner == 0 ? true : false,
          ),
        ),
      );
      return;
    } else {
      nextMove = await hostGamePlay.processLog();
    }
    await processHostMove(nextMove, hostGamePlay);
  }

  Future<void> processPlayerMove(
    Move nextMove,
    PlayerGamePlay playerNGamePlay,
  ) async {
    if (nextMove == Move.playerTurn) {
      nextMove = await playerNGamePlay.playerTurn();
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
            didWin: cardStorage.winner == playerNGamePlay.currentPlayer
                ? true
                : false,
          ),
        ),
      );
      return;
    } else {
      nextMove = await playerNGamePlay.processLog();
    }
    await processPlayerMove(nextMove, playerNGamePlay);
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
      if (widget.playerNumber == 0) {
        hostGamePlay = HostGamePlay(
          cardAnimations,
          roomRef,
          startingPlayer: widget.startingPlayer,
        );

        await hostGamePlay.gameStart();
        await processHostMove(Move.values[widget.startingPlayer], hostGamePlay);
      } else {
        PlayerGamePlay playerNGamePlay = PlayerGamePlay(
          widget.playerNumber,
          cardAnimations: cardAnimations,
          roomRef: roomRef,
          startingPlayer: widget.startingPlayer,
        );
        Move nextMove = await playerNGamePlay.gameStart();
        await processPlayerMove(nextMove, playerNGamePlay);
      }
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
                playerNumber: i + 1,
                playerCount: widget.playerCount,
                currentPlayer: widget.playerNumber,
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
