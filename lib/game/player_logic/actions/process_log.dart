part of '../player_game_play.dart';

extension ProcessLog on PlayerGamePlay {
  Future<Move> processLog() async {
    final log = await _waitForNextLog();

    switch (log) {
      case ChangeTurnLog(
        nextPlayer: final nextPlayer,
        isReverse: final isReverse,
      ):
        _turn = _localPlayerNumber(nextPlayer);
        if (isReverse) _reverse();
        return _localPlayerNumber(nextPlayer) == 0
            ? Move.playerTurn
            : Move.processLog;

      case PlayerDrawLog(
        playerNumber: final playerNumber,
        drawCards: final drawCards,
      ):
        if (_deckPile.length < drawCards.length) _reshuffle();
        for (int i = 0; i < drawCards.length; i++) {
          _deckPile.remove(drawCards[i]);
          _playerNPile(_localPlayerNumber(playerNumber)).add(drawCards[i]);

          await cardAnimations.playerNDrawCard(
            drawCards[i],
            _localPlayerNumber(playerNumber),
          );
        }
        return _turn;

      case PlayerPlayLog(
        playerNumber: int playerNumber,
        putCard: final putCard,
        color: final color,
      ):
        if (color != null) _changeColor(color);
        playerNumber = _localPlayerNumber(playerNumber);
        _topCard = putCard;
        _playerNPile(playerNumber).remove(putCard);
        await cardAnimations.playerNPlayCard(playerNumber);
        return _turn;

      case GameWinLog(playerNumber: final playerNumber):
        _cardStorage.winner = playerNumber;
        return Move.gameWin;

      default:
        debugPrint("Invalid Log in Host Game Play");
        return Move.playerTurn;
    }
  }
}
