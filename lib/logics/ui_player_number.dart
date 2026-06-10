import 'package:flutter/cupertino.dart';

int uiPlayerNumber(int playerCount, int playerNumber) {
  switch (playerCount) {
    case 2:
      if (playerNumber < 1 && playerNumber > 0) {
        return playerNumber;
      } else {
        debugPrint("Invalid playerNumber");
        return 0;
      }
    case 3:
      switch (playerNumber) {
        case 1:
          return 2;
        case 2:
          return 1;
        default:
          debugPrint("Invalid playerNumber");
          return 0;
      }
    case 4:
      switch (playerNumber) {
        case 1:
          return 2;
        case 2:
          return 1;
        case 3:
          return 3;
        default:
          debugPrint("Invalid playerNumber");
          return 0;
      }
    case 5:
      switch (playerNumber) {
        case 1:
          return 4;
        case 2:
          return 2;
        case 3:
          return 1;
        case 4:
          return 3;
        default:
          debugPrint("Invalid playerNumber");
          return 0;
      }
    case 6:
      switch (playerNumber) {
        case 1:
          return 4;
        case 2:
          return 2;
        case 3:
          return 1;
        case 4:
          return 3;
        case 5:
          return 5;
        default:
          debugPrint("Invalid playerNumber");
          return 0;
      }
    default:
      debugPrint("Invalid player count");
      return 0;
  }
}

int realPlayerNumber(int playerCount, int uiPlayerNumber) {
  switch (playerCount) {
    case 2:
      if (uiPlayerNumber < 2 && uiPlayerNumber > 0) {
        return uiPlayerNumber;
      } else {
        debugPrint("Invalid uiPlayerNumber");
        return 0;
      }
    case 3:
      switch (uiPlayerNumber) {
        case 1:
          return 2;
        case 2:
          return 1;
        default:
          debugPrint("Invalid uiPlayerNumber");
          return 0;
      }
    case 4:
      switch (uiPlayerNumber) {
        case 1:
          return 2;
        case 2:
          return 1;
        case 3:
          return 3;
        default:
          debugPrint("Invalid uiPlayerNumber");
          return 0;
      }
    case 5:
      switch (uiPlayerNumber) {
        case 1:
          return 3;
        case 2:
          return 2;
        case 3:
          return 4;
        case 4:
          return 1;
        default:
          debugPrint("Invalid uiPlayerNumber");
          return 0;
      }
    case 6:
      switch (uiPlayerNumber) {
        case 1:
          return 3;
        case 2:
          return 2;
        case 3:
          return 4;
        case 4:
          return 1;
        case 5:
          return 5;
        default:
          debugPrint("Invalid uiPlayerNumber");
          return 0;
      }
    default:
      debugPrint("Invalid player count");
      return 0;
  }
}
