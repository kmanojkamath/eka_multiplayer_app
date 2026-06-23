part of '../player_game_play.dart';

extension GettersSetters on PlayerGamePlay {
  CardStorage get _cardStorage => cardAnimations.positions.cardStorage;

  int get _playerCount => _cardStorage.playerCount;

  SplayTreeSet<int> _playerNPile(int playerNumber) =>
      _cardStorage.playerNPile(playerNumber);
  List<int> get _deckPile => _cardStorage.deckPile;
  List<int> get _discardPile => _cardStorage.discardPile;
  
  EkaCard get _topCard => _cardStorage.topCard;
  set _topCard(int ci) {
    _cardStorage.topCard = ci;
  }

  CollectionReference get _logsRef => roomRef.collection('logs');
  int get _nextLog => _cardStorage.lastLog + 1;

  int get _selectedCard => _cardStorage.selectedCard.value;
  CardColor get _selectedColor => _cardStorage.selectedColor.value;
  bool get _movingForward => _cardStorage.movingForward;

  Move get _turn => _cardStorage.turn.value == 0 ? Move.playerTurn : Move.processLog;
  set _turn(int playerNumber) {
    _cardStorage.turn.value = playerNumber;
  }
}