import 'dart:collection';

import 'package:flutter/material.dart';

import 'animated-cards/animated_back_card.dart';
import 'animated-cards/animated_card.dart';

import 'card_logic.dart';

class CardStorage {
  final List<EkaCard> _card = List.generate(108, (i) => EkaCard(i, CardController()));

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
