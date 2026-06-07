part of 'card_animations.dart';

extension TopCardAnimations on CardAnimations {
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
}