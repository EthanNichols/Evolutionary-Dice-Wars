
void setup() {
  //Set the size of the screen
  fullScreen();
  
  //Set the color mode
  colorMode(HSB, 255);
  
  //Create the map that will be played on
  //Create the players that will be playing
  createMap();
  createPlayers(4);
}

void draw() {
  //Draw the background to reset the image shown
  background(0, 0, 100);
  
  //!!!REMOVE LATER!!!//
  //Move the map closer to the center of the screen
  translate(width / 10, height / 10);
  //!!!REMOVE LATER!!!//
  
  //Draw the map
  //Draw the dice on the map
  drawMap();
  drawDice();
}