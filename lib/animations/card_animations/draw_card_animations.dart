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
    if (playerNumber == 0) return playerDrawCard(ci);
    int n = positions.cardStorage.playerNPile(playerNumber).length;

    final drawDuration = positions.cardStorage.discardPile.isEmpty ? 100 : 180;
    final moveDuration = positions.cardStorage.discardPile.isEmpty ? 200 : 360;

    int indexOfPlayerNCard(BackCardController playerNCard) =>
        positions.cardStorage.playerNCard(playerNumber).indexOf(playerNCard);

    await Future.wait(
      cardAnimator.movePlayerCard(
        positions.cardStorage.playerNCard(playerNumber).elementAt(n - 1),
        position: positions.drawPosition,
        angle: 0,
        widthScale: 0,
      ),
    );

    await Future.wait([
      ...cardAnimator.movePlayerCard(
        positions.cardStorage.playerNCard(playerNumber).elementAt(n - 1),
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

  Future<void> drawIndicator() async {
    await Future.wait(
      cardAnimator.moveBackCard(
        scale: 0.6,
        angle: right ? 0.12 : -0.12,
        scaleDuration: 100,
        angleDuration: 150,
      ),
    );
    await Future.wait(
      cardAnimator.moveBackCard(angle: right ? -0.12 : 0.12, duration: 75),
    );
    await Future.wait(
      cardAnimator.moveBackCard(angle: right ? 0.12 : -0.12, duration: 75),
    );
    await Future.wait(
      cardAnimator.moveBackCard(angle: right ? -0.12 : 0.12, duration: 75),
    );
    await Future.wait(
      cardAnimator.moveBackCard(angle: right ? 0.12 : -0.12, duration: 75),
    );
    await Future.wait(
      cardAnimator.moveBackCard(angle: right ? -0.12 : 0.12, duration: 75),
    );
    await Future.wait(
      cardAnimator.moveBackCard(
        scale: 0.5,
        angle: 0,
        scaleDuration: 100,
        angleDuration: 150,
      ),
    );
    right = !right;
  }
}
