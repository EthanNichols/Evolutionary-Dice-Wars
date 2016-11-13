
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

void selectTile() {
  
  //Local variable to know which tile is selected
  int selectionID = 0;
  
  //Get information about the tiles
  for (int i=0; i<tile.length; i++) {
    
    //Test the center area of the hexagon
    if (mouseX >= tile[i].posX + tile[i].posXOffset && 
    mouseX <= tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width - 1 &&
    mouseY >= tile[i].posY + tile[i].posYOffset + 35 &&
    mouseY <= tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - 35) {
      selectionID = tile[i].id;
      
    //Test the upper Left hand corner of the hexagon
    } else if (mouseX > tile[i].posX + tile[i].posXOffset &&
    mouseX < tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2 &&
    mouseY > tile[i].posY + tile[i].posYOffset + 35 - floor((mouseX - (tile[i].posX + tile[i].posXOffset)) / 2)  &&
    mouseY < tile[i].posY + tile[i].posYOffset + 35) {
      selectionID = tile[i].id;
      
    //Test the upper right hand corner of the hexagon
    } else if (mouseX > tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2 &&
    mouseX < tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width &&
    mouseY > tile[i].posY + tile[i].posYOffset + floor((mouseX - ((tile[i].posX + tile[i].posXOffset) + tile[i].tileImage.width / 2)) / 2)  &&
    mouseY < tile[i].posY + tile[i].posYOffset + 35) {
      selectionID = tile[i].id;
      
    //Test the lower Left hand corner of the hexagon
    } else if (mouseX > tile[i].posX + tile[i].posXOffset &&
    mouseX < tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2 &&
    mouseY > tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - 35  &&
    mouseY < tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - 35 + floor((mouseX - (tile[i].posX + tile[i].posXOffset)) / 2)) {
      selectionID = tile[i].id;
      
    //Test the lower right hand corner of the hexagon
    } else if (mouseX > tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2 &&
    mouseX < tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width &&
    mouseY > tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - 35 &&
    mouseY < tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - floor((mouseX - ((tile[i].posX + tile[i].posXOffset) + tile[i].tileImage.width / 2)) / 2)) {
      selectionID = tile[i].id;
    }
  }
  
  //Local varible to see which function to call
  boolean secondTileSelect = false;
  int selectedTile = 0;
  
  //Get information about the tiles
  for (int i=0; i<tile.length; i++) {
    
    //Test for a tile that is select
    //Set the local variable to true to call the second function
    if (tile[i].selected) {
      secondTileSelect = true;
      selectedTile = tile[i].id;
      break;
    }
  }
  
  //Test to see which function should be called
  //Send which tile has been selected to respective function
  if (!secondTileSelect) {
    selectPlayerTile(selectionID);
  } else {
    secondPlayerSelection(selectedTile, selectionID);
  }
}

void selectPlayerTile(int selectionID) {
  
  //Get informatio about the players
  for (int p=0; p<player.length; p++) {
    
    //Test for the player that is taking their turn
    //Get information ahout the tiles
    if (player[p].playerTurn) {
      for (int i=0; i<tile.length; i++) {
        
        //Test that the tile was selcted
        //Test if the tile select has the same id as the player
        if (tile[i].id == selectionID && tile[i].player == player[p].id) {
          //Set the tile to be selected
          tile[i].selected = true;
        }
      }
    }
  }
}

void secondPlayerSelection(int selectedTile, int selectionID) {
  
  //Test if the dice can move
  boolean move = false;
  
  //Get information about the tiles
  for (int i=0; i<tile.length; i++) {
    
    //Test for the tiles that has the first selection tile id
    if (selectionID == tile[i].id) {
      
      //Test for tiles around the first selected tile
      //Set that tile to be selected
      //Set that the dice can move
      if (tile[i].id == selectedTile + 1) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile - 1) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile - (mapWidth - 1)) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile - mapWidth) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile - (mapWidth + 1)) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile + (mapWidth - 1)) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile + mapWidth) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile + (mapWidth + 1)) {tile[i].selected = true; move = true; break;}
    }
  }
  
  //Test if the ddice can move
  //Move the dice
  if (move == true) {
    moveDice(selectedTile, selectionID);
  }
  
  //Reset the selected tiles so that no tiles are selected
  resetSelection();
}

void resetSelection() {
  
  //Get information about the tiles
  //Set all of the tiles to not be select
  for(int i=0; i<tile.length; i++) {
    tile[i].selected = false;
  }
}