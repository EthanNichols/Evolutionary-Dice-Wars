
map[] tile = {};

class map {
  
  //The id for the tile
  int id;
  
  //The player that the tile belongs to
  int player;
  
  //Position of the tile on the map's grid
  int posX;
  int posY;
  
  //Position offsets for the different layers of the map's grid
  int posXOffset;
  int posYOffset;
  
  //The type of ground that the tile represents
  String tileType;
  PImage tileImage = loadImage("images/blankHexagon.png");
  
  //Variable to see if there is a dice on the tile
  boolean occupied;
  
  
  map(int x, int y) {
    
    //Set the id of the tile
    id = x + y;
    
    //Set the position of the die relative to the grid location
    posX = x * (tileImage.width - 1);
    posY = y * (tileImage.height - 1);
    
    //Set the offset of the hexagons to fit snuggly
    posXOffset = (y % 2) * floor(tileImage.width / 2);
    posYOffset = -y * 33;
    
    //Set that the tile isn't occupied
    occupied = false;
  }
  
  void display() {
    //Draw the tile on the map
    image(tileImage, posX + posXOffset, posY + posYOffset);
  }
}

void createMap() {
  
  //For loops to set the grid X, Y position
  for (int x=0; x < 20; x++) {
    for (int y=0; y < 20; y++) {
      //Add the tile into the map array, and set the tile information
      tile = (map[])append(tile, new map(x, y)); 
    }
  }
}

void drawMap() {
  
  //Get information about the tiles
  //Draw the tiles
  for (int i=0; i<tile.length; i++) {
    tile[i].display();
  }
}