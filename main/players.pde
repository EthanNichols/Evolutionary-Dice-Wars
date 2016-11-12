
players[] player = {};

class players {
  //The id of the player
  //The starting location for the player on the map
  int id;
  int startID;
  
  //The color of the player
  color playerColor;
  
  
  players(color colorOfPlayer) {
    //Set the player id
    //Set the starting position to a random place on the map
    id = player.length + 1;
    startID = (int)random(tile.length - 1);
    
    //Set the color of the player
    playerColor = colorOfPlayer;
  }
}

void createPlayers(int playerAmount) {
  
  //Test if there will be more players playing than before
  if (playerAmount > player.length) {
    
    //Set how many players need to be created
    int newPlayerAmount = playerAmount - player.length;
    
    //Create the necesary amount of players
    for (int i=0; i< newPlayerAmount; i++) {
      
      color playerColor = color(20 * i, 255, 255);
      
      player = (players[])append(player, new players(playerColor));
    }
  }
  
  placePlayers();
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
        createDie(x, y, 6, p);
      }
    }
  }
}