part of '../player_game_play.dart';

extension GameStart on PlayerGamePlay {
  Future<Move> gameStart() async {
    _turn = _localPlayerNumber(startingPlayer);

    final log = await _waitForNextLog() as GameStartLog;

    List<List<int>> P = List.generate(_playerCount, (i) => []);

    for (int i = 0; i < _playerCount; i++) {
      P[i] = log.playerHands[_localPlayerNumber(i)];
      _deckPile.removeWhere((element) => P[i].contains(element));
    }

    for (int j = 0; j < 7; j++) {
      for (int i = 0; i < _playerCount; i++) {
        int t = (i + _localPlayerNumber(startingPlayer)) % _playerCount;
        int ci = P[t][j];
        _playerNPile(t).add(ci);
        if (t != 0) {
          await cardAnimations.playerNDrawCard(ci, t);
        } else {
          await cardAnimations.playerDrawCard(ci);
        }
      }
    }

    _topCard = log.topCard;
    _deckPile.remove(_topCard.ci);

    await cardAnimations.putTopCard();

    debugPrint(_localPlayerNumber(startingPlayer).toString());

    return _localPlayerNumber(startingPlayer) == 0
        ? Move.playerTurn
        : Move.processLog;
  }
}
