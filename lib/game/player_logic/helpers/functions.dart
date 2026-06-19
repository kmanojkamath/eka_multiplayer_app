part of '../player_game_play.dart';

extension Functions on PlayerGamePlay {
  void _changeColor(CardColor color) {
    _cardStorage.selectedColor.value = color;
  }

  int _localPlayerNumber(int playerNumber) {
    return (_playerCount + playerNumber - currentPlayer) % _playerCount;
  }

  int _cloudPlayerNumber(int playerNumber) {
    return (playerNumber + currentPlayer) % _playerCount;
  }

  void _reverse() {
    _cardStorage.movingForward = !_movingForward;
  }

  void _reshuffle() {
    _deckPile.clear();
    _deckPile.addAll(_discardPile);
    _deckPile.remove(_topCard.ci);
    _deckPile.shuffle();

    int tc = _topCard.ci;
    _discardPile.clear();
    _discardPile.add(tc);
  }

  
  bool _isPlayable(int ci) {
    final top = _cardStorage.topCard;
    final card = _cardStorage.card[ci];

    return (top.isWild && (card.color == _selectedColor || card.isWild)) ||
        card.isWild ||
        card.color == top.color ||
        card.value == top.value;
  }

  List<int> get _playablePlayerCards =>
      _playerNPile(0).where((ci) => _isPlayable(ci)).toList();

}
