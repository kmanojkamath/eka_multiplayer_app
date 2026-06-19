int uiPlayerNumber(int playerCount, int playerNumber) {
  if (playerCount == 2) return 2;
  if (playerCount == 5) return playerNumber - 1;
  return playerNumber;
}

int realPlayerNumber(int playerCount, int uiPlayerNumber) {
  if (playerCount == 2) return 2;
  if (playerCount == 5) return uiPlayerNumber + 1;
  return uiPlayerNumber;
}
