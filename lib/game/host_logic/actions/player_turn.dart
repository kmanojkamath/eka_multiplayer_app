part of '../host_game_play.dart';

extension PlayerTurn on HostGamePlay {
  Future<Move> _drawForPlayer() async {
    if (_deckPile.isEmpty) _reshuffle();

    int ci = _deckPile.removeLast();

    final log = PlayerDrawLog(_nextLog, playerNumber: 0, drawCards: [ci]);
    await _sendLog(log);

    _playerNPile(0).add(ci);

    await _cardAnimations.playerDrawCard(ci);

    if (_isPlayable(ci)) {
      return Move.playerTurn;
    } else {
      _cardAnimations.unshowPlayableCards(didPlay: false);
      return _changeTurn(_movingForward ? 1 : _playerCount - 1);
    }
  }

  Future<Move> playerTurn() async {
    _cardStorage.timer.forward(from: 0);

    await _cardAnimations.showPlayableCards();

    await _waitForPlayer();

    _cardStorage.timer.stop();

    if (_selectedCard < 0) return _drawForPlayer();

    await _cardAnimations.playerPlayCard();

    _topCard = _selectedCard;

    _playerNPile(0).remove(_selectedCard);

    late PlayerPlayLog log;

    if (_topCard.isWild) {
      _cardStorage.timer.forward();

      _changeColor(CardColor.wild);

      _cardStorage.showColorSelector.call();

      await _waitForColor();

      _cardStorage.timer.stop();

      await Future.delayed(Duration(milliseconds: 420));

      log = PlayerPlayLog(
        _nextLog,
        playerNumber: 0,
        putCard: _selectedCard,
        color: _selectedColor,
      );
    } else {
      log = PlayerPlayLog(_nextLog, playerNumber: 0, putCard: _selectedCard);
    }

    await _sendLog(log);

    _cardStorage.changeDisplayedTopCard();

    if (_playerNPile(0).isEmpty) {
      final log = GameWinLog(_nextLog, playerNumber: 0);
      await _sendLog(log);
      _cardStorage.winner = 0;
      return Move.gameWin;
    }

    await _cardAnimations.unshowPlayableCards();

    _playerNPile(0).remove(_selectedCard);
    _topCard = _selectedCard;

    if (_topCard.isDrawTwo) {
      if (_deckPile.length < 2) _reshuffle();
      final int ci1 = _deckPile.removeLast();
      final int ci2 = _deckPile.removeLast();

      final prey = _movingForward ? 1 : _playerCount - 1;

      final log = PlayerDrawLog(
        _nextLog,
        playerNumber: prey,
        drawCards: [ci1, ci2],
      );

      _sendLog(log);

      _playerNPile(prey).add(ci1);
      await _cardAnimations.playerNDrawCard(ci1, prey);
      _playerNPile(prey).add(ci2);
      await _cardAnimations.playerNDrawCard(ci2, prey);

      if (_movingForward) {
        return _changeTurn(2 % _playerCount);
      } else {
        return _changeTurn(_playerCount - 2);
      }
    } else if (_topCard.isNumber || _topCard.isWildCard) {
      return _changeTurn(_movingForward ? 1 : _playerCount - 1);
    } else if (_topCard.isReverse) {
      _reverse();
      return _changeTurn(
        _movingForward ? 1 : _playerCount - 1,
        isReverse: true,
      );
    } else if (_topCard.isSkip) {
      return _changeTurn(_movingForward ? 2 % _playerCount : _playerCount - 2);
    } else if (_topCard.isWildDrawFour) {
      if (_deckPile.length < 4) _reshuffle();
      final List<int> cis = [];
      for (int i = 0; i < 4; i++) {
        cis.add(_deckPile.removeLast());
      }

      final prey = _movingForward ? 1 : _playerCount - 1;

      final log = PlayerDrawLog(_nextLog, playerNumber: prey, drawCards: cis);

      await _sendLog(log);

      for (int i = 0; i < 4; i++) {
        _playerNPile(prey).add(cis[i]);
        await _cardAnimations.playerNDrawCard(cis[i], prey);
      }

      return _changeTurn(_movingForward ? 2 % _playerCount : _playerCount - 2);
    } else {
      debugPrint("TopCard is ${_topCard.ci}");
      return _changeTurn(1);
    }
  }
}
