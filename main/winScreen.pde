

void setRanks() {
  
  int playersLeft = player.length;
  
  for (int p=0; p<player.length; p++) {
    if (player[p].rank == 0) {
      playersLeft--;
    }
  }
  
  while (playersLeft > 0) {
    
    int mostTiles = 0;
    int nextRank = mapWidth * mapHeight;
    
    for (int p=0; p<player.length; p++) {
      if (player[p].rank == 0) {
        if (player[p].tiles < mostTiles) {
          mostTiles = player[p].tiles;
          nextRank = player[p].id;
        }
      }
    }
    
    for (int p=0; p<player.length; p++) {
      if (nextRank == player[p].id) {
        player[p].rank = playersLeft;
      }
    }
    playersLeft--;
  }
}

void drawWinScreen() {
  
  for (int p=0; p<player.length; p++) {
    
    if (player[p].rank == 1) {
      fill(player[p].playerColor);
      textSize(50);
      textAlign(CENTER, CENTER);
      text("Player: " + player[p].id + " won!", width / 2, height / 2);
    }
  }
}