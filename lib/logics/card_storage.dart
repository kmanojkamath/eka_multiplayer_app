import 'dart:collection';

import 'package:flutter/material.dart';

import 'colors.dart';
import '../items/card/animated-cards/animated_back_card.dart';
import '../items/card/animated-cards/animated_card.dart';

import 'card_logic.dart';

class CardStorage {
  final List<EkaCard> _card = List.generate(
    108,
    (i) => EkaCard(i, CardController()),
  );

  List<EkaCard> get card => _card;

  List<int> deckPile = List.generate(107, (i) {
    return i;
  })..shuffle();

  List<int> discardPile = [];

  SplayTreeSet<int> playerPile = SplayTreeSet<int>();

  SplayTreeSet<int> player2Pile = SplayTreeSet<int>();

  SplayTreeSet<int> player3Pile = SplayTreeSet<int>();

  SplayTreeSet<int> player4Pile = SplayTreeSet<int>();

  SplayTreeSet<int> player5Pile = SplayTreeSet<int>();

  SplayTreeSet<int> player6Pile = SplayTreeSet<int>();

  SplayTreeSet<int> playerNPile(int playerNumber) {
    switch (playerNumber) {
      case 2:
        return player2Pile;
      case 3:
        return player3Pile;
      case 4:
        return player4Pile;
      case 5:
        return player5Pile;
      case 6:
        return player6Pile;
      default:
        debugPrint("You are trying to access pile of player-$playerNumber");
        return player2Pile;
    }
  }

  EkaCard get topCard => card[discardPile.last];

  set topCard(int ci) => discardPile.add(ci);

  BackCardController backOfDrawingCard = BackCardController();

  BackCardController stationary = BackCardController();

  List<BackCardController> player2Card = List.generate(27, (i) {
    return BackCardController();
  });

  List<BackCardController> player3Card = List.generate(27, (i) {
    return BackCardController();
  });

  List<BackCardController> player4Card = List.generate(27, (i) {
    return BackCardController();
  });

  List<BackCardController> player5Card = List.generate(27, (i) {
    return BackCardController();
  });

  List<BackCardController> player6Card = List.generate(27, (i) {
    return BackCardController();
  });

  List<BackCardController> playerNCard(int playerNumber) {
    switch (playerNumber) {
      case 2:
        return player2Card;
      case 3:
        return player3Card;
      case 4:
        return player4Card;
      case 5:
        return player5Card;
      case 6:
        return player6Card;
      default:
        debugPrint(
          "You are trying to access BackCardController of player-$playerNumber",
        );
        return player2Card;
    }
  }

  ValueNotifier<EkaCard> displayedTopCard = ValueNotifier(
    EkaCard(-1, CardController()),
  );

  void changeDisplayedTopCard() {
    displayedTopCard.value = topCard;
  }

  bool canDraw = false;

  ValueNotifier<int> selectedCard = ValueNotifier(-1);

  ValueNotifier<CardColor> selectedColor = ValueNotifier(CardColor.wild);

  late Function showColorSelector;
}
