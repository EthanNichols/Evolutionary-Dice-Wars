
void setup() {
  fullScreen();
  
  createMap();
}

void draw() {
  background(150);
  
  drawMap();
  drawDice();
}

void mousePressed() {
  placeDie();
}