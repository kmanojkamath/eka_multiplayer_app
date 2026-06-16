import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/logics/game_log.dart';
import 'package:flutter/foundation.dart';

import '../animations/card_animations/card_animations.dart';
import 'card_logic.dart';
import 'card_storage.dart';
import 'colors.dart';

enum Move {
  hostTurn,
  player1Turn,
  player2Turn,
  player3Turn,
  player4Turn,
  player5Turn,
  gameStart,
  gameWin,
}

class HostGamePlay {
  final CardAnimations cardAnimations;
  final DocumentReference roomRef;
  final int startingPlayer;

  const HostGamePlay(
    this.cardAnimations,
    this.roomRef, {
    required this.startingPlayer,
  });

  CardStorage get cardStorage => cardAnimations.positions.cardStorage;
  int get playerCount => cardStorage.playerCount;
  SplayTreeSet<int> playerNPile(int playerNumber) =>
      cardStorage.playerNPile(playerNumber);
  List<int> get deckPile => cardStorage.deckPile;
  List<int> get discardPile => cardStorage.discardPile;
  EkaCard get topCard => cardStorage.topCard;
  set topCard(int ci) {
    cardStorage.topCard = ci;
  }

  CollectionReference get logsRef => roomRef.collection('logs');
  int get nextLog => cardStorage.lastLog + 1;

  int get selectedCard => cardStorage.selectedCard.value;
  bool get movingForward => cardStorage.movingForward;

  int get turn => cardStorage.turn;
  set turn(int playerNumber) {
    cardStorage.turn = playerNumber;
  }

  void reverse() {
    cardStorage.movingForward = !movingForward;
  }

  void reshuffle() {
    deckPile.clear();
    deckPile.addAll(discardPile);
    deckPile.remove(topCard.ci);
    deckPile.shuffle();

    int tc = topCard.ci;
    discardPile.clear();
    discardPile.add(tc);
  }

  Future<void> sendLog(GameLog log) async {
    await logsRef.doc(nextLog.toString()).set(log.toMap());
    cardStorage.lastLog++;
  }

  Future<Move> gameStart() async {
    List<List<int>> P = List.filled(playerCount, []);

    for (int i = 0; i < playerCount; i++) {
      P[i] = deckPile.sublist(deckPile.length - 7).cast();
      deckPile.removeRange(deckPile.length - 7, deckPile.length);
    }

    while (!cardStorage.card[deckPile.last].isNumber) {
      deckPile.insert(0, deckPile.removeLast());
    }

    final log = GameStartLog(1, playerHands: P, deckPile: deckPile);
    await sendLog(log);

    for (int j = 0; j < 7; j++) {
      for (int i = 0; i < playerCount; i++) {
        int t = (i + startingPlayer) % playerCount;
        int ci = P[t][j];
        playerNPile(t).add(ci);
        if (t != 0) {
          await cardAnimations.playerNDrawCard(ci, t);
        } else {
          await cardAnimations.playerDrawCard(ci);
        }
      }
    }

    int topCardCI = deckPile.removeLast();

    await roomRef.update({'topCard': topCardCI});

    topCard = deckPile.removeLast();

    await cardAnimations.putTopCard();

    return Move.values[startingPlayer];
  }

  bool isPlayable(int ci) {
    final top = cardStorage.topCard;
    final card = cardStorage.card[ci];

    return (top.isWild &&
            (card.color == cardStorage.selectedColor.value || card.isWild)) ||
        card.isWild ||
        card.color == top.color ||
        card.value == top.value;
  }

  List<int> get playablePlayerCards =>
      cardStorage.playerPile.where((ci) => isPlayable(ci)).toList();

  Future<void> waitForPlayer() {
    if (playablePlayerCards.isEmpty) cardStorage.canDraw = true;

    final completer = Completer<int>();

    late VoidCallback listener;

    listener = () {
      cardStorage.selectedCard.removeListener(listener);
      completer.complete(selectedCard);
    };

    cardStorage.selectedCard.addListener(listener);
    return completer.future;
  }

  Future<CardColor> waitForColor() {
    final completer = Completer<CardColor>();

    late VoidCallback listener;
    listener = () {
      cardStorage.selectedColor.removeListener(listener);
      completer.complete(cardStorage.selectedColor.value);
    };

    cardStorage.selectedColor.addListener(listener);
    return completer.future;
  }

  Future<Move> drawForHost() async {
    if (deckPile.isEmpty) reshuffle();

    int ci = deckPile.removeLast();

    final log = PlayerDrawLog(nextLog, playerNumber: 0, drawCards: [ci]);
    await sendLog(log);

    playerNPile(0).add(ci);

    await cardAnimations.playerDrawCard(ci);

    if (isPlayable(ci)) {
      return Move.hostTurn;
    } else if (movingForward) {
      await roomRef.update({'turn': 1});
      return Move.player1Turn;
    } else {
      await roomRef.update({'turn': playerCount - 1});
      return Move.values[playerCount - 1];
    }
  }

  Future<Move> changeTurn(int nextPlayer, {bool? isReverse}) async {
    final log = ChangeTurnLog(
      nextLog,
      nextPlayer: nextPlayer,
      isReverse: isReverse ?? false,
    );

    await sendLog(log);

    turn = nextPlayer;

    return Move.values[nextPlayer];
  }

  Future<Move> hostTurn() async {
    await cardAnimations.showPlayableCards();

    await waitForPlayer();

    if (selectedCard < 0) return drawForHost();

    await cardAnimations.playerPlayCard();

    topCard = selectedCard;

    playerNPile(0).remove(selectedCard);

    late PlayerPlayLog log;

    if (topCard.isWild) {
      cardStorage.selectedColor.value = CardColor.wild;

      cardStorage.showColorSelector.call();

      await waitForColor();

      await Future.delayed(Duration(milliseconds: 420));

      log = PlayerPlayLog(
        nextLog,
        playerNumber: 0,
        putCard: selectedCard,
        color: cardStorage.selectedColor.value,
      );
    } else {
      log = PlayerPlayLog(nextLog, playerNumber: 0, putCard: selectedCard);
    }

    await sendLog(log);

    cardStorage.changeDisplayedTopCard();

    if (playerNPile(0).isEmpty) {
      final log = GameWinLog(nextLog, playerNumber: 0);
      await sendLog(log);
      return Move.gameWin;
    }

    await cardAnimations.unshowPlayableCards();

    playerNPile(0).remove(selectedCard);
    topCard = selectedCard;

    if (topCard.isDrawTwo) {
      if (deckPile.length < 2) reshuffle();
      final int ci1 = deckPile.removeLast();
      final int ci2 = deckPile.removeLast();

      final prey = movingForward ? 1 : playerCount - 1;

      final log = PlayerDrawLog(
        nextLog,
        playerNumber: prey,
        drawCards: [ci1, ci2],
      );

      sendLog(log);

      playerNPile(prey).add(ci1);
      await cardAnimations.playerNDrawCard(ci1, prey);
      playerNPile(prey).add(ci2);
      await cardAnimations.playerNDrawCard(ci2, prey);

      if (movingForward) {
        return changeTurn(2 % playerCount);
      } else {
        return changeTurn(playerCount - 2);
      }
    } else if (topCard.isNumber || topCard.isWildCard) {
      return changeTurn(movingForward ? 1 : playerCount - 1);
    } else if (topCard.isReverse) {
      reverse();
      return changeTurn(movingForward ? 1 : playerCount - 1, isReverse: true);
    } else if (topCard.isSkip) {
      return changeTurn(movingForward ? 2 % playerCount : playerCount - 2);
    } else if (topCard.isWildDrawFour) {
      if (deckPile.length < 4) reshuffle();
      final List<int> cis = [];
      for (int i = 0; i < 4; i++) {
        cis.add(deckPile.removeLast());
      }

      final prey = movingForward ? 1 : playerCount - 1;

      final log = PlayerDrawLog(nextLog, playerNumber: prey, drawCards: cis);

      await sendLog(log);

      for (int i = 0; i < 4; i++) {
        playerNPile(prey).add(cis[i]);
        await cardAnimations.playerNDrawCard(cis[i], prey);
      }

      return changeTurn(movingForward ? 2 % playerCount : playerCount - 2);
    } else {
      debugPrint("TopCard is ${topCard.ci}");
      return changeTurn(1);
    }
  }

  Future<GameLog> waitForNextLog() async {
    final snap = await logsRef
        .doc(nextLog.toString())
        .snapshots()
        .firstWhere((snap) => snap.exists);

    cardStorage.lastLog++;

    return snap.toGameLog();
  }

  Future<Move> processLog() async {
    final log = await waitForNextLog();

    switch (log) {
      case ChangeTurnLog(
        nextPlayer: final nextPlayer,
        isReverse: final isReverse,
      ):
        turn = nextPlayer;
        if (isReverse) reverse();
        return Move.values[nextPlayer];
      case PlayerDrawLog(
        playerNumber: final playerNumber,
        drawCards: final drawCards,
      ):
        if(deckPile.length < drawCards.length) reshuffle();
        for (int i = 0; i < drawCards.length; i++) {
          deckPile.remove(drawCards[i]);
          playerNPile(playerNumber).add(drawCards[i]);

          await cardAnimations.playerNDrawCard(drawCards[i], playerNumber);
        }
        return Move.values[playerNumber];
      case PlayerPlayLog(playerNumber: final playerNumber, putCard: final putCard):
        topCard = putCard;
        playerNPile(playerNumber).remove(playerNumber);
        await cardAnimations.playerNPlayCard(playerNumber);
        return Move.values[playerNumber];
      case GameWinLog(playerNumber: int playerNumber):
        cardStorage.winner = playerNumber;
        return Move.gameWin;
      default:
        debugPrint("Invalid Log in Host Game Play");
        return Move.hostTurn;
    }
  }
}
