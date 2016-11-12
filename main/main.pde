
void setup() {
  //Set the size of the screen
  fullScreen();
  
  //Set the color mode
  colorMode(HSB, 255);
  
  //Load all of the dice images
  loadDiceImages();
  
  //Create the map that will be played on
  //Create the players that will be playing
  createMap();
  createPlayers(10);
}

void draw() {
  //Draw the background to reset the image shown
  background(0, 0, 100);
  
  //Draw the map
  //Draw the dice on the map
  drawMap();
  drawDice();
  
  //Draw the interface
  //Draw the player information on the interface
  drawInterface();
  drawPlayers();
}

void mousePressed() {
  
  //Execute functions when the mouse is pressed
  selectTile();
  endTurn();
  
  if (mouseButton == RIGHT) {
    nextTurn();
  }
}