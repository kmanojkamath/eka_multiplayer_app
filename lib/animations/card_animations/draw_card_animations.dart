part of 'card_animations.dart';

extension DrawCardAnimations on CardAnimations {
  Future<void> playerDrawCard(int ci) async {
    final drawDuration = positions.cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = positions.cardStorage.discardPile.isEmpty ? 200 : 360;

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
      positions.cardStorage.playerPile.expand(
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

  Future<void> playerNDrawCard(int ci, int playerNumber) async {
    int n = positions.cardStorage.playerNPile(playerNumber).length;

    final drawDuration = positions.cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = positions.cardStorage.discardPile.isEmpty ? 200 : 360;

    int indexOfPlayerNCard(BackCardController playerNCard) =>
        positions.cardStorage.playerNCard(playerNumber).indexOf(playerNCard);

    await Future.wait(
      cardAnimator.movePlayerCard(
        positions.cardStorage.playerNCard(playerNumber)[n - 1],
        position: positions.drawPosition,
        angle: 0,
        widthScale: 0,
      ),
    );

    await Future.wait([
      ...cardAnimator.movePlayerCard(
        positions.cardStorage.playerNCard(playerNumber)[n - 1],
        widthScale: 1,
        position: positions.playerNCardPosition(n - 1, playerNumber),
        angle: positions.playerNCardAngle(n - 1, playerNumber),
        duration: moveDuration,
      ),
      ...positions.cardStorage
          .playerNCard(playerNumber)
          .getRange(0, n - 1)
          .expand(
            (i) => cardAnimator.movePlayerCard(
              i,
              position: positions.playerNCardPosition(
                indexOfPlayerNCard(i),
                playerNumber,
              ),
              angle: positions.playerNCardAngle(
                indexOfPlayerNCard(i),
                playerNumber,
              ),
              duration: drawDuration,
            ),
          ),
    ]);
  }
}
