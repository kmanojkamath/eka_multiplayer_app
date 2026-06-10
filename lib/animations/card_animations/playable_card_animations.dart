part of 'card_animations.dart';

extension PlayableCardAnimations on CardAnimations {
  bool isPlayable(int ci) {
    final top = positions.cardStorage.topCard;
    final card = positions.cardStorage.card[ci];

    return (top.isWild &&
            (card.color == positions.cardStorage.selectedColor.value ||
                card.isWild)) ||
        card.isWild ||
        card.color == top.color ||
        card.value == top.value;
  }

  List<int> playablePlayerCards() =>
      positions.cardStorage.playerPile.where((ci) => isPlayable(ci)).toList();

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
      (element) =>
          positions.cardStorage.card[element].controller.locked = false,
    );
  }

  Future<void> unshowPlayableCards({bool didPlay = true}) async {
    Future.wait(
      positions.cardStorage.playerPile.expand(
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
          positions.cardStorage.selectedCard.value,
          position: positions.drawPosition,
          scale: positions.drawScale,
          widthScale: 0,
        ),
      );
    }
  }
}
