part of '../host_game_play.dart';

extension GameStart on HostGamePlay {
  Future<Move> gameStart() async {
    List<List<int>> P = List.filled(_playerCount, []);

    for (int i = 0; i < _playerCount; i++) {
      P[i] = _deckPile.sublist(_deckPile.length - 7).cast();
      _deckPile.removeRange(_deckPile.length - 7, _deckPile.length);
    }

    while (!_cardStorage.card[_deckPile.last].isNumber) {
      _deckPile.insert(0, _deckPile.removeLast());
    }

    final log = GameStartLog(1, playerHands: P, topCard: _deckPile.last);
    await _sendLog(log);

    for (int j = 0; j < 7; j++) {
      for (int i = 0; i < _playerCount; i++) {
        int t = (i + startingPlayer) % _playerCount;
        int ci = P[t][j];
        _playerNPile(t).add(ci);
        if (t != 0) {
          await _cardAnimations.playerNDrawCard(ci, t);
        } else {
          await _cardAnimations.playerDrawCard(ci);
        }
      }
    }
    _topCard = _deckPile.removeLast();

    await _cardAnimations.putTopCard();

     _turn = startingPlayer;

    return _turn;
  }
}