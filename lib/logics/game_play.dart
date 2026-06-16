import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/animations/card_animations/card_animations.dart';
import 'package:eka_multiplayer_app/logics/card_logic.dart';
import 'package:eka_multiplayer_app/logics/card_storage.dart';
import 'package:eka_multiplayer_app/logics/colors.dart';
import 'package:flutter/foundation.dart';

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

  const HostGamePlay(this.cardAnimations, this.roomRef);

  CardStorage get cardStorage => cardAnimations.positions.cardStorage;
  int get playerCount => cardStorage.playerCount;
  SplayTreeSet<int> playerNPile(int playerNumber) =>
      cardStorage.playerNPile(playerNumber);
  List get deckPile => cardStorage.deckPile;
  List get discardPile => cardStorage.discardPile;
  EkaCard get topCard => cardStorage.topCard;
  set topCard(int ci) {
    cardStorage.topCard = ci;
  }

  int get selectedCard => cardStorage.selectedCard.value;
  bool get movingForward => cardStorage.movingForward;

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

  Future<Move> gameStart() async {
    List<List<int>> P = List.filled(playerCount, []);

    for (int i = 0; i < playerCount; i++) {
      P[i] = deckPile.sublist(deckPile.length - 7).cast();
      deckPile.removeRange(deckPile.length - 7, deckPile.length);
    }

    while (!cardStorage.card[deckPile.last].isNumber) {
      deckPile.insert(0, deckPile.removeLast());
    }

    await roomRef.update({
      'playerNPile': {for (int i = 0; i < P.length; i++) '$i': P[i]},
      'deckPile': deckPile,
    });

    final snap = await roomRef.get();

    int turn = snap['turn'];

    for (int j = 0; j < 7; j++) {
      for (int i = 0; i < playerCount; i++) {
        int t = (i + turn) % playerCount;
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

    return Move.values[turn];
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

    await roomRef.update({
      'deckPile': FieldValue.arrayRemove([ci]),
      'playerNPile.0': FieldValue.arrayUnion([ci]),
    });

    playerNPile(0).add(ci);

    await cardAnimations.playerDrawCard(ci);

    if (isPlayable(ci)) {
      return Move.hostTurn;
    } else if (movingForward) {
      return Move.player1Turn;
    } else {
      return Move.values[playerCount - 1];
    }
  }

  Future<Move> hostTurn() async {
    await cardAnimations.showPlayableCards();

    await waitForPlayer();

    if (selectedCard < 0) return drawForHost();

    await cardAnimations.playerPlayCard();

    topCard = selectedCard;

    playerNPile(0).remove(selectedCard);

    roomRef.update({
      'playerNPile.0': FieldValue.arrayRemove([selectedCard]),
      'topCard': selectedCard,
    });

    cardStorage.changeDisplayedTopCard();

    if (playerNPile(0).isEmpty) {
      await roomRef.update({'turn': -1, 'Winner': 0});
      return Move.gameWin;
    }

    await cardAnimations.unshowPlayableCards();

    playerNPile(0).remove(selectedCard);
    topCard = selectedCard;

    if (topCard.isDrawTwo) {
      if (deckPile.length < 2) reshuffle();
      final int ci1 = deckPile.removeLast();
      final int ci2 = deckPile.removeLast();

      await roomRef.update({
        'deckPile': FieldValue.arrayRemove([ci1, ci2]),
        'playerNPile.1': FieldValue.arrayUnion([ci1, ci2]),
      });

      final prey = movingForward ? 1 : playerCount - 1;

      playerNPile(prey).add(ci1);
      await cardAnimations.playerNDrawCard(ci1, prey);
      playerNPile(prey).add(ci2);
      await cardAnimations.playerNDrawCard(ci2, prey);

      if (movingForward) {
        await roomRef.update({'turn': 2 % playerCount});
        return Move.values[2 % playerCount];
      } else {
        await roomRef.update({'turn': playerCount - 2});
        return Move.values[playerCount - 2];
      }
    } else if (topCard.isNumber) {
      if (movingForward) {
        await roomRef.update({'turn': 1});
        return Move.player1Turn;
      } else {
        await roomRef.update({'turn': playerCount - 1});
        return Move.values[playerCount - 1];
      }
    } else if (topCard.isReverse) {
      reverse();
      roomRef.update({'movingForward': movingForward});
      if (movingForward) {
        await roomRef.update({'turn': 1});
        return Move.player1Turn;
      } else {
        await roomRef.update({'turn': playerCount - 1});
        return Move.values[playerCount - 1];
      }
    } else if (topCard.isSkip) {
      if (movingForward) {
        await roomRef.update({'turn': 2 % playerCount});
        return Move.values[2 % playerCount];
      } else {
        await roomRef.update({'turn': playerCount - 2});
        return Move.values[playerCount - 2];
      }
    } else if (topCard.isWildCard) {
      cardStorage.selectedColor.value = CardColor.wild;

      cardStorage.showColorSelector.call();

      await waitForColor();

      await Future.delayed(Duration(milliseconds: 420));

      if (movingForward) {
        await roomRef.update({'turn': 1});
        return Move.player1Turn;
      } else {
        await roomRef.update({'turn': playerCount - 1});
        return Move.values[playerCount - 1];
      }
    } else if (topCard.isWildDrawFour) {
      cardStorage.selectedColor.value = CardColor.wild;

      cardStorage.showColorSelector.call();

      await waitForColor();

      await Future.delayed(Duration(milliseconds: 420));

      if (deckPile.length < 4) reshuffle();
      final List<int> cis = [];
      for (int i = 0; i < 4; i++) {
        cis.add(deckPile.removeLast());
      }

      await roomRef.update({
        'deckPile': FieldValue.arrayRemove(cis),
        'playerNPile.1': FieldValue.arrayUnion(cis),
      });

      final prey = movingForward ? 1 : playerCount - 1;

      for (int i = 0; i < 4; i++) {
        playerNPile(prey).add(cis[i]);
        await cardAnimations.playerNDrawCard(cis[i], prey);
      }

      if (movingForward) {
        await roomRef.update({'turn': 2 % playerCount});
        return Move.values[2 % playerCount];
      } else {
        await roomRef.update({'turn': playerCount - 2});
        return Move.values[playerCount - 2];
      }
    } else {
      debugPrint("TopCard is ${topCard.ci}");
      return Move.player1Turn;
    }
  }
}
