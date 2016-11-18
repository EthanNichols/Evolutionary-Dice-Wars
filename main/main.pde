
void setup() {
  //Set the size of the screen
  size(1280, 800);

  //Set the color mode
  colorMode(HSB, 255);

  //Load all of the dice images
  //Load the dice animation images
  //Load the tutorial image
  loadDiceImages();
  loadAnimationImages();
  loadTutorial();

  //Create the buttons for the main menu
  //Create the buttons for the options menu
  createButtons();
  createOptButtons();
}

void draw() {
  //Draw the background to reset the image shown
  background(0, 0, 100);

  //Draw the gamestate which determines what is being drawn
  gamestateDraw();
}

void mousePressed() {
  //Call function when the mouse is pressed
  gamestateMouse();
}