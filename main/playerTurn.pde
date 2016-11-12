
void randomPlayerTurn() {
  
  //Randomly set one of the players to start
  int playerTurn = (int)random(player.length - 1) + 1;
  
  //Get information about the players
  //Test if the random starting player is the same as an ID
  //Set that player's turn to be true
  for (int i=0; i<player.length; i++) {
    if (playerTurn == player[i].id) {
      player[i].playerTurn = true;
    }
  }
}

void nextTurn() {
  
  //Get information about the players
  for (int i=0; i<player.length; i++) {
    
    //Test for the player that is taking their turn
    if(player[i].playerTurn) {
      
      //Set that players turn to false
      player[i].playerTurn = false;
      
      //Make sure that the next player is in the array bounds
      if (i + 1 >= player.length) {
        i -= player.length;
      }
      
      //Set the next player's turn to be true
      player[i + 1].playerTurn = true;
      break;
    }
  }
}