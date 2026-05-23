import 'dart:math';
import 'dart:ui';

import 'package:eka_multiplayer_app/items/card/card_storage.dart';

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

  double player2CardAngle(int i) {
    int n = cardStorage.player2Pile.length;
    double angle = 0.12 * (1 - (n - 1) / 27) * (n + 21) / 21;
    return (i - (n - 1) / 2) * angle;
  }

  double player3CardAngle(int i) {
    int n = cardStorage.player3Pile.length;
    double angle = 0.12 * (1 - (n - 1) / 27) * (n + 21) / 21;
    return (i - (n - 1) / 2) * angle;
  }

  double player4CardAngle(int i) {
    int n = cardStorage.player4Pile.length;
    double angle = 0.12 * (1 - (n - 1) / 27) * (n + 21) / 21;
    return (i - (n - 1) / 2) * angle;
  }

  double player5CardAngle(int i) {
    int n = cardStorage.player5Pile.length;
    double angle = 0.12 * (1 - (n - 1) / 27) * (n + 21) / 21;
    return (i - (n - 1) / 2) * angle;
  }

  double player6CardAngle(int i) {
    int n = cardStorage.player6Pile.length;
    double angle = 0.12 * (1 - (n - 1) / 27) * (n + 21) / 21;
    return (i - (n - 1) / 2) * angle;
  }

  Offset player2CardPosition(int i) {
    int n = cardStorage.player2Pile.length;

    double widthDifference = 8 - cardStorage.player2Pile.length / 8;

    double lowest = -screenSize.height * 0.036;
    double highest = -screenSize.height * 0.059;

    double x = i - (n - 1) / 2;

    double cardWidth = 188 * 0.4;

    if (i >= n) {
      return Offset(-200, -200);
    }
    return Offset(
      x * widthDifference +
          screenSize.width / 2 -
          cardWidth * cos(player2CardAngle(i)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x + highest,
    );
  }

  Offset player3CardPosition(int i) {
    int n = cardStorage.player3Pile.length;

    double widthDifference = 8 - cardStorage.player3Pile.length / 8;

    double lowest = -screenSize.height * 0.040;
    double highest = -screenSize.height * 0.064;

    double x = i - (n - 1) / 2;

    double cardWidth = 188 * 0.4;

    if (i >= n) {
      return Offset(-200, -200);
    }
    return Offset(
      x * widthDifference +
          screenSize.width * 0.24 -
          cardWidth * cos(player3CardAngle(i)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x +
          highest +
          screenSize.height * 0.125,
    );
  }

  Offset player4CardPosition(int i) {
    int n = cardStorage.player4Pile.length;

    double widthDifference = 8 - cardStorage.player4Pile.length / 8;

    double lowest = -screenSize.height * 0.040;
    double highest = -screenSize.height * 0.064;

    double x = i - (n - 1) / 2;

    double cardWidth = 188 * 0.4;

    if (i >= n) {
      return Offset(-200, -200);
    }
    return Offset(
      x * widthDifference +
          screenSize.width * 0.76 -
          cardWidth * cos(player4CardAngle(i)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x +
          highest +
          screenSize.height * 0.12,
    );
  }

  Offset player5CardPosition(int i) {
    int n = cardStorage.player5Pile.length;

    double widthDifference = 8 - cardStorage.player5Pile.length / 8;

    double lowest = -screenSize.height * 0.040;
    double highest = -screenSize.height * 0.064;

    double x = i - (n - 1) / 2;

    double cardWidth = 188 * 0.4;

    if (i >= n) {
      return Offset(-200, -200);
    }
    return Offset(
      x * widthDifference +
          screenSize.width * 0.13 -
          cardWidth * cos(player5CardAngle(i)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x +
          highest +
          screenSize.height * 0.45,
    );
  }

  Offset player6CardPosition(int i) {
    int n = cardStorage.player6Pile.length;

    double widthDifference = 8 - cardStorage.player6Pile.length / 8;

    double lowest = -screenSize.height * 0.040;
    double highest = -screenSize.height * 0.064;

    double x = i - (n - 1) / 2;

    double cardWidth = 188 * 0.4;

    if (i >= n) {
      return Offset(-200, -200);
    }
    return Offset(
      x * widthDifference +
          screenSize.width * 0.87 -
          cardWidth * cos(player6CardAngle(i)) * 0.5,
      (lowest - highest) / ((n / 2) * (n / 2)) * x * x +
          highest +
          screenSize.height * 0.45,
    );
  }

  double get player2CardScale => 0.625 - cardStorage.player2Pile.length / 96;

  double get player3CardScale => 0.625 - cardStorage.player3Pile.length / 96;

  double get player4CardScale => 0.625 - cardStorage.player4Pile.length / 96;

  double get player5CardScale => 0.625 - cardStorage.player5Pile.length / 96;

  double get player6CardScale => 0.625 - cardStorage.player6Pile.length / 96;

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
