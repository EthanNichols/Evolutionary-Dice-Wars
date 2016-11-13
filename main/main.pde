
void setup() {
  //Set the size of the screen
  fullScreen();
  
  //Set the color mode
  colorMode(HSB, 255);
  
  //Load all of the dice images
  loadDiceImages();
  
  gamestateLoad();
  
  //Create the map that will be played on
  //Create the players that will be playing
  createMap();
  createPlayers(2);
}

void draw() {
  //Draw the background to reset the image shown
  background(0, 0, 100);
  
  
  gamestateDraw();
}

void mousePressed() {
  gamestateMouse();
}