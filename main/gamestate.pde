
int tilesToWin;
String gamestate = "mainMenu";

void testWinner() {
  for (int p=0; p<player.length; p++) {
    if (player[p].tiles > tilesToWin) {
      gamestate = "endGame";
      player[p].rank = 1;
    }
  }
}

void startGame() {
  //Create the map that will be played on
  //Create the players that will be playing
  createMap(optButton[1].value);
  createPlayers(optButton[0].value);
  
  tilesToWin = ceil(((mapWidth * mapHeight) / 4) * (optButton[2].value + 1));
}

void gamestateDraw() {
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

void gamestateMouse() {
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