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

  Future<void> waitUntilFalseOrTimeout() async {
    final timeout = DateTime.now().add(const Duration(milliseconds: 500));

    while (_cardStorage.canDraw && DateTime.now().isBefore(timeout)) {
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  Future<int> _waitForPlayer() async {
    if (_playablePlayerCards.isEmpty) {
      _cardStorage.canDraw = true;
      while (_cardStorage.canDraw) {
        await waitUntilFalseOrTimeout();
        if (!_cardStorage.canDraw) break;
        await cardAnimations.drawIndicator();
      }
    }
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
