import 'package:cloud_firestore/cloud_firestore.dart';

import 'colors.dart';

sealed class GameLog {
  final int index;

  const GameLog(this.index);

  Map<String, dynamic> toMap();
}

class GameInitializationLog extends GameLog {
  final int playerCount;
  final int startingPlayer;

  const GameInitializationLog(
    super.index, {
    required this.playerCount,
    required this.startingPlayer,
  });

  @override
  Map<String, dynamic> toMap() => {
    'type': 'gameInitialization',
    'index': index,
    'playerCount': playerCount,
    'startingPlayer': startingPlayer,
    'timestamp': FieldValue.serverTimestamp(),
  };
}

class GameStartLog extends GameLog {
  final List<List<int>> playerHands;
  final List<int> deckPile;

  const GameStartLog(
    super.index, {
    required this.playerHands,
    required this.deckPile,
  });

  @override
  Map<String, dynamic> toMap() => {
    'type': 'gameStart',
    'index': index,
    'playerHands': {
      for (int i = 0; i < playerHands.length; i++) '$i': playerHands[i],
    },
    'deckPile': deckPile,
    'timestamp': FieldValue.serverTimestamp(),
  };
}

class PlayerDrawLog extends GameLog {
  final int playerNumber;
  final List<int> drawCards;

  const PlayerDrawLog(
    super.index, {
    required this.playerNumber,
    required this.drawCards,
  });

  @override
  Map<String, dynamic> toMap() => {
    'type': 'playerDraw',
    'index': index,
    'playerNumber': playerNumber,
    'drawCards': drawCards,
    'timestamp': FieldValue.serverTimestamp(),
  };
}

class PlayerPlayLog extends GameLog {
  final int playerNumber;
  final int putCard;
  final CardColor? color;

  const PlayerPlayLog(
    super.index, {
    required this.playerNumber,
    required this.putCard,
    this.color,
  });

  @override
  Map<String, dynamic> toMap() => {
    'type': 'playerPlay',
    'index': index,
    'playerNumber': playerNumber,
    'putCard': putCard,
    if (color != null) 'color': color!.index,
    'timestamp': FieldValue.serverTimestamp(),
  };
}

class ChangeTurnLog extends GameLog {
  final int nextPlayer;
  final bool isReverse;

  const ChangeTurnLog(super.index, {required this.nextPlayer, required this.isReverse});

  @override
  Map<String, dynamic> toMap() => {
    'type': 'changeTurn',
    'index': index,
    'nextPlayer': nextPlayer,
    'isReverse': isReverse,
    'timestamp': FieldValue.serverTimestamp(),
  };
}

class GameWinLog extends GameLog {
  final int playerNumber;

  const GameWinLog(super.index, {required this.playerNumber});

  @override
  Map<String, dynamic> toMap() => {
    'type': 'gameWin',
    'index': index,
    'playerNumber': playerNumber,
    'timestamp': FieldValue.serverTimestamp(),
  };
}