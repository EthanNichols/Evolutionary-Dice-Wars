
dice[] die = {};

class dice {
  //The color the dice should be for the player
  int player;
  
  //Position of the die
  int posX;
  int posY;
  
  //What type of die is it
  int sides;
  PImage dieImage;
  
  //Load all of the dice images
  PImage d6 = loadImage("images/d6.png");
  
  dice(int x, int y) {
    
    dieImage = d6;
    
    player = 1;
    posX = x - dieImage.width / 2;
    posY = y - dieImage.height / 2;
    
    sides = 6;
  }
  
  void display() {
    image(dieImage, posX, posY);
  }
}

void placeDie() {
  for (int i=0; i<tile.length; i++) {
    if (!tile[i].occupied) {
      die = (dice[])append(die, new dice(tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2, tile[i].posY  + tile[i].posYOffset + tile[i].tileImage.height / 2)); 
      tile[i].occupied = true;
      break;
    }
  }
}

void drawDice() {
  for (int i=0; i<die.length; i++) {
    die[i].display();
  }
}