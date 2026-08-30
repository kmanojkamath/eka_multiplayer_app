part of '../player_game_play.dart';

extension GameStart on PlayerGamePlay {
  Future<Move> gameStart() async {
    final log = await _waitForNextLog() as GameStartLog;

    List<List<int>> P = List.generate(_playerCount, (i) => []);

    for (int i = 0; i < _playerCount; i++) {
      P[i] = log.playerHands[i];
      _deckPile.removeWhere((element) => P[i].contains(element));
    }

    for (int j = 0; j < 7; j++) {
      for (int i = 0; i < _playerCount; i++) {
        int t = (i + _localPlayerNumber(_startingPlayer)) % _playerCount;
        int ci = P[_cloudPlayerNumber(t)][j];
        _playerNPile(t).add(ci);
        if (t != 0) {
          await _cardAnimations.playerNDrawCard(ci, t);
        } else {
          await _cardAnimations.playerDrawCard(ci);
        }
      }
    }

    _topCard = log.topCard;
    _deckPile.remove(_topCard.ci);

    await _cardAnimations.putTopCard();

    debugPrint(_localPlayerNumber(_startingPlayer).toString());

    _turn = _localPlayerNumber(_startingPlayer);

    return _turn;
  }
}
