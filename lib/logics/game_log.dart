import 'package:cloud_firestore/cloud_firestore.dart';

import 'colors.dart';

sealed class GameLog {
  final int index;

  const GameLog(this.index);

  Map<String, dynamic> toMap();

  factory GameLog.fromMap(Map<String, dynamic> map, int index) {
    switch (map['type']) {
      case 'gameInitialization':
        return GameInitializationLog.fromMap(map, index);

      case 'gameStart':
        return GameStartLog.fromMap(map, index);

      case 'playerDraw':
        return PlayerDrawLog.fromMap(map, index);

      case 'playerPlay':
        return PlayerPlayLog.fromMap(map, index);

      case 'changeTurn':
        return ChangeTurnLog.fromMap(map, index);

      case 'gameWin':
        return GameWinLog.fromMap(map, index);

      default:
        throw Exception('Unknown log type: ${map['type']}');
    }
  }
}

class GameInitializationLog extends GameLog {
  final int playerCount;
  final int startingPlayer;

  const GameInitializationLog(
    super.index, {
    required this.playerCount,
    required this.startingPlayer,
  });

  factory GameInitializationLog.fromMap(Map<String, dynamic> map, int index) {
    return GameInitializationLog(
      index,
      playerCount: map['playerCount'],
      startingPlayer: map['startingPlayer'],
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'type': 'gameInitialization',
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

  factory GameStartLog.fromMap(Map<String, dynamic> map, int index) {
    final handsMap = Map<String, dynamic>.from(map['playerHands']);

    final playerHands = List.generate(
      handsMap.length,
      (i) => List<int>.from(handsMap['$i']),
    );

    return GameStartLog(
      index,
      playerHands: playerHands,
      deckPile: List<int>.from(map['deckPile']),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'type': 'gameStart',
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

  factory PlayerDrawLog.fromMap(Map<String, dynamic> map, int index) {
    return PlayerDrawLog(
      index,
      playerNumber: map['playerNumber'],
      drawCards: List<int>.from(map['drawCards']),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'type': 'playerDraw',
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

  factory PlayerPlayLog.fromMap(Map<String, dynamic> map, int index) {
    return PlayerPlayLog(
      index,
      playerNumber: map['playerNumber'],
      putCard: map['putCard'],
      color: map['color'] == null ? null : CardColor.values[map['color']],
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'type': 'playerPlay',
    'playerNumber': playerNumber,
    'putCard': putCard,
    if (color != null) 'color': color!.index,
    'timestamp': FieldValue.serverTimestamp(),
  };
}

class ChangeTurnLog extends GameLog {
  final int nextPlayer;
  final bool isReverse;

  const ChangeTurnLog(
    super.index, {
    required this.nextPlayer,
    required this.isReverse,
  });

  factory ChangeTurnLog.fromMap(Map<String, dynamic> map, int index) {
    return ChangeTurnLog(
      index,
      nextPlayer: map['nextPlayer'],
      isReverse: map['isReverse'],
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'type': 'changeTurn',
    'nextPlayer': nextPlayer,
    'isReverse': isReverse,
    'timestamp': FieldValue.serverTimestamp(),
  };
}

class GameWinLog extends GameLog {
  final int playerNumber;

  const GameWinLog(super.index, {required this.playerNumber});

  factory GameWinLog.fromMap(Map<String, dynamic> map, int index) {
    return GameWinLog(index, playerNumber: map['playerNumber']);
  }

  @override
  Map<String, dynamic> toMap() => {
    'type': 'gameWin',
    'playerNumber': playerNumber,
    'timestamp': FieldValue.serverTimestamp(),
  };
}

extension GameLogSnapshot on DocumentSnapshot {
  GameLog toGameLog() {
    return GameLog.fromMap(data()! as Map<String, dynamic>, int.parse(id));
  }
}
