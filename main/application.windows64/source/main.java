import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {


public void setup() {
  //Set the size of the screen
  
  
  //Set the color mode
  colorMode(HSB, 255);
  
  //Load all of the dice images
  loadDiceImages();
  loadAnimationImages();
  loadTutorial();
  
  createButtons();
  createOptButtons();
}

public void draw() {
  //Draw the background to reset the image shown
  background(0, 0, 100);
  
  gamestateDraw();
}

public void mousePressed() {
  gamestateMouse();
}

int animationTimer = 0;
int playerDice1;
int playerDice2;
int sidesOnDie1;
int sidesOnDie2;
int dieRolled1;
int dieRolled2;
int starting;
int finishing;

boolean animatedAttack;

int mainMenuDelay = 10;
int die1 = 0;
int die2 = 0;

PImage hugeD4;
PImage hugeD6;
PImage hugeD8;
PImage hugeD10;
PImage hugeD12;
PImage hugeD20;

public void loadAnimationImages() {
  hugeD4 = loadImage("images/hugeD4.png");
  hugeD6 = loadImage("images/hugeD6.png");
  hugeD8 = loadImage("images/hugeD8.png");
  hugeD10 = loadImage("images/hugeD10.png");
  hugeD12 = loadImage("images/hugeD12.png");
  hugeD20 = loadImage("images/hugeD20.png");
}

public void drawMenuAnimation() {
  
  if (mainMenuDelay <= 0) {
    die1 = floor(random(6));
    die2 = floor(random(6));
    mainMenuDelay = 10;
  }
  
  PImage dieImg1 = hugeD4;
  PImage dieImg2 = hugeD4;
  
  switch(die1) {
    case 0: dieImg1 = hugeD4; break;
    case 1: dieImg1 = hugeD6; break;
    case 2: dieImg1 = hugeD8; break;
    case 3: dieImg1 = hugeD10; break;
    case 4: dieImg1 = hugeD12; break;
    case 5: dieImg1 = hugeD20; break;
  }
  
  switch(die2) {
    case 0: dieImg2 = hugeD4; break;
    case 1: dieImg2 = hugeD6; break;
    case 2: dieImg2 = hugeD8; break;
    case 3: dieImg2 = hugeD10; break;
    case 4: dieImg2 = hugeD12; break;
    case 5: dieImg2 = hugeD20; break;
  }
  
  mainMenuDelay--;
  
  image(dieImg1, width / 4 - hugeD6.width / 2, height / 2 - hugeD6.height / 2);
  image(dieImg2, (width / 4) * 3 - hugeD6.width / 2, height / 2 - hugeD6.height / 2);
}

public void drawAttack() {
  
  if (animationTimer >= 0 && animatedAttack) {
    attackAnimation(playerDice1, playerDice2, sidesOnDie1, sidesOnDie2, dieRolled1, dieRolled2, starting, finishing);
  
    animationTimer--;
  } else if (animationTimer < 0 && animatedAttack) {
    delay(1000);
    animatedAttack = false;
    
    if (dieRolled1 > dieRolled2) {
      moveDice(starting, finishing);
    }
  }
}

public void setAttackVariables(int player1, int player2, int die1, int die2, int dieRoll1, int dieRoll2, int start, int finish) {
  playerDice1 = player1;
  playerDice2 = player2;
  sidesOnDie1 = die1;
  sidesOnDie2 = die2;
  dieRolled1 = dieRoll1;
  dieRolled2 = dieRoll2;
  starting = start;
  finishing = finish;
  
  animationTimer = 10;
  animatedAttack = true;
}

public void attackAnimation(int player1, int player2, int die1, int die2, int dieRoll1, int dieRoll2, int start, int finish) {
  
  int dieColor1 = color(255);
  int dieColor2 = color(255);
  
  for (int p=0; p<player.length; p++) {
    if (player[p].id == player1) {
      dieColor1 = player[p].playerColor;
    }
    
    if (player[p].id == player2) {
      dieColor2 = player[p].playerColor;
    }
  }
  
  PImage dieImg1 = hugeD4;
  PImage dieImg2 = hugeD4;
  
  switch(die1) {
    case 4: dieImg1 = hugeD4; break;
    case 6: dieImg1 = hugeD6; break;
    case 8: dieImg1 = hugeD8; break;
    case 10: dieImg1 = hugeD10; break;
    case 12: dieImg1 = hugeD12; break;
    case 20: dieImg1 = hugeD20; break;
  }
  
  switch(die2) {
    case 4: dieImg2 = hugeD4; break;
    case 6: dieImg2 = hugeD6; break;
    case 8: dieImg2 = hugeD8; break;
    case 10: dieImg2 = hugeD10; break;
    case 12: dieImg2 = hugeD12; break;
    case 20: dieImg2 = hugeD20; break;
  }
  
  if (animationTimer > 0) {
   
    tint(dieColor1);
    image(dieImg1, width / 3 - dieImg1.width / 2, height / 2 - dieImg1.height / 2);
  
    tint(dieColor2);
    image(dieImg2, (width / 3) * 2 - dieImg2.width / 2, height / 2 - dieImg2.height / 2);
  
    fill(0);
    textSize(100);
    textAlign(CENTER, CENTER);
    
    text(floor(random(die1) + 1), width / 3, height / 2);
    text(floor(random(die2) + 1), (width / 3) * 2, height / 2);
  }
  
  if (animationTimer <= 0) {
    
    tint(dieColor1);
    image(dieImg1, width / 3 - dieImg1.width / 2, height / 2 - dieImg1.height / 2);
    
    tint(dieColor2);
    image(dieImg2, (width / 3) * 2 - dieImg2.width / 2, height / 2 - dieImg2.height / 2);
    
    fill(0);
    textSize(100);
    textAlign(CENTER, CENTER);
    
    text(dieRoll1, width / 3, height / 2);
    text(dieRoll2, (width / 3) * 2, height / 2);
  }
}

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
  
  public void setDieImage() {
    switch(sides) {
      case(4):  dieImage = d4;  break;
      case(6):  dieImage = d6;  break;
      case(8):  dieImage = d8;  break;
      case(10):  dieImage = d10;  break;
      case(12):  dieImage = d12;  break;
      case(20):  dieImage = d20;  break;
    }
  }
  
  public void display() {
    
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

public void loadDiceImages() {
  //Load all of the dice images
  d4 = loadImage("images/d4.png");
  d6 = loadImage("images/d6.png");
  d8 = loadImage("images/d8.png");
  d10 = loadImage("images/d10.png");
  d12 = loadImage("images/d12.png");
  d20 = loadImage("images/d20.png");
}

public void createDie(int x, int y, int sides, int player, int tile) {
  
  //Create a die with respect to the parameters
  die = (dice[])append(die, new dice(x, y, sides, player, tile)); 
}

public void drawDice() {
  
  //Get information about the die
  //Draw the die
  for (int i=0; i<die.length; i++) {
    die[i].display();
  }
}

public void moveDice(int startPos, int endPos) {
  
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

public void diceAttack(int startPos, int endPos) {
  
  
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

public void resetDiceMovement() {
  
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

public void fillUnoccupiedTiles() {
  
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

int tilesToWin;
String gamestate = "mainMenu";

public void testWinner() {
  for (int p=0; p<player.length; p++) {
    if (player[p].tiles > tilesToWin) {
      gamestate = "endGame";
      player[p].rank = 1;
    }
  }
}

public void startGame() {
  //Create the map that will be played on
  //Create the players that will be playing
  createMap(optButton[1].value);
  createPlayers(optButton[0].value);
  
  tilesToWin = ceil(((mapWidth * mapHeight) / 4) * (optButton[2].value + 1));
}

public void gamestateDraw() {
  if (gamestate == "mainMenu") {
    mainMenuMouse();
    drawMainMenu();
    drawMenuAnimation();
  
  } else if (gamestate == "options") {
    drawOptions();
    optionsMouse();
    
  } else if (gamestate == "game") {
    //Draw the map
    //Draw the dice on the map
    drawMap();
    drawDice();
  
    //Draw the interface
    //Draw the player information on the interface
    drawInterface();
    drawPlayers();
    drawAttack();
    
  } else if (gamestate == "endGame") {
    drawWinScreen();
  } else if (gamestate == "tutorial") {
    drawTutorial();
    tutorialMouse();
    
  } else if (gamestate == "exit") {
    exit();
  }
}

public void gamestateMouse() {
  //Execute functions when the mouse is pressed
  
  if (gamestate == "game") {
    selectTile();
    endTurn();
    
    if (mouseButton == RIGHT) {
      nextTurn();
    }
  } else if (gamestate == "mainMenu") {
    mainMouseClick();
  } else if (gamestate == "options") {
    optionsClick();
  } else if (gamestate == "tutorial") {
    tutorialClick();
  }
}

int buttonWidth;

public void drawInterface() {
  //Set the color of the interface
  //Define the area of the interface
  fill(255);
  rect(-1, height - 200, width + 1, 200);

}

public void interfaceNextTurn(int infoWidth, int spot) {
  
  fill(255);
  rect(spot * infoWidth + 5, height - 175, infoWidth - 10, 150);
  
  //Set the text size
  //Set the fill color
  //Center the text
  textSize(25);
  fill(0);
  textAlign(CENTER, CENTER);
  
  //Create an end turn button for the players
  text("End Turn", spot * infoWidth + infoWidth / 2, height - 100);
  
  //Set how big the buttons are in the interface
  buttonWidth = infoWidth;
}

public void endTurn() {
  
  //Test the mouse position relative to the end turn button
  if (mouseX > width - buttonWidth &&
  mouseX < width &&
  mouseY > height - 200 &&
  mouseY < height) {
    
    //Go to the next player's turn
    nextTurn();
  }
}

public void nextTurn() {
  
  //Get information about the players
  for (int i=0; i<player.length; i++) {
    
    //Test for the player that is taking their turn
    if(player[i].playerTurn) {
      
      //Set that players turn to false
      player[i].playerTurn = false;
      
      //Make sure that the next player is in the array bounds
      if (i + 1 >= player.length) {
        i -= player.length;
      }
      
      int nextPlayer = i + 1;
      
      while (player[nextPlayer].tiles == 0) {
        nextPlayer++;
        
        if (nextPlayer >= player.length) {
          nextPlayer -= player.length;
        }
      }
      
      //Set the next player's turn to be true
      player[nextPlayer].playerTurn = true;
      break;
    }
  }
  
  //Reset all the dice for the player to not have moved
  //Fill unoccupied tiles with basic dice
  resetDiceMovement();
  fillUnoccupiedTiles();
  
  testWinner();
}

menuButtons[] button = {};

class menuButtons {
  String buttonText;
  int posX;
  int posY;
  int rectWidth;
  int rectHeight;
  String gamestate;
  boolean hover;
  
  menuButtons(String buttonName, int x, int y, int w, int h, String dest) {
    buttonText = buttonName;
    rectWidth = w;
    rectHeight = h;
    posX = x - rectWidth / 2;
    posY = y - rectHeight / 2;
    gamestate = dest;
    hover = false;
  }
  
  public void display() {
    if (hover) {
      fill(75, 255, 150);
    } else {
      fill(255);
    }
    
    rect(posX, posY, rectWidth, rectHeight);
    
    fill(0);
    textSize(25);
    textAlign(CENTER, CENTER);
    text(buttonText, posX + rectWidth / 2, posY + rectHeight / 2);
  }
}

public void createButtons() {
  button = (menuButtons[])append(button, new menuButtons("Play Game!", width / 2, height / 5, 250, 50, "game"));
  button = (menuButtons[])append(button, new menuButtons("Options", width / 2, (height / 5) * 2, 250, 50, "options"));
  button = (menuButtons[])append(button, new menuButtons("Tutorial", width / 2, (height / 5) * 3, 250, 50, "tutorial"));
  button = (menuButtons[])append(button, new menuButtons("Exit", width / 2, (height / 5) * 4, 250, 50, "exit"));
}

public void mainMenuMouse() {
  for (int b=0; b<button.length; b++) {
    if (mouseX > button[b].posX &&
    mouseX < button[b].posX + button[b].rectWidth &&
    mouseY > button[b].posY &&
    mouseY < button[b].posY + button[b].rectHeight) {
      button[b].hover = true;
    } else {
      button[b].hover = false;
    }
  }
}

public void mainMouseClick() {
  for (int b=0; b<button.length; b++) {
    if (mouseX > button[b].posX &&
    mouseX < button[b].posX + button[b].rectWidth &&
    mouseY > button[b].posY &&
    mouseY < button[b].posY + button[b].rectHeight) {
      gamestate = button[b].gamestate;
      
      if (gamestate == "game") {
        startGame();
      }
    }
  }
}

public void drawMainMenu() {
  
  fill(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Evolutionary Dice Wars", width / 2, height / 15);
  
  textSize(25);
  text("Created by: Ethan Nichols", width / 2, height / 15 * 14);
  
  for (int b=0; b<button.length; b++) {
    button[b].display();
  }
}

int mapWidth = 5;
int mapHeight = mapWidth;

map[] tile = {};

class map {
  //The id of the tile and the player it belongs to
  int id;
  int player;
  
  //The actual X and Y position
  //The grid X and Y position
  //The offset X and Y for the hexagon map
  int posX;
  int posY;
  int gridX;
  int gridY;
  int posXOffset;
  int posYOffset;
  
  //What type of tile is being drawn
  //The tile image that will be drawn
  //Whether the tile is occupied by a dice or not
  //Whether the tile is selected or not
  //The color of the tile, if it is occupied
  String tileType;
  PImage tileImage;
  boolean occupied;
  boolean selected;
  int playerColor;
  
  //Load the tile images
  PImage blank = loadImage("images/blankHexagon.png");
  
  map(int x, int y, int tileNum) {
    
    //Set the id of the tile
    //Set the tile image that will be drawn
    id = tileNum;
    tileImage = blank;
    
    //Set the actual X and Y position of the tile
    //Set the grid X and Y position of the tile
    //Set the offset X and Y for the hexagon map
    posX = x * (tileImage.width - 1);
    posY = y * (tileImage.height - 1);
    gridX = x;
    gridY = y;
    posXOffset = (y % 2) * floor(tileImage.width / 2);
    posYOffset = -y * 33;
  
    //Set that the tile isn't occupied by a die
    //Set the color of the tile to have its' original color
    occupied = false;
    playerColor = 255;
  }
  
  public void display() {
    //Test if a player owns the tile
    //Set the color of the tile to the player
    if (playerColor != 255) {
      tint(playerColor, 150);
    } else {
      tint(255, 255);
    }
    
    if (selected) {
      tint(playerColor, 25);
    }
    
    //Draw the tile
    image(tileImage, gridX * (tileImage.width - 1) + (gridY % 2) * 67, gridY * (tileImage.height - 1) - gridY * 33);
  }
}

public void createMap(int size) {
  
  mapWidth = size;
  mapHeight = size;
  
  //Local variable to know how many dice have been created
  int tileNum = 0;
  
  //For loops to set the grid X, Y position
  for (int x=0; x < mapWidth; x++) {
    for (int y=0; y < mapHeight; y++) {
      
      //Increase the amount of tiles that have been made
      tileNum++;
      
      //Add the tile into the map array, and set the tile information
      tile = (map[])append(tile, new map(x, y, tileNum)); 
    }
  }
}

public void drawMap() {
  
  //Get information about the tiles
  //Draw the tiles
  for (int i=0; i<tile.length; i++) {
    tile[i].display();
  }
}

optionButtons[] optButton = {};

class optionButtons {
  String buttonText;
  int posX;
  int posY;
  int rectWidth;
  int rectHeight;
  int value;
  String gamestate;
  boolean hoverNeg;
  boolean hoverPos;
  boolean hover;
  
  optionButtons(String buttonName, int x, int y, int w, int h, String dest) {
    buttonText = buttonName;
    rectWidth = w;
    rectHeight = h;
    posX = x - rectWidth / 2;
    posY = y - rectHeight / 2;
    gamestate = dest;
    hoverNeg = false;
    hoverPos = false;
    hover = false;
    
    if (buttonName == "Players") {
      value = 1;
    } else if (buttonName == "Map Size") {
      value = 3;
    }
  }
  
  public void display() {
    
    if (hover) {
      fill(75, 255, 150);
    } else {
      fill(255);
    }
    
    if (buttonText != "Main Menu") {
      fill(255);
    }
    
    rect(posX, posY, rectWidth, rectHeight);
    
    fill(0);
    textSize(25);
    textAlign(CENTER, CENTER);
    text(buttonText, posX + rectWidth / 2, posY + rectHeight / 2);
    
    if (buttonText != "Main Menu") {
      
      if (buttonText != "Win Condition" &&
      buttonText != "Game Mode") {
        
        fill(0);
        textSize(25);
        textAlign(CENTER, CENTER);
        text(value, posX + rectWidth / 2, posY + floor(rectHeight * 1.4f)); 
        
      } else if (buttonText == "Win Condition") {
        fill(0);
        textSize(25);
        textAlign(CENTER, CENTER);
        
        String percentage = "0%";
        
        if (value >= 3) {
          value = 3;
        }
        
        switch(value) {
          case 0: percentage = "25%"; break;
          case 1: percentage = "50%"; break;
          case 2: percentage = "75%"; break;
          case 3: percentage = "100%"; break;
        }
        text(percentage + " of the map", posX + rectWidth / 2, posY + floor(rectHeight * 1.4f)); 
      } else if (buttonText == "Game Mode") {
        
        String mode = "";
        
        if (value >= 1) {
          value = 1;
        }
        
        switch(value) {
          case 0: mode = "One Tile Mode"; break;
          case 1: mode = "Full Map Mode"; break;
        }
        
        text(mode, posX + rectWidth / 2, posY + floor(rectHeight * 1.4f)); 
      }
        
    
      if (hoverNeg) {
        fill(75, 255, 150);
      } else {
        fill(255);
      }
      triangle(posX - rectWidth / 8, posY + rectHeight / 8, posX - rectWidth / 8, posY + rectHeight - rectHeight / 8, posX - rectWidth / 3, posY + rectHeight / 2);
      
      if (hoverPos) {
        fill(75, 255, 150);
      } else {
        fill(255);
      }
      triangle(posX + rectWidth + rectWidth / 8, posY + rectHeight / 8, posX + rectWidth + rectWidth / 8, posY + rectHeight - rectHeight / 8, posX + rectWidth + rectWidth / 3, posY + rectHeight / 2);
    }
  }
}

public void createOptButtons() {
  optButton = (optionButtons[])append(optButton, new optionButtons("Players", width / 2, height / 6, 250, 50, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Map Size", width / 2, (height / 6) * 2, 250, 50, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Win Condition", width / 2, (height / 6) * 3, 250, 50, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Game Mode", width / 2, (height / 6) * 4, 250, 50, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Main Menu", width / 2, (height / 6) * 5, 250, 50, "mainMenu"));
}

public void optionsMouse() {
  for (int b=0; b<optButton.length; b++) {
    if (mouseX > optButton[b].posX &&
    mouseX < optButton[b].posX + optButton[b].rectWidth &&
    mouseY > optButton[b].posY &&
    mouseY < optButton[b].posY + optButton[b].rectHeight) {
      optButton[b].hover = true;
    } else {
      optButton[b].hover = false;
    }
    
    if (mouseX > optButton[b].posX - optButton[b].rectWidth / 3 &&
    mouseX < optButton[b].posX - optButton[b].rectWidth / 8 &&
    mouseY > (optButton[b].posY - optButton[b].rectHeight / 8) &&
    mouseY < optButton[b].posY + optButton[b].rectHeight - optButton[b].rectHeight / 8) {
      optButton[b].hoverNeg = true;
    } else {
      optButton[b].hoverNeg = false;
    }
    
    if (mouseX > optButton[b].posX + optButton[b].rectWidth + optButton[b].rectWidth / 8 &&
    mouseX < optButton[b].posX + optButton[b].rectWidth + optButton[b].rectWidth / 3 &&
    mouseY > (optButton[b].posY - optButton[b].rectHeight / 8) &&
    mouseY < optButton[b].posY + optButton[b].rectHeight - optButton[b].rectHeight / 8) {
      optButton[b].hoverPos = true;
    } else {
      optButton[b].hoverPos = false;
    }
  }
}

public void optionsClick() {
  for (int b=0; b<optButton.length; b++) {
    if (mouseX > optButton[b].posX &&
    mouseX < optButton[b].posX + optButton[b].rectWidth &&
    mouseY > optButton[b].posY &&
    mouseY < optButton[b].posY + optButton[b].rectHeight) {
      if (optButton[b].buttonText == "Main Menu") {
        gamestate = optButton[b].gamestate;
      }
    }
    
    if (mouseX > optButton[b].posX - optButton[b].rectWidth / 3 &&
    mouseX < optButton[b].posX - optButton[b].rectWidth / 8 &&
    mouseY > (optButton[b].posY - optButton[b].rectHeight / 8) &&
    mouseY < optButton[b].posY + optButton[b].rectHeight - optButton[b].rectHeight / 8) {
      optButton[b].value--;
      
      if (optButton[b].buttonText != "Map Size") {
        if (optButton[b].value <= 0) {
          optButton[b].value = 0;
        }
      } else {
        if (optButton[b].value <= 3) {
          optButton[b].value = 3;
        }
      }
    }
    
    if (mouseX > optButton[b].posX + optButton[b].rectWidth + optButton[b].rectWidth / 8 &&
    mouseX < optButton[b].posX + optButton[b].rectWidth + optButton[b].rectWidth / 3 &&
    mouseY > (optButton[b].posY - optButton[b].rectHeight / 8) &&
    mouseY < optButton[b].posY + optButton[b].rectHeight - optButton[b].rectHeight / 8) {
      optButton[b].value++;
      
      if (optButton[b].buttonText != "Map Size") {
        if (optButton[b].value >= 8) {
          optButton[b].value = 8;
        }
      } else {
        if (optButton[b].value >= 20) {
          optButton[b].value = 20;
        }
      }
    }
  }
}

public void drawOptions() {
  for (int b=0; b<optButton.length; b++) {
    optButton[b].display();
  }
}

public void randomPlayerTurn() {
  
  //Randomly set one of the players to start
  int playerTurn = (int)random(player.length - 1) + 1;
  
  //Get information about the players
  //Test if the random starting player is the same as an ID
  //Set that player's turn to be true
  for (int i=0; i<player.length; i++) {
    if (playerTurn == player[i].id) {
      player[i].playerTurn = true;
    }
  }
}

public void selectTile() {
  
  //Local variable to know which tile is selected
  int selectionID = 0;
  
  //Get information about the tiles
  for (int i=0; i<tile.length; i++) {
    
    //Test the center area of the hexagon
    if (mouseX >= tile[i].posX + tile[i].posXOffset && 
    mouseX <= tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width - 1 &&
    mouseY >= tile[i].posY + tile[i].posYOffset + 35 &&
    mouseY <= tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - 35) {
      selectionID = tile[i].id;
      
    //Test the upper Left hand corner of the hexagon
    } else if (mouseX > tile[i].posX + tile[i].posXOffset &&
    mouseX < tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2 &&
    mouseY > tile[i].posY + tile[i].posYOffset + 35 - floor((mouseX - (tile[i].posX + tile[i].posXOffset)) / 2)  &&
    mouseY < tile[i].posY + tile[i].posYOffset + 35) {
      selectionID = tile[i].id;
      
    //Test the upper right hand corner of the hexagon
    } else if (mouseX > tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2 &&
    mouseX < tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width &&
    mouseY > tile[i].posY + tile[i].posYOffset + floor((mouseX - ((tile[i].posX + tile[i].posXOffset) + tile[i].tileImage.width / 2)) / 2)  &&
    mouseY < tile[i].posY + tile[i].posYOffset + 35) {
      selectionID = tile[i].id;
      
    //Test the lower Left hand corner of the hexagon
    } else if (mouseX > tile[i].posX + tile[i].posXOffset &&
    mouseX < tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2 &&
    mouseY > tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - 35  &&
    mouseY < tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - 35 + floor((mouseX - (tile[i].posX + tile[i].posXOffset)) / 2)) {
      selectionID = tile[i].id;
      
    //Test the lower right hand corner of the hexagon
    } else if (mouseX > tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width / 2 &&
    mouseX < tile[i].posX + tile[i].posXOffset + tile[i].tileImage.width &&
    mouseY > tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - 35 &&
    mouseY < tile[i].posY + tile[i].posYOffset + tile[i].tileImage.height - floor((mouseX - ((tile[i].posX + tile[i].posXOffset) + tile[i].tileImage.width / 2)) / 2)) {
      selectionID = tile[i].id;
    }
  }
  
  //Local varible to see which function to call
  boolean secondTileSelect = false;
  int selectedTile = 0;
  
  //Get information about the tiles
  for (int i=0; i<tile.length; i++) {
    
    //Test for a tile that is select
    //Set the local variable to true to call the second function
    if (tile[i].selected) {
      secondTileSelect = true;
      selectedTile = tile[i].id;
      break;
    }
  }
  
  //Test to see which function should be called
  //Send which tile has been selected to respective function
  if (!secondTileSelect) {
    selectPlayerTile(selectionID);
  } else {
    secondPlayerSelection(selectedTile, selectionID);
  }
}

public void selectPlayerTile(int selectionID) {
  
  //Get informatio about the players
  for (int p=0; p<player.length; p++) {
    
    //Test for the player that is taking their turn
    //Get information ahout the tiles
    if (player[p].playerTurn) {
      for (int i=0; i<tile.length; i++) {
        
        //Test that the tile was selcted
        //Test if the tile select has the same id as the player
        if (tile[i].id == selectionID && tile[i].player == player[p].id) {
          //Set the tile to be selected
          tile[i].selected = true;
        }
      }
    }
  }
}

public void secondPlayerSelection(int selectedTile, int selectionID) {
  
  //Test if the dice can move
  boolean move = false;
  
  //Get information about the tiles
  for (int i=0; i<tile.length; i++) {
    
    //Test for the tiles that has the first selection tile id
    if (selectionID == tile[i].id) {
      
      //Test for tiles around the first selected tile
      //Set that tile to be selected
      //Set that the dice can move
      if (tile[i].id == selectedTile + 1) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile - 1) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile - (mapWidth - 1)) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile - mapWidth) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile - (mapWidth + 1)) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile + (mapWidth - 1)) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile + mapWidth) {tile[i].selected = true; move = true; break;}
      if (tile[i].id == selectedTile + (mapWidth + 1)) {tile[i].selected = true; move = true; break;}
    }
  }
  
  //Test if the ddice can move
  //Move the dice
  if (move == true) {
    moveDice(selectedTile, selectionID);
  }
  
  //Reset the selected tiles so that no tiles are selected
  resetSelection();
}

public void resetSelection() {
  
  //Get information about the tiles
  //Set all of the tiles to not be select
  for(int i=0; i<tile.length; i++) {
    tile[i].selected = false;
  }
}

players[] player = {};

class players {
  //The id of the player
  //The starting location for the player on the map
  //Whether it's the player's turn or not
  int id;
  int startID;
  boolean playerTurn;
  int rank;
  
  //The position of the player information on the interface
  int posX;
  int posY;
  
  //The color of the player
  //How many tiles the player controls
  int playerColor;
  int tiles;
  
  
  players(int colorOfPlayer) {
    
    println("create player");
    
    //Set the player id
    //Set the starting position to a random place on the map
    id = player.length + 1;
    startID = (int)random(tile.length);
    rank = 0;
    
    //Set the player's turn to false
    playerTurn = false;
    
    //Set the amount of tiles the player owns to 0
    //Set the color of the player
    tiles = 0;
    playerColor = colorOfPlayer;
  }
  
  public void display(int infoWidth, int player) {
    
    //Test if the player is taking their turn
    //Set the color of the rectangle to green
    //Draw a rectangle behind the player taking their turn
    if (playerTurn) {
      fill(75, 255, 150);
      rect(player * infoWidth + 25, height - 200, infoWidth - 50, 200);
    }
    
    //Set the fill color to the player's color
    //Draw the player information box in the interface
    fill(playerColor);
    rect(player * infoWidth + 5, height - 175, infoWidth - 5, 150);
    
    //Set the color of the font to black
    //Set the font size
    //Center the text
    fill(0);
    textSize(25);
    textAlign(CENTER, CENTER);
    
    //Print how many territories the player owns
    text(tiles, player * infoWidth + infoWidth / 2, height - 100);
  }
}

public void createPlayers(int players) {
  
  int playerAmount = players;
  
  print("create " + players + " players");
  
  //Test if there will be more players playing than before
  if (playerAmount > player.length) {
    
    //Set how many players need to be created
    int newPlayerAmount = playerAmount - player.length;
    
    //Create the necesary amount of players
    for (int i=0; i< newPlayerAmount; i++) {
      
      //Set the color of the player compared to how many players there are
      int playerColor = color((255 / newPlayerAmount) * i, 255, 255);
   
      //Create a new player
      player = (players[])append(player, new players(playerColor));
    }
  }
  
  //Place where the players are going to start
  //Set which player will start the game
  
  if (optButton[3].value == 0) {
    placePlayersOnce();
  } else {
    fillTheMap();
  }
  randomPlayerTurn();
}

public void placePlayersOnce() {
  
  //Get information about the players
  //Get information about the tiles
  for (int p=0; p<player.length; p++) {
    for (int t=0; t<tile.length; t++) {
      
      //Test if the player starting place is equal to the player ID 
      if (player[p].startID + 1 == tile[t].id) {
        
        int tileID = t;
        
        while (tile[tileID].occupied) {
          
          tileID++;
          
          print(tileID);
          
          if (tileID >= tile.length) {
            tileID -= tile.length;
          }
        }
        
        println(p + "   " + tile[tileID].occupied);
        
        //Set the tile to be occupied by the player
        //Set that the tile is occupied
        //Set the color of the tile to the player color
        tile[tileID].player = player[p].id;
        tile[tileID].occupied = true;
        tile[tileID].playerColor = player[p].playerColor;
        
        //Local X and Y variables for the center of the tile
        int x = tile[tileID].posX + tile[tileID].posXOffset + tile[tileID].tileImage.width / 2;
        int y = tile[tileID].posY  + tile[tileID].posYOffset + tile[tileID].tileImage.height / 2;
        
        //Create a dice at that location and with the player's color
        //Increase the amount of tiles that the player owns
        createDie(x, y, 4, player[p].id, tile[tileID].id);
        
        player[p].tiles++;
      }
    }
  }
}

public void fillTheMap() {
  
  int tilesToFill = tile.length;
  
  while (tilesToFill - player.length > 0) {
    for (int p=0; p<player.length; p++) {
      
      int randomID = floor(random(tile.length));
      
      for (int t=0; t<tile.length; t++) {
        if (tile[t].id == randomID) {
          
          int nextTile = t;
          while (tile[nextTile].occupied) {
            nextTile++;
            
            if (nextTile >= tile.length) {
              nextTile -= tile.length;
            }
          }
          
          tile[nextTile].player = player[p].id;
          tile[nextTile].occupied = true;
          tile[nextTile].playerColor = player[p].playerColor;
          
          int x = tile[nextTile].posX + tile[nextTile].posXOffset + tile[nextTile].tileImage.width / 2;
          int y = tile[nextTile].posY  + tile[nextTile].posYOffset + tile[nextTile].tileImage.height / 2;
          
          int diceValue = floor(random(5)) * 2 + 4;
        
          createDie(x, y, diceValue, player[p].id, tile[nextTile].id);
          
          tilesToFill--;
          player[p].tiles++;
          break;
        }
      }
    }
  }
}

public void drawPlayers() {
  
  //Lolca variables to set the width of the player information boxes
  int infoWidth = (int)width / (player.length + 1);
  
  //Get information about the players
  //Draw the player's information
  for (int i=0; i<player.length; i++) {
    player[i].display(infoWidth, i);
  }
  
  //Create the "End Turn" button at the end of all the information boxes
  interfaceNextTurn(infoWidth, player.length);
}

public void updateTileAmount() {
  for (int p=0; p<player.length; p++) {
    player[p].tiles = 0;
    for (int t=0; t< tile.length; t++) {
      if (tile[t].player == player[p].id) {
        player[p].tiles++;
      }
    }
  }
}

public void playerLost() {
  
  int playersLeft = player.length;
  
  for (int p=0; p<player.length; p++) {
    if (player[p].tiles == 0) {
      playersLeft--;
    }
  }
  for (int p=0; p<player.length; p++) {
    if (player[p].tiles == 0 && player[p].rank != 0) {
      player[p].rank = playersLeft;
    }
  }
}

PImage tutorialImage;

boolean tutorialHover = false;

public void loadTutorial() {
  tutorialImage = loadImage("images/tutorial.png");
}

public void drawTutorial() {
  image(tutorialImage, 0, 0);
  
  if (tutorialHover) {
    fill(75, 255, 150);
  } else {
    fill(255);
  }
  rect(25, height - 200, 200, 50);
  
  fill(0);
  textSize(25);
  textAlign(CENTER, CENTER);
  text("Main Menu", 25 + 200 / 2, height - 200 + 25);
}

public void tutorialMouse() {
  for (int b=0; b<button.length; b++) {
    if (mouseX > 25 &&
    mouseX < 25 + 200 &&
    mouseY > height - 200 &&
    mouseY < height - 200 + 50) {
      tutorialHover = true;
    } else {
      tutorialHover = false;
    }
  }
}

public void tutorialClick() {
  for (int b=0; b<button.length; b++) {
    if (mouseX > 25 &&
    mouseX < 25 + 200 &&
    mouseY > height - 200 &&
    mouseY < height - 200 + 50) {
      gamestate = "mainMenu";
    }
  }
}


public void setRanks() {
  
  int playersLeft = player.length;
  
  for (int p=0; p<player.length; p++) {
    if (player[p].rank == 0) {
      playersLeft--;
    }
  }
  
  while (playersLeft > 0) {
    
    int mostTiles = 0;
    int nextRank = mapWidth * mapHeight;
    
    for (int p=0; p<player.length; p++) {
      if (player[p].rank == 0) {
        if (player[p].tiles < mostTiles) {
          mostTiles = player[p].tiles;
          nextRank = player[p].id;
        }
      }
    }
    
    for (int p=0; p<player.length; p++) {
      if (nextRank == player[p].id) {
        player[p].rank = playersLeft;
      }
    }
    playersLeft--;
  }
}

public void drawWinScreen() {
  
  background(0);
  
  for (int p=0; p<player.length; p++) {
    
    if (player[p].rank == 1) {
      fill(player[p].playerColor);
      textSize(50);
      textAlign(CENTER, CENTER);
      text("Congratulations Player " + player[p].id + " you won!", width / 2, height / 2);
      
      textSize(25);
      fill(255);
      text("Created for RIT Imagine Cup 2016", width / 2, (height / 15) * 11);
      text("Developed in under 36 hours", width / 2, (height / 15) * 12);
      text("Programmer and Artist", width / 2, (height / 15) * 13);
      text("Ethan Nichols", width / 2, (height / 15) * 14);
    }
  }
}
  public void settings() {  size(1280, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
