part of '../player_game_play.dart';

extension LogHelpers on PlayerGamePlay {
  Future<void> _sendLog(GameLog log) async {
    await _logsRef.doc(_nextLog.toString()).set(log.toMap());
    _cardStorage.lastLog++;
  }

  Future<Move> _changeTurn(int nextPlayer, {bool? isReverse}) async {
    final log = ChangeTurnLog(
      _nextLog,
      nextPlayer: _cloudPlayerNumber(nextPlayer),
      isReverse: isReverse ?? false,
    );

    await _sendLog(log);

    _turn = nextPlayer;

    return nextPlayer == 0 ? Move.playerTurn : Move.processLog;
  }
}
