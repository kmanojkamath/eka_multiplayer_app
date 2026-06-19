part of '../player_game_play.dart';

extension Waiters on PlayerGamePlay {
  Future<GameLog> _waitForNextLog() async {
    final snap = await _logsRef
        .doc(_nextLog.toString())
        .snapshots()
        .firstWhere((snap) => snap.exists);

    _cardStorage.lastLog++;

    return snap.toGameLog();
  }

  
  Future<void> _waitForPlayer() {
    if (_playablePlayerCards.isEmpty) _cardStorage.canDraw = true;

    final completer = Completer<int>();

    late VoidCallback listener;

    listener = () {
      _cardStorage.selectedCard.removeListener(listener);
      completer.complete(_selectedCard);
    };

    _cardStorage.selectedCard.addListener(listener);
    return completer.future;
  }

  Future<CardColor> _waitForColor() {
    final completer = Completer<CardColor>();

    late VoidCallback listener;
    listener = () {
      _cardStorage.selectedColor.removeListener(listener);
      completer.complete(_selectedColor);
    };

    _cardStorage.selectedColor.addListener(listener);
    return completer.future;
  }

}
