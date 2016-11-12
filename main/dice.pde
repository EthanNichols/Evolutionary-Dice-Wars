
//Set all of the dice image names
PImage d4;
PImage d6;
PImage d8;
PImage d10;
PImage d12;
PImage d20;
  
dice[] die = {};

class dice {
  //The color the dice should be for the player
  int playerID;
  
  //Position of the die
  //The grid location of the dice compared to the map
  int posX;
  int posY;
  int gridX;
  int gridY;
  
  //How many sides does the die have
  //What image should be drawn
  int sides;
  PImage dieImage;
  
  dice(int x, int y, int sidesOfDie, int player) {
    
    //Test how many sides are on the dice
    //Set the dice image in respect to the amount of side
    switch(sidesOfDie) {
      case(4):  dieImage = d4;  break;
      case(6):  dieImage = d6;  break;
      case(8):  dieImage = d8;  break;
      case(10):  dieImage = d10;  break;
      case(12):  dieImage = d12;  break;
      case(20):  dieImage = d20;  break;
    }
    
    //Set which player the dice belongs to
    playerID = player;
    posX = x - dieImage.width / 2;
    posY = y - dieImage.height / 2;
    
    //Set how many sides the dice has
    sides = sidesOfDie;
  }
  
  void display() {
    
    //Tint the image in respect to the player who owns it
    //Draw the die on the map
    for (int i=0; i<player.length; i++) {
      if (playerID == player[i].id) {
        tint(player[i].playerColor);
      }
    }
    image(dieImage, posX, posY);
  }
}

void loadDiceImages() {
  //Load all of the dice images
  d4 = loadImage("images/d4.png");
  d6 = loadImage("images/d6.png");
  d8 = loadImage("images/d8.png");
  d10 = loadImage("images/d10.png");
  d12 = loadImage("images/d12.png");
  d20 = loadImage("images/d20.png");
}

void createDie(int x, int y, int sides, int player) {
  
  //Create a die with respect to the parameters
  die = (dice[])append(die, new dice(x, y, sides, player)); 
}

void drawDice() {
  
  //Get information about the die
  //Draw the die
  for (int i=0; i<die.length; i++) {
    die[i].display();
  }
}