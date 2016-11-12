
void drawInterface() {
  //Set the color of the interface
  //Define the area of the interface
  fill(255);
  rect(0, height - 200, width, 200);

}

void interfaceNextTurn(int infoWidth, int spot) {
  
  //Set the text size
  //Set the fill color
  //Center the text
  textSize(20);
  fill(0);
  textAlign(CENTER, CENTER);
  
  //Create an end turn button for the players
  text("End Turn", spot * infoWidth + infoWidth / 2, height - 100);
}