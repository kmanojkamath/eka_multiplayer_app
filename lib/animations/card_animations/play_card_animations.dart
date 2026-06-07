part of 'card_animations.dart';

extension PlayCardAnimations on CardAnimations {
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

  Future<void> playerNPlayCard(int playerNumber) async {
    int n = cardStorage.playerNPile(playerNumber).length;

    await Future.wait(
      cardAnimator.movePlayerCard(
        cardStorage.playerNCard(playerNumber)[n],
        scale: positions.drawScale,
        widthScale: 0,
        angle: 0,
        duration: 100,
      ),
    );

    await Future.wait(
      cardAnimator.moveTopCard(
        position: positions.playerNCardPosition(cardStorage.player2Pile.length, playerNumber),
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

    await cardStorage.playerNCard(playerNumber)[n].changePosition!.call(
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

    int indexOfPlayerNCard(BackCardController playerNCard) =>
        cardStorage.playerNCard(playerNumber).indexOf(playerNCard);

    await Future.wait(
      cardStorage.playerNCard(playerNumber).expand(
        (playerNCard) => cardAnimator.movePlayerCard(
          playerNCard,
          angle: positions.playerNCardAngle(indexOfPlayerNCard(playerNCard),playerNumber),
          position: positions.playerNCardPosition(indexOfPlayerNCard(playerNCard),playerNumber),
          duration: 300,
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 180));
  }
}