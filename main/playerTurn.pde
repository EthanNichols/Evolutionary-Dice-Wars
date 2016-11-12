
void randomPlayerTurn() {
  int playerTurn = (int)random(player.length);
  
  for (int i=0; i<player.length; i++) {
    if (playerTurn == player[i].id) {
      player[i].playerTurn = true;
    }
  }
}

void nextTurn() {
  for (int i=0; i<player.length; i++) {
    if(player[i].playerTurn) {
      
      player[i].playerTurn = false;
      
      if (i + 1 >= player.length) {
        i = -1;
      }
      player[i + 1].playerTurn = true;
      break;
    }
  }
}