
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
    
    if (playerTurn) {
      fill(75, 255, 150);
      rect(player * infoWidth + 25, height - 200, infoWidth - 50, 200);
    }
    
    fill(playerColor);
    rect(player * infoWidth + 5, height - 175, infoWidth - 5, 150);
    
    fill(0);
    textSize(20);
    textAlign(CENTER, TOP);
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
      
      color playerColor = color((255 / newPlayerAmount) * i, 255, 255);
      
      player = (players[])append(player, new players(playerColor));
    }
  }
  
  placePlayers();
  randomPlayerTurn();
}

void placePlayers() {
  for (int p=0; p<player.length; p++) {
    for (int t=0; t<tile.length; t++) {
      if (player[p].startID == tile[t].id) {
        tile[t].player = p;
        tile[t].occupied = true;
        tile[t].playerColor = player[p].playerColor;
        int x = tile[t].posX + tile[t].posXOffset + tile[t].tileImage.width / 2;
        int y = tile[t].posY  + tile[t].posYOffset + tile[t].tileImage.height / 2;
        createDie(x, y, 4, p);
        player[p].tiles++;
      }
    }
  }
}

void drawPlayers() {
  
  int infoWidth = (int)width / (player.length + 1);
  //Get information about the players
  //Draw the player's information
  for (int i=0; i<player.length; i++) {
    player[i].display(infoWidth, i);
  }
  interfaceNextTurn(infoWidth, player.length);
}