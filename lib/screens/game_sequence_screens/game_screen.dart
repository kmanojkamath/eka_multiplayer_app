import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/game/player_logic/player_game_play.dart';
import 'package:eka_multiplayer_app/game/models/move.dart';
import 'package:eka_multiplayer_app/screens/game_sequence_screens/result_screen.dart';
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
  final List<String> players;
  const GameScreen({
    super.key,
    required this.roomId,
    required this.playerCount,
    required this.startingPlayer,
    required this.playerNumber,
    required this.players,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late CardStorage cardStorage;
  late CardAnimations cardAnimations;
  late HostGamePlay hostGamePlay;

  Future<void> processHostMove(Move nextMove, HostGamePlay hostGamePlay) async {
    if (nextMove == Move.playerTurn) {
      nextMove = await hostGamePlay.playerTurn();
    } else if (nextMove == Move.gameWin) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            winnerName: cardStorage.playerNames[cardStorage.winner],
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
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            winnerName: cardStorage.playerNames[cardStorage.winner],
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
    AnimationController timer = AnimationController(
      vsync: this,
      duration: Duration(seconds: 18),
    );

    cardStorage = CardStorage(widget.playerCount);

    cardStorage.timer = timer;
    cardStorage.playerNames = widget.players;

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
                names: widget.players,
                turn: cardStorage.turn,
                timer: cardStorage.timer,
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
