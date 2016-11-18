
//How wide all of the buttons on the inferface are
int buttonWidth;

void drawInterface() {
  //Set the color of the interface
  //Define the area of the interface
  fill(255);
  rect(-1, height - 200, width + 1, 200);
}

void interfaceNextTurn(int infoWidth, int spot) {

  //Set the fill color for the end turn rectangle to white
  //Draw the rectangle on the right side of the interface
  fill(255);
  rect(spot * infoWidth + 5, height - 175, infoWidth - 10, 150);

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
    if (player[i].playerTurn) {

      //Set that players turn to false
      player[i].playerTurn = false;

      //Make sure that the next player is in the array bounds
      //Wrap around back to the beginning of the array
      if (i + 1 >= player.length) {
        i -= player.length;
      }

      //local variable to go to the next player, who's still playing
      int nextPlayer = i + 1;

      //Test if the player that is going next has tiles
      while (player[nextPlayer].tiles == 0) {

        //If they don't keep going to the next player
        nextPlayer++;

        //Test if the next player is within te array bounds
        //Wrap around back to the beginning of the aray
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

  //Test if one of the players has won
  testWinner();
}