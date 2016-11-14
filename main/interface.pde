
int buttonWidth;

void drawInterface() {
  //Set the color of the interface
  //Define the area of the interface
  fill(255);
  rect(0, height - 200, width, 200);

}

void interfaceNextTurn(int infoWidth, int spot) {
  
  fill(255);
  rect(spot * infoWidth + 5, height - 175, infoWidth - 5, 150);
  
  //Set the text size
  //Set the fill color
  //Center the text
  textSize(25);
  fill(0);
  textAlign(CENTER, CENTER);
  
  //Create an end turn button for the players
  text("End Turn", spot * infoWidth + infoWidth / 2, height - 100);
  
  //Set how big the buttons are in the interface
  buttonWidth = infoWidth;
}

void endTurn() {
  
  //Test the mouse position relative to the end turn button
  if (mouseX > width - buttonWidth &&
  mouseX < width &&
  mouseY > height - 200 &&
  mouseY < height) {
    
    //Go to the next player's turn
    nextTurn();
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
      
      int nextPlayer = i + 1;
      
      while (player[nextPlayer].tiles == 0) {
        nextPlayer++;
        
        if (nextPlayer >= player.length) {
          nextPlayer -= player.length;
        }
      }
      
      //Set the next player's turn to be true
      player[nextPlayer].playerTurn = true;
      break;
    }
  }
  
  //Reset all the dice for the player to not have moved
  //Fill unoccupied tiles with basic dice
  resetDiceMovement();
  fillUnoccupiedTiles();
  
  testWinner();
}