import 'dart:math';
import 'dart:ui';

import 'card_storage.dart';

class Positions {
  final CardStorage cardStorage;

  final Size screenSize;

  const Positions(this.cardStorage, this.screenSize);

  Offset playerCardPosition(int ci) {
    int n = cardStorage.playerPile.length;
    int i = cardStorage.playerPile.toList().indexOf(ci);

    double widthDifference = 32 - cardStorage.playerPile.length / 2;

    double lowest = screenSize.height * 0.8;
    double highest = screenSize.height * 0.7;

    double x = i - (n - 1) / 2;

    double cardWidth = 188;
    if (i >= n) {
      return Offset(-200, -200);
    }
    return Offset(
      x * widthDifference +
          screenSize.width / 2 -
          cardWidth * cos(playerCardAngle(ci)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
    );
  }

  double playerCardAngle(int ci) {
    int n = cardStorage.playerPile.length;
    int i = cardStorage.playerPile.toList().indexOf(ci);
    double angle = 0.18 * (1 - (n - 1) / 27);
    return (i - (n - 1) / 2) * angle;
  }

  double get playerCardScale => 1.25 - cardStorage.playerPile.length / 48;

  double playerNCardAngle(int i, int playerNumber) {
    final piles = [
      cardStorage.player2Pile,
      cardStorage.player3Pile,
      cardStorage.player4Pile,
      cardStorage.player5Pile,
      cardStorage.player6Pile,
    ];

    final n = piles[playerNumber - 2].length;

    double angle = 0.12 * (1 - (n - 1) / 27) * (n + 21) / 21;
    return (i - (n - 1) / 2) * angle;
  }

  Offset playerNCardPosition(int i, int playerNumber) {
    final piles = [
      cardStorage.player2Pile,
      cardStorage.player3Pile,
      cardStorage.player4Pile,
      cardStorage.player5Pile,
      cardStorage.player6Pile,
    ];

    final n = piles[playerNumber - 2].length;

    if (i >= n) return Offset(-200, -200);

    final widthDifference = 8 - n / 8;

    final lowest = -screenSize.height * 0.040;
    final highest = -screenSize.height * 0.064;

    final x = i - (n - 1) / 2;

    const cardWidth = 188 * 0.4;

    return Offset(
      x * widthDifference +
          screenSize.width * 0.87 -
          cardWidth * cos(playerNCardAngle(i, playerNumber)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x +
          highest +
          screenSize.height * 0.45,
    );
  }

  double playerNCardScale(int playerNumber) {
    final piles = [
      cardStorage.player2Pile,
      cardStorage.player3Pile,
      cardStorage.player4Pile,
      cardStorage.player5Pile,
      cardStorage.player6Pile,
    ];

    final n = piles[playerNumber - 2].length;

    return 0.625 - n / 96;
  }

  double playableCardAngle(int ci) {
    int n = cardStorage.playerPile.length;
    int i = cardStorage.playerPile.toList().indexOf(ci);
    double angle = 0.18 * (1 - (n - 1) / 54);
    return (i - (n - 1) / 2) * angle;
  }

  Offset playableCardPosition(int ci) {
    int n = cardStorage.playerPile.length;
    int i = cardStorage.playerPile.toList().indexOf(ci);

    double widthDifference = 32 - cardStorage.playerPile.length / 2;

    double x = i - (n - 1) / 2;

    double cardWidth = 188;

    return Offset(
      x * widthDifference + screenSize.width / 2 - cardWidth * 0.5,
      screenSize.height * 0.6,
    );
  }

  double get playableCardScale => 1.25 - cardStorage.playerPile.length / 48;

  Offset get topCardPosition =>
      Offset(screenSize.width * 0.4, screenSize.height * 0.3);
  double get topCardScale => 0.75;

  Offset get drawPosition =>
      Offset(screenSize.width * 0.6, screenSize.height * 0.34);
  double get drawScale => 0.5;
}
