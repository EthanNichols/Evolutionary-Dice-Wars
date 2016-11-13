
int mapWidth = 5;
int mapHeight = mapWidth;

map[] tile = {};

class map {
  //The id of the tile and the player it belongs to
  int id;
  int player;
  
  //The actual X and Y position
  //The grid X and Y position
  //The offset X and Y for the hexagon map
  int posX;
  int posY;
  int gridX;
  int gridY;
  int posXOffset;
  int posYOffset;
  
  //What type of tile is being drawn
  //The tile image that will be drawn
  //Whether the tile is occupied by a dice or not
  //Whether the tile is selected or not
  //The color of the tile, if it is occupied
  String tileType;
  PImage tileImage;
  boolean occupied;
  boolean selected;
  color playerColor;
  
  //Load the tile images
  PImage blank = loadImage("images/blankHexagon.png");
  
  map(int x, int y, int tileNum) {
    
    //Set the id of the tile
    //Set the tile image that will be drawn
    id = tileNum;
    tileImage = blank;
    
    //Set the actual X and Y position of the tile
    //Set the grid X and Y position of the tile
    //Set the offset X and Y for the hexagon map
    posX = x * (tileImage.width - 1);
    posY = y * (tileImage.height - 1);
    gridX = x;
    gridY = y;
    posXOffset = (y % 2) * floor(tileImage.width / 2);
    posYOffset = -y * 33;
  
    //Set that the tile isn't occupied by a die
    //Set the color of the tile to have its' original color
    occupied = false;
    playerColor = 255;
  }
  
  void display() {
    //Test if a player owns the tile
    //Set the color of the tile to the player
    if (playerColor != 255) {
      tint(playerColor, 150);
    } else {
      tint(255, 255);
    }
    
    if (selected) {
      tint(playerColor, 25);
    }
    
    int x = posX + posXOffset;
    int y = posY + posYOffset;
    
    //Draw the tile
    image(tileImage, x, y);
  }
}

void createMap(int size) {
  
  mapWidth = size;
  mapHeight = size;
  
  //Local variable to know how many dice have been created
  int tileNum = 0;
  
  //For loops to set the grid X, Y position
  for (int x=0; x < mapWidth; x++) {
    for (int y=0; y < mapHeight; y++) {
      
      //Increase the amount of tiles that have been made
      tileNum++;
      
      //Add the tile into the map array, and set the tile information
      tile = (map[])append(tile, new map(x, y, tileNum)); 
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