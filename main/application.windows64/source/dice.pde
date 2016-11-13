
//Set all of the dice image names
PImage d4;
PImage d6;
PImage d8;
PImage d10;
PImage d12;
PImage d20;
  
dice[] die = {};

class dice {
  //The player that the dice belongs to
  //The tile that the dice belongs to
  //Whether the dice has moved this turn or not
  int playerID;
  int tileID;
  boolean moved;
  
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
  
  dice(int x, int y, int sidesOfDie, int player, int tile) {
    
    //Set which player the dice belongs to
    //Set which tile the dice belongs to
    //Set that the dice hasn't moved
    playerID = player;
    tileID = tile;
    moved = false;
    
    //Set the position of the dice on the map
    posX = x;
    posY = y;
    
    //Set how many sides the dice has
    sides = sidesOfDie;
  }
  
  void setDieImage() {
    switch(sides) {
      case(4):  dieImage = d4;  break;
      case(6):  dieImage = d6;  break;
      case(8):  dieImage = d8;  break;
      case(10):  dieImage = d10;  break;
      case(12):  dieImage = d12;  break;
      case(20):  dieImage = d20;  break;
    }
  }
  
  void display() {
    
    //Set the image of the respective die
    setDieImage();
    
    //Tint the image in respect to the player who owns it
    //Draw the die on the map
    for (int i=0; i<player.length; i++) {
      if (playerID == player[i].id) {
        tint(player[i].playerColor);
      }
    }
    image(dieImage, posX - dieImage.width / 2, posY - dieImage.height / 2);
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

void createDie(int x, int y, int sides, int player, int tile) {
  
  //Create a die with respect to the parameters
  die = (dice[])append(die, new dice(x, y, sides, player, tile)); 
}

void drawDice() {
  
  //Get information about the die
  //Draw the die
  for (int i=0; i<die.length; i++) {
    die[i].display();
  }
}

void moveDice(int startPos, int endPos) {
  
  //Get inforamtion about the dice
  for (int i=0; i<die.length; i++) {
    
    //Test for a dice in the starting position
    //Test if the dice has moved
    if (die[i].tileID == startPos && !die[i].moved) {
      
      //Local X and Y positions for the new dice location
      int x = 0;
      int y = 0;
      
      boolean attack = true;
      
      //Get information about the tiles
      for (int t=0; t<tile.length; t++) {
        
        //Test for the tile that the dice started in
        //Set that there is no occupying dice in the tile
        
        if (tile[t].id == startPos) {
          tile[t].occupied = false;   
        }
        
        //Test for the tile that the dice is moving to
        if (tile[t].id == endPos && tile[t].occupied) {
          
          attack = true;
          diceAttack(startPos, endPos);
          break;
        }
        
        if (tile[t].id == endPos && !tile[t].occupied) {
          
          //Set the new X and Y locations for the dice
          x = tile[t].posX + tile[t].posXOffset + tile[t].tileImage.width / 2;
          y = tile[t].posY  + tile[t].posYOffset + tile[t].tileImage.height / 2;
          
          //Set the player that the tile belongs to
          //Set that the tile is occupied
          //Set the player color of the tile
          tile[t].player = die[i].playerID;
          tile[t].occupied = true;
          tile[t].playerColor = player[die[i].playerID - 1].playerColor;
          
          attack = false;
        }
        
        if (!attack) {
          
          //Move the die to its new location
          //Set the new X and Y location for the die
          //Set that the die has been moved
          die[i].tileID = endPos;
          die[i].posX = x;
          die[i].posY = y;
          die[i].moved = true;
          
          updateTileAmount();
        }
      }
    }
  }
}

void diceAttack(int startPos, int endPos) {
  
  
  boolean sameTeam = false;
  
  int playerTile1 = 0;
  int playerTile2 = 0;
  
  for (int t=0; t<tile.length; t++) {
    if (tile[t].id == startPos) {
      playerTile1 = tile[t].player;
    }
    if (tile[t].id == endPos) {
      playerTile2 = tile[t].player;
    }
  }
  
  int die1 = 0;
  int die2 = 0;
  
  if (playerTile1 != playerTile2) {
    for (int d=0; d<die.length; d++) {
      
      if (die[d].tileID == startPos) {
        die1 = die[d].sides;
      }
      if (die[d].tileID == endPos) {
        die2 = die[d].sides;
      }
    }
  } else if (playerTile1 == playerTile2) {
    sameTeam = true;
  }
  
  int dieRoll1 = floor(random(die1) + 1);
  int dieRoll2 = floor(random(die2) + 1);
  boolean attackerWin = false;
  
  if (dieRoll1 > dieRoll2) {
    attackerWin = true;
  }
  
  if (!sameTeam) {
    for (int d=0; d<die.length; d++) {
      if (attackerWin) {
        if (die[d].tileID == endPos) {
          die[d].tileID = -100;
          die[d].posX = -100;
          die[d].posY = -100;
          die[d].moved = true;
        
          for (int t=0; t<tile.length; t++) {
            if (tile[t].id == endPos || tile[t].id == startPos) {
              tile[t].occupied = false;
            }
          }
         
          setAttackVariables(playerTile1, playerTile2, die1, die2, dieRoll1, dieRoll2, startPos, endPos);
          break;
        }
      } else {
        if (die[d].tileID == startPos) {
          die[d].tileID = -100;
          die[d].posX = -100;
          die[d].posY = -100;
          die[d].moved = true;
        
          for (int t=0; t<tile.length; t++) {
            if (tile[t].id == startPos) {
              tile[t].occupied = false;
              
              setAttackVariables(playerTile1, playerTile2, die1, die2, dieRoll1, dieRoll2, startPos, endPos);
              break;
            }
          }
        }
      }
    }
  }
}

void resetDiceMovement() {
  
  //Get information about the player
  for (int p=0; p<player.length; p++) {
    
    //Test for the player who's taking their turn
    //Get information about the die
    if (player[p].playerTurn) {
      for (int d=0; d<die.length; d++) {
        
        //Test if the player id matches the die id
        //Set that the dice hasn't moved
        if (player[p].id == die[d].playerID) {
          die[d].moved = false;
        }
      }
    }
  }
}

void fillUnoccupiedTiles() {
  
  //Get inforamtion about the players
  for (int p=0; p<player.length; p++) {
    
    if (player[p].playerTurn) {
      for (int t=0; t<tile.length; t++) {
        if (tile[t].player == player[p].id) {
                  
          if (tile[t].occupied) {
            
            for (int d=0; d<die.length; d++) {
              if (die[d].tileID == tile[t].id) {
                die[d].sides += 2;
              }
            
              if (die[d].sides > 12) {
                die[d].sides = 20;
              }
            }
          } else {
            
            int x = tile[t].posX + tile[t].posXOffset + tile[t].tileImage.width / 2;
            int y = tile[t].posY  + tile[t].posYOffset + tile[t].tileImage.height / 2;
            
            tile[t].occupied = true;
            
            createDie(x, y, 4, player[p].id, tile[t].id);
          }
        }
      }
    }
  }
}