

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
  
  background(0);
  
  for (int p=0; p<player.length; p++) {
    
    if (player[p].rank == 1) {
      fill(player[p].playerColor);
      textSize(50);
      textAlign(CENTER, CENTER);
      text("Congratulations Player " + player[p].id + " you won!", width / 2, height / 2);
      
      textSize(25);
      fill(255);
      text("Created for RIT Imagine Cup 2016", width / 2, (height / 15) * 11);
      text("Developed in under 36 hours", width / 2, (height / 15) * 12);
      text("Programmer and Artist", width / 2, (height / 15) * 13);
      text("Ethan Nichols", width / 2, (height / 15) * 14);
    }
  }
}