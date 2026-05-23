import 'animated-cards/animated_card.dart';

enum CardColor { red, green, blue, yellow, wild }

class EkaCard {
  final int ci;

  int get value {
    if (ci < 100) {
      return (ci % 25 + 1) ~/ 2;
    } else if (ci < 104) {
      return 13;
    } else {
      return 14;
    }
  }

  CardColor get color => CardColor.values[ci ~/ 25];

  final CardController controller;

  EkaCard(this.ci, this.controller);

  bool get isNumber => value < 10;
  bool get isSkip => value == 10;
  bool get isReverse => value == 11;
  bool get isDrawTwo => value == 12;
  bool get isWild => value == 13 || value == 14;
  bool get isWildCard => value == 13;
  bool get isWildDrawFour => value == 14;
}
