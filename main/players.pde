
players[] player = {};

class players {
  //The id of the player
  //The starting location for the player on the map
  //Whether it's the player's turn or not
  int id;
  int startID;
  boolean playerTurn;
  
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
    startID = (int)random(tile.length - 1);
    
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
    textSize(20);
    textAlign(CENTER, CENTER);
    
    //Print how many territories the player owns
    text(tiles, player * infoWidth + infoWidth / 2, height - 100);
  }
}

void createPlayers(int playerAmount) {
  
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
  placePlayers();
  randomPlayerTurn();
}

void placePlayers() {
  
  //Get information about the players
  //Get information about the tiles
  for (int p=0; p<player.length; p++) {
    for (int t=0; t<tile.length; t++) {
      
      //Test if the player starting place is equal to the player ID 
      if (player[p].startID == tile[t].id) {
        
        //Set the tile to be occupied by the player
        //Set that the tile is occupied
        //Set the color of the tile to the player color
        tile[t].player = player[p].id;
        tile[t].occupied = true;
        tile[t].playerColor = player[p].playerColor;
        
        //Local X and Y variables for the center of the tile
        int x = tile[t].posX + tile[t].posXOffset + tile[t].tileImage.width / 2;
        int y = tile[t].posY  + tile[t].posYOffset + tile[t].tileImage.height / 2;
        
        //Create a dice at that location and with the player's color
        //Increase the amount of tiles that the player owns
        createDie(x, y, 4, player[p].id, tile[t].id);
        player[p].tiles++;
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