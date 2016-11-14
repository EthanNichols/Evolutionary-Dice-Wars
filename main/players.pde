
players[] player = {};

class players {
  //The id of the player
  //The starting location for the player on the map
  //Whether it's the player's turn or not
  int id;
  int startID;
  boolean playerTurn;
  int rank;
  
  //The position of the player information on the interface
  int posX;
  int posY;
  
  //The color of the player
  //How many tiles the player controls
  color playerColor;
  int tiles;
  
  
  players(color colorOfPlayer) {
    //Set the player id
    //Set the starting position to a random place on the map
    id = player.length + 1;
    startID = (int)random(tile.length);
    rank = 0;
    
    //Set the player's turn to false
    playerTurn = false;
    
    //Set the amount of tiles the player owns to 0
    //Set the color of the player
    tiles = 0;
    playerColor = colorOfPlayer;
  }
  
  void display(int infoWidth, int player) {
    
    //Test if the player is taking their turn
    //Set the color of the rectangle to green
    //Draw a rectangle behind the player taking their turn
    if (playerTurn) {
      fill(75, 255, 150);
      rect(player * infoWidth + 25, height - 200, infoWidth - 50, 200);
    }
    
    //Set the fill color to the player's color
    //Draw the player information box in the interface
    fill(playerColor);
    rect(player * infoWidth + 5, height - 175, infoWidth - 5, 150);
    
    //Set the color of the font to black
    //Set the font size
    //Center the text
    fill(0);
    textSize(25);
    textAlign(CENTER, CENTER);
    
    //Print how many territories the player owns
    text(tiles, player * infoWidth + infoWidth / 2, height - 100);
  }
}

void createPlayers(int players) {
  
  int playerAmount = players;
  //Test if there will be more players playing than before
  if (playerAmount > player.length) {
    
    //Set how many players need to be created
    int newPlayerAmount = playerAmount - player.length;
    
    //Create the necesary amount of players
    for (int i=0; i< newPlayerAmount; i++) {
      
      //Set the color of the player compared to how many players there are
      color playerColor = color((255 / newPlayerAmount) * i, 255, 255);
      
      //Create a new player
      player = (players[])append(player, new players(playerColor));
    }
  }
  
  //Place where the players are going to start
  //Set which player will start the game
  
  if (optButton[3].value == 0) {
    placePlayersOnce();
  } else {
    fillTheMap();
  }
  randomPlayerTurn();
}

void placePlayersOnce() {
  
  //Get information about the players
  //Get information about the tiles
  for (int p=0; p<player.length; p++) {
    for (int t=0; t<tile.length; t++) {
      
      //Test if the player starting place is equal to the player ID 
      if (player[p].startID + 1 == tile[t].id) {
        
        int tileID = t;
        
        while (tile[tileID].occupied) {
          
          tileID++;
          
          print(tileID);
          
          if (tileID >= tile.length) {
            tileID -= tile.length;
          }
        }
        
        println(p + "   " + tile[tileID].occupied);
        
        //Set the tile to be occupied by the player
        //Set that the tile is occupied
        //Set the color of the tile to the player color
        tile[tileID].player = player[p].id;
        tile[tileID].occupied = true;
        tile[tileID].playerColor = player[p].playerColor;
        
        //Local X and Y variables for the center of the tile
        int x = tile[tileID].posX + tile[tileID].posXOffset + tile[tileID].tileImage.width / 2;
        int y = tile[tileID].posY  + tile[tileID].posYOffset + tile[tileID].tileImage.height / 2;
        
        //Create a dice at that location and with the player's color
        //Increase the amount of tiles that the player owns
        createDie(x, y, 4, player[p].id, tile[tileID].id);
        
        player[p].tiles++;
      }
    }
  }
}

void fillTheMap() {
  
  int tilesToFill = tile.length;
  
  while (tilesToFill - player.length > 0) {
    for (int p=0; p<player.length; p++) {
      
      int randomID = floor(random(tile.length));
      
      for (int t=0; t<tile.length; t++) {
        if (tile[t].id == randomID) {
          
          int nextTile = t;
          while (tile[nextTile].occupied) {
            nextTile++;
            
            if (nextTile >= tile.length) {
              nextTile -= tile.length;
            }
          }
          
          tile[nextTile].player = player[p].id;
          tile[nextTile].occupied = true;
          tile[nextTile].playerColor = player[p].playerColor;
          
          int x = tile[nextTile].posX + tile[nextTile].posXOffset + tile[nextTile].tileImage.width / 2;
          int y = tile[nextTile].posY  + tile[nextTile].posYOffset + tile[nextTile].tileImage.height / 2;
          
          int diceValue = floor(random(5)) * 2 + 4;
        
          createDie(x, y, diceValue, player[p].id, tile[nextTile].id);
          
          tilesToFill--;
          player[p].tiles++;
          break;
        }
      }
    }
  }
}

void drawPlayers() {
  
  //Lolca variables to set the width of the player information boxes
  int infoWidth = (int)width / (player.length + 1);
  
  //Get information about the players
  //Draw the player's information
  for (int i=0; i<player.length; i++) {
    player[i].display(infoWidth, i);
  }
  
  //Create the "End Turn" button at the end of all the information boxes
  interfaceNextTurn(infoWidth, player.length);
}

void updateTileAmount() {
  for (int p=0; p<player.length; p++) {
    player[p].tiles = 0;
    for (int t=0; t< tile.length; t++) {
      if (tile[t].player == player[p].id) {
        player[p].tiles++;
      }
    }
  }
}

void playerLost() {
  
  int playersLeft = player.length;
  
  for (int p=0; p<player.length; p++) {
    if (player[p].tiles == 0) {
      playersLeft--;
    }
  }
  for (int p=0; p<player.length; p++) {
    if (player[p].tiles == 0 && player[p].rank != 0) {
      player[p].rank = playersLeft;
    }
  }
}