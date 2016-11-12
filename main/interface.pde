
void drawInterface() {
  
  fill(255);
  rect(0, height - 200, width, 200);

}

void interfaceNextTurn(int infoWidth, int spot) {
  textSize(20);
  fill(0);
  textAlign(CENTER);
  text("End Turn", spot * infoWidth + infoWidth / 2, height - 75);
}