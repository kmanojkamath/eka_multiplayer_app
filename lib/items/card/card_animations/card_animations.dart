import 'package:flutter/material.dart';

import '../animated-cards/animated_back_card.dart';
import '../card_storage.dart';

import 'positions.dart';

import 'card_animator.dart';

class CardAnimations {
  final CardStorage cardStorage;
  final CardAnimator cardAnimator;
  final Positions positions;

  CardAnimations(this.cardStorage, this.positions)
    : cardAnimator = CardAnimator(cardStorage);

  Future<void> playerDrawCard(int ci) async {
    final drawDuration = cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = cardStorage.discardPile.isEmpty ? 200 : 360;

    await Future.wait(
      cardAnimator.moveBackCard(
        widthScale: 0,
        scale: 0.75,
        duration: drawDuration,
      ),
    );

    await Future.wait(
      cardAnimator.moveCard(
        ci,
        widthScale: 1,
        scale: positions.playerCardScale,
        duration: drawDuration,
      ),
    );

    await Future.wait(cardAnimator.moveBackCard(widthScale: 1, scale: 0.5));

    await Future.wait(
      cardStorage.playerPile.expand(
        (i) => cardAnimator.moveCard(
          i,
          position: positions.playerCardPosition(i),
          angle: positions.playerCardAngle(i),
          scale: positions.playerCardScale,
          duration: i == ci ? moveDuration : drawDuration,
        ),
      ),
    );
  }

  Future<void> player2DrawCard(int ci) async {
    int n = cardStorage.player2Pile.length;

    final drawDuration = cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = cardStorage.discardPile.isEmpty ? 200 : 360;

    int indexOfPlayer2Card(BackCardController player2Card) =>
        cardStorage.player2Card.indexOf(player2Card);

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player2Card[n - 1],
        position: positions.drawPosition,
        angle: 0,
        widthScale: 0,
      ),
    );

    await Future.wait([
      ...cardAnimator.movePlayerCard(
        cardStorage.player2Card[n - 1],
        widthScale: 1,
        position: positions.player2CardPosition(n - 1),
        angle: positions.player2CardAngle(n - 1),
        duration: moveDuration,
      ),
      ...cardStorage.player2Card
          .getRange(0, n - 1)
          .expand(
            (i) => cardAnimator.movePlayerCard(
              i,
              position: positions.player2CardPosition(indexOfPlayer2Card(i)),
              angle: positions.player2CardAngle(indexOfPlayer2Card(i)),
              duration: drawDuration,
            ),
          ),
    ]);
  }

  Future<void> player3DrawCard(int ci) async {
    int n = cardStorage.player3Pile.length;

    final drawDuration = cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = cardStorage.discardPile.isEmpty ? 200 : 360;

    int indexOfPlayer3Card(BackCardController player3Card) =>
        cardStorage.player3Card.indexOf(player3Card);

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player3Card[n - 1],
        position: positions.drawPosition,
        angle: 0,
        widthScale: 0,
      ),
    );

    await Future.wait([
      ...cardAnimator.movePlayerCard(
        cardStorage.player3Card[n - 1],
        widthScale: 1,
        position: positions.player3CardPosition(n - 1),
        angle: positions.player3CardAngle(n - 1),
        duration: moveDuration,
      ),
      ...cardStorage.player3Card
          .getRange(0, n - 1)
          .expand(
            (i) => cardAnimator.movePlayerCard(
              i,
              position: positions.player3CardPosition(indexOfPlayer3Card(i)),
              angle: positions.player3CardAngle(indexOfPlayer3Card(i)),
              duration: drawDuration,
            ),
          ),
    ]);
  }

  Future<void> player4DrawCard(int ci) async {
    int n = cardStorage.player4Pile.length;

    final drawDuration = cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = cardStorage.discardPile.isEmpty ? 200 : 360;

    int indexOfPlayer4Card(BackCardController player4Card) =>
        cardStorage.player4Card.indexOf(player4Card);

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player4Card[n - 1],
        position: positions.drawPosition,
        angle: 0,
        widthScale: 0,
      ),
    );

    await Future.wait([
      ...cardAnimator.movePlayerCard(
        cardStorage.player4Card[n - 1],
        widthScale: 1,
        position: positions.player4CardPosition(n - 1),
        angle: positions.player4CardAngle(n - 1),
        duration: moveDuration,
      ),
      ...cardStorage.player4Card
          .getRange(0, n - 1)
          .expand(
            (i) => cardAnimator.movePlayerCard(
              i,
              position: positions.player4CardPosition(indexOfPlayer4Card(i)),
              angle: positions.player4CardAngle(indexOfPlayer4Card(i)),
              duration: drawDuration,
            ),
          ),
    ]);
  }

  Future<void> player5DrawCard(int ci) async {
    int n = cardStorage.player5Pile.length;

    final drawDuration = cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = cardStorage.discardPile.isEmpty ? 200 : 360;

    int indexOfPlayer5Card(BackCardController player5Card) =>
        cardStorage.player5Card.indexOf(player5Card);

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player5Card[n - 1],
        position: positions.drawPosition,
        angle: 0,
        widthScale: 0,
      ),
    );

    await Future.wait([
      ...cardAnimator.movePlayerCard(
        cardStorage.player5Card[n - 1],
        widthScale: 1,
        position: positions.player5CardPosition(n - 1),
        angle: positions.player5CardAngle(n - 1),
        duration: moveDuration,
      ),
      ...cardStorage.player5Card
          .getRange(0, n - 1)
          .expand(
            (i) => cardAnimator.movePlayerCard(
              i,
              position: positions.player5CardPosition(indexOfPlayer5Card(i)),
              angle: positions.player5CardAngle(indexOfPlayer5Card(i)),
              duration: drawDuration,
            ),
          ),
    ]);
  }

  Future<void> player6DrawCard(int ci) async {
    int n = cardStorage.player6Pile.length;

    final drawDuration = cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = cardStorage.discardPile.isEmpty ? 200 : 360;

    int indexOfPlayer6Card(BackCardController player6Card) =>
        cardStorage.player6Card.indexOf(player6Card);

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player6Card[n - 1],
        position: positions.drawPosition,
        angle: 0,
        widthScale: 0,
      ),
    );

    await Future.wait([
      ...cardAnimator.movePlayerCard(
        cardStorage.player6Card[n - 1],
        widthScale: 1,
        position: positions.player6CardPosition(n - 1),
        angle: positions.player6CardAngle(n - 1),
        duration: moveDuration,
      ),
      ...cardStorage.player6Card
          .getRange(0, n - 1)
          .expand(
            (i) => cardAnimator.movePlayerCard(
              i,
              position: positions.player6CardPosition(indexOfPlayer6Card(i)),
              angle: positions.player6CardAngle(indexOfPlayer6Card(i)),
              duration: drawDuration,
            ),
          ),
    ]);
  }

  Future<void> playerPlayCard() async {
    playablePlayerCards().forEach(
      (element) => cardStorage.card[element].controller.locked = true,
    );

    await Future.wait([
      ...cardAnimator.moveCard(
        cardStorage.selectedCard.value,
        position: positions.topCardPosition,
        angle: 0,
        scale: positions.topCardScale,
        duration: 300,
      ),
      ...playablePlayerCards()
          .where((i) => i != cardStorage.selectedCard.value)
          .expand(
            (ci) => cardAnimator.moveCard(
              ci,
              position: positions.playableCardPosition(ci),
              angle: positions.playableCardAngle(ci),
              scale: positions.playableCardScale,
              duration: 180,
            ),
          ),
    ]);
  }

  Future<void> player2PlayCard() async {
    int n = cardStorage.player2Pile.length;

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player2Card[n],
        scale: positions.drawScale,
        widthScale: 0,
        angle: 0,
        duration: 100,
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.player2CardPosition(cardStorage.player2Pile.length),
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.topCardPosition,
        scale: positions.topCardScale,
        widthScale: 1,
        duration: 180,
        widthScaleDuration: 100,
      ),
    );

    await cardStorage.player2Card[n].changePosition!.call(
      positions.drawPosition,
      Duration(milliseconds: 100),
      Curves.linear,
    );

    cardStorage.changeDisplayedTopCard();

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.drawPosition,
        scale: positions.drawScale,
        widthScale: 0,
      ),
    );

    int indexOfPlayer2Card(BackCardController player2Card) =>
        cardStorage.player2Card.indexOf(player2Card);

    await Future.wait(
      cardStorage.player2Card.expand(
        (player2Card) => cardAnimator.movePlayerCard(
          player2Card,
          angle: positions.player2CardAngle(indexOfPlayer2Card(player2Card)),
          position: positions.player2CardPosition(indexOfPlayer2Card(player2Card)),
          duration: 300,
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 180));
  }

  Future<void> player3PlayCard() async {
    int n = cardStorage.player3Pile.length;

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player3Card[n],
        scale: positions.drawScale,
        widthScale: 0,
        angle: 0,
        duration: 100,
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.player3CardPosition(cardStorage.player3Pile.length),
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.topCardPosition,
        scale: positions.topCardScale,
        widthScale: 1,
        duration: 180,
        widthScaleDuration: 100,
      ),
    );

    await cardStorage.player3Card[n].changePosition!.call(
      positions.drawPosition,
      Duration(milliseconds: 100),
      Curves.linear,
    );

    cardStorage.changeDisplayedTopCard();

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.drawPosition,
        scale: positions.drawScale,
        widthScale: 0,
      ),
    );

    int indexOfPlayer3Card(BackCardController player3Card) =>
        cardStorage.player3Card.indexOf(player3Card);

    await Future.wait(
      cardStorage.player3Card.expand(
        (player3Card) => cardAnimator.movePlayerCard(
          player3Card,
          angle: positions.player3CardAngle(indexOfPlayer3Card(player3Card)),
          position: positions.player3CardPosition(indexOfPlayer3Card(player3Card)),
          duration: 300,
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 180));
  }

  Future<void> player4PlayCard() async {
    int n = cardStorage.player4Pile.length;

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player4Card[n],
        scale: positions.drawScale,
        widthScale: 0,
        angle: 0,
        duration: 100,
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.player4CardPosition(cardStorage.player4Pile.length),
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.topCardPosition,
        scale: positions.topCardScale,
        widthScale: 1,
        duration: 180,
        widthScaleDuration: 100,
      ),
    );

    await cardStorage.player4Card[n].changePosition!.call(
      positions.drawPosition,
      Duration(milliseconds: 100),
      Curves.linear,
    );

    cardStorage.changeDisplayedTopCard();

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.drawPosition,
        scale: positions.drawScale,
        widthScale: 0,
      ),
    );

    int indexOfPlayer4Card(BackCardController player4Card) =>
        cardStorage.player4Card.indexOf(player4Card);

    await Future.wait(
      cardStorage.player4Card.expand(
        (player4Card) => cardAnimator.movePlayerCard(
          player4Card,
          angle: positions.player4CardAngle(indexOfPlayer4Card(player4Card)),
          position: positions.player4CardPosition(indexOfPlayer4Card(player4Card)),
          duration: 300,
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 180));
  }

  Future<void> player5PlayCard() async {
    int n = cardStorage.player5Pile.length;

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player5Card[n],
        scale: positions.drawScale,
        widthScale: 0,
        angle: 0,
        duration: 100,
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.player5CardPosition(cardStorage.player5Pile.length),
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.topCardPosition,
        scale: positions.topCardScale,
        widthScale: 1,
        duration: 180,
        widthScaleDuration: 100,
      ),
    );

    await cardStorage.player5Card[n].changePosition!.call(
      positions.drawPosition,
      Duration(milliseconds: 100),
      Curves.linear,
    );

    cardStorage.changeDisplayedTopCard();

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.drawPosition,
        scale: positions.drawScale,
        widthScale: 0,
      ),
    );

    int indexOfPlayer5Card(BackCardController player5Card) =>
        cardStorage.player5Card.indexOf(player5Card);

    await Future.wait(
      cardStorage.player5Card.expand(
        (player5Card) => cardAnimator.movePlayerCard(
          player5Card,
          angle: positions.player5CardAngle(indexOfPlayer5Card(player5Card)),
          position: positions.player5CardPosition(indexOfPlayer5Card(player5Card)),
          duration: 300,
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 180));
  }

  Future<void> player6PlayCard() async {
    int n = cardStorage.player6Pile.length;

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.player6Card[n],
        scale: positions.drawScale,
        widthScale: 0,
        angle: 0,
        duration: 100,
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.player6CardPosition(cardStorage.player6Pile.length),
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.topCardPosition,
        scale: positions.topCardScale,
        widthScale: 1,
        duration: 180,
        widthScaleDuration: 100,
      ),
    );

    await cardStorage.player6Card[n].changePosition!.call(
      positions.drawPosition,
      Duration(milliseconds: 100),
      Curves.linear,
    );

    cardStorage.changeDisplayedTopCard();

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.drawPosition,
        scale: positions.drawScale,
        widthScale: 0,
      ),
    );

    int indexOfPlayer6Card(BackCardController player6Card) =>
        cardStorage.player6Card.indexOf(player6Card);

    await Future.wait(
      cardStorage.player6Card.expand(
        (player6Card) => cardAnimator.movePlayerCard(
          player6Card,
          angle: positions.player6CardAngle(indexOfPlayer6Card(player6Card)),
          position: positions.player6CardPosition(indexOfPlayer6Card(player6Card)),
          duration: 300,
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 180));
  }

  Future<void> putTopCard() async {
    await Future.wait(
      cardAnimator.moveBackCard(scale: 0.75, widthScale: 0, duration: 250),
    );

    await Future.wait(
      cardAnimator.moveTopCard(scale: 1, widthScale: 1, duration: 250),
    );

    await Future.wait(cardAnimator.moveBackCard(widthScale: 1, scale: 0.5));

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.topCardPosition,
        scale: positions.topCardScale,
        duration: 300,
      ),
    );

    cardStorage.changeDisplayedTopCard();

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.drawPosition,
        scale: positions.drawScale,
        widthScale: 0,
      ),
    );
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

  // List<int> playableBotCards() =>
  //     cardStorage.botPile.where((ci) => isPlayable(ci)).toList();

  List<int> playablePlayerCards() =>
      cardStorage.playerPile.where((ci) => isPlayable(ci)).toList();

  Future<void> showPlayableCards() async {
    await Future.wait(
      playablePlayerCards().expand(
        (ci) => cardAnimator.moveCard(
          ci,
          angle: 0,
          position: positions.playableCardPosition(ci),
          duration: 180,
        ),
      ),
    );

    playablePlayerCards().forEach(
      (element) => cardStorage.card[element].controller.locked = false,
    );
  }

  Future<void> unshowPlayableCards({bool didPlay = true}) async {
    Future.wait(
      cardStorage.playerPile.expand(
        (ci) => cardAnimator.moveCard(
          ci,
          angle: positions.playerCardAngle(ci),
          position: positions.playerCardPosition(ci),
          scale: positions.playerCardScale,
          duration: 180,
        ),
      ),
    );

    if (didPlay) {
      await Future.wait(
        cardAnimator.moveCard(
          cardStorage.selectedCard.value,
          position: positions.drawPosition,
          scale: positions.drawScale,
          widthScale: 0,
        ),
      );
    }
  }
}
