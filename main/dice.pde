
//Set all of the dice image names
PImage d4;
PImage d6;
PImage d8;
PImage d10;
PImage d12;
PImage d20;

//Create an array for the dice on the map
dice[] die = {};

class dice {
  //The player that the dice belongs to
  //The tile that the dice belongs to
  //Whether the dice has moved this turn or not
  int playerID;
  int tileID;
  boolean moved;

  //X and Y Position of the die
  //The X and Y grid location of the dice relative to the map
  int posX;
  int posY;
  int gridX;
  int gridY;

  //How many sides does the die have
  //What image should be drawn
  int sides;
  PImage dieImage;

  dice(int x, int y, int sidesOfDie, int player, int tile) {

    //Set which player the die belongs to
    //Set which tile the die belongs to
    //Set that the die hasn't moved
    playerID = player;
    tileID = tile;
    moved = false;

    //Set the X and Y position of the dice on the map
    posX = x;
    posY = y;

    //Set how many sides the die has
    sides = sidesOfDie;
  }

  void setDieImage() {

    //Test how many sides the dice has
    //Set the image of the die relative to the amount of sides the die has
    switch(sides) {
      case(4):  
      dieImage = d4;  
      break;
      case(6):  
      dieImage = d6;  
      break;
      case(8):  
      dieImage = d8;  
      break;
      case(10):  
      dieImage = d10;  
      break;
      case(12):  
      dieImage = d12;  
      break;
      case(20):  
      dieImage = d20;  
      break;
    }
  }

  void display() {

    //Set the image of the respective die
    setDieImage();

    //Get information about the players
    for (int i=0; i<player.length; i++) {

      //Test if the player own the die
      //Tint the image relative to the player who owns the die
      if (playerID == player[i].id) {
        tint(player[i].playerColor);
      }
    }

    //Draw the die on the map
    image(dieImage, posX - dieImage.width / 2, posY - dieImage.height / 2);
  }
}

void loadDiceImages() {
  //Load all of the die images
  d4 = loadImage("images/d4.png");
  d6 = loadImage("images/d6.png");
  d8 = loadImage("images/d8.png");
  d10 = loadImage("images/d10.png");
  d12 = loadImage("images/d12.png");
  d20 = loadImage("images/d20.png");
}

void createDie(int x, int y, int sides, int player, int tile) {

  //Create a die relative to the parameters
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

    //Test for a die in the starting position
    //Test if the dice has moved
    if (die[i].tileID == startPos && !die[i].moved) {

      //Local X and Y positions for the new dice location
      int x = 0;
      int y = 0;

      //Set that the dice is attacking
      boolean attack = true;

      //Get information about the tiles
      for (int t=0; t<tile.length; t++) {

        //Test for the tile that the dice started in
        //Set that there is no occupying die in the tile
        if (tile[t].id == startPos) {
          tile[t].occupied = false;
        }

        //Test for the tile that the die is moving to
        //Test if there is a die in that location
        if (tile[t].id == endPos && tile[t].occupied) {

          //Set that there is an attack
          //Call the die attacking function
          //Break and don't continue in this function
          attack = true;
          diceAttack(startPos, endPos);
          break;
        }

        //Test for the tile that the die is moving to
        //Test if there isn't a die in that location
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

          //Set that there is no attacking taking place
          attack = false;
        }

        //Test if there was an attack
        if (!attack) {

          //Move the die to its new location
          //Set the new X and Y location for the die
          //Set that the die has been moved
          die[i].tileID = endPos;
          die[i].posX = x;
          die[i].posY = y;
          die[i].moved = true;

          //Update the interface information about how many tiles the players own
          updateTileAmount();
        }
      }
    }
  }
}

void diceAttack(int startPos, int endPos) {

  //Are the dice that are attacking belong to the same player
  boolean sameTeam = false;

  //The player who owns the first die
  //The player who owns the second die
  int playerTile1 = 0;
  int playerTile2 = 0;

  //Get information about the tiles
  for (int t=0; t<tile.length; t++) {

    //Test if the tile id is equal to the attacking die's location
    //Set the player that the die belongs to
    if (tile[t].id == startPos) {
      playerTile1 = tile[t].player;
    }

    //Test if the tile id is equal to the defending die's location
    //Set the player that the die belongs to
    if (tile[t].id == endPos) {
      playerTile2 = tile[t].player;
    }
  }

  //How many sides the first die has
  //How many sides the second die has
  int die1 = 0;
  int die2 = 0;

  //Make sure that the dice don't belong to the same plyer
  if (playerTile1 != playerTile2) {

    //Get information about the dice
    for (int d=0; d<die.length; d++) {

      //Test for the dice that is attacking
      //Set how many sides the die has
      if (die[d].tileID == startPos) {
        die1 = die[d].sides;
      }

      //Test for the dice that is defending
      //Set how many sides the die has
      if (die[d].tileID == endPos) {
        die2 = die[d].sides;
      }
    }

    //Test if the dice belong to the same player
    //Set that the dice are on the same team
  } else if (playerTile1 == playerTile2) {
    sameTeam = true;
  }

  //Set a random roll value between 1 and the amount of sides the dice has
  int dieRoll1 = floor(random(die1) + 1);
  int dieRoll2 = floor(random(die2) + 1);

  //Does the attacker win
  boolean attackerWin = false;

  //Test if the attacking die rolled higher than the defending die
  //Set that the attacker wins
  if (dieRoll1 > dieRoll2) {
    attackerWin = true;
  }

  //Make sure that the dice aren't on the same team
  if (!sameTeam) {

    //Get information about the dice
    for (int d=0; d<die.length; d++) {

      //Test if the attacker won
      if (attackerWin) {

        //Test for the dice that was defending
        //Move the die visibaly off the map
        //Make it seem that the die doesn't exist anymore
        if (die[d].tileID == endPos) {
          die[d].tileID = -100;
          die[d].posX = -100;
          die[d].posY = -100;
          die[d].moved = true;

          //Get information  about the tiles
          for (int t=0; t<tile.length; t++) {

            //Test for the attacking and defending locations of the dice
            //Set those tiles to not be occupied
            if (tile[t].id == endPos || tile[t].id == startPos) {
              tile[t].occupied = false;
            }
          }

          //Send information to the attacking function
          setAttackVariables(playerTile1, playerTile2, die1, die2, dieRoll1, dieRoll2, startPos, endPos);
          break;
        }
      } else {

        //Test for the dice that was attacking
        //Move the die visibaly off the map
        //Make it seem that the die doesn't exist anymore
        if (die[d].tileID == startPos) {
          die[d].tileID = -100;
          die[d].posX = -100;
          die[d].posY = -100;
          die[d].moved = true;

          //Get information about the tiles
          for (int t=0; t<tile.length; t++) {

            //Test for the tile with the attacking dice
            if (tile[t].id == startPos) {

              //Set that tile to not be occupied
              tile[t].occupied = false;

              //Send information to the attacking function
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

    //Test for the player that is taking their tun
    if (player[p].playerTurn) {

      //Get information about the tiles
      for (int t=0; t<tile.length; t++) {

        //Test for the tiles that belong to the player
        //Test for the tiles that are occupied with a die
        if (tile[t].player == player[p].id) {
          if (tile[t].occupied) {

            //Get information about the dice
            for (int d=0; d<die.length; d++) {

              //Test for the die that is in that tile location
              //Increase the amount of sides that dice has
              if (die[d].tileID == tile[t].id) {
                die[d].sides += 2;
              }

              //Test if the die has more than 12 sides
              //Set the amount of sides the die has to the max of 20
              if (die[d].sides > 12) {
                die[d].sides = 20;
              }
            }

            //Test if the tile isn't occupied by a die, but owned by the player
          } else {

            //Local variables to create a dice in the location of the unoccupied tile
            int x = tile[t].posX + tile[t].posXOffset + tile[t].tileImage.width / 2;
            int y = tile[t].posY  + tile[t].posYOffset + tile[t].tileImage.height / 2;

            //Set that the tile is occupied
            tile[t].occupied = true;

            //Create the smallest die in the tile
            createDie(x, y, 4, player[p].id, tile[t].id);
          }
        }
      }
    }
  }
}