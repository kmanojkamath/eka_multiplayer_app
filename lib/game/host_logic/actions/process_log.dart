part of '../host_game_play.dart';

extension ProcessLog on HostGamePlay {
  Future<Move> processLog() async {
    _cardStorage.timer.forward(from: 0);

    final log = await _waitForNextLog();

    switch (log) {
      case ChangeTurnLog(
        nextPlayer: final nextPlayer,
        isReverse: final isReverse,
      ):
        _cardStorage.timer.stop();
        _turn = nextPlayer;
        if (isReverse) _reverse();
        return _turn;

      case PlayerDrawLog(
        playerNumber: final playerNumber,
        drawCards: final drawCards,
      ):
        if (_deckPile.length < drawCards.length) _reshuffle();
        for (int i = 0; i < drawCards.length; i++) {
          _deckPile.remove(drawCards[i]);
          _playerNPile(playerNumber).add(drawCards[i]);
          await _cardAnimations.playerNDrawCard(drawCards[i], playerNumber);
        }
        _cardStorage.timer.forward(from: 0);
        return _turn;

      case PlayerPlayLog(
        playerNumber: final playerNumber,
        putCard: final putCard,
        color: final color,
      ):
        _topCard = putCard;
        if (color != null) _changeColor(color);
        _playerNPile(playerNumber).remove(putCard);
        await _cardAnimations.playerNPlayCard(playerNumber);
        _cardStorage.timer.forward(from: 0);
        return _turn;

      case GameWinLog(playerNumber: int playerNumber):
        _cardStorage.winner = playerNumber;
        return Move.gameWin;

      default:
        debugPrint("Invalid Log in Host Game Play");
        return Move.playerTurn;
    }
  }
}
