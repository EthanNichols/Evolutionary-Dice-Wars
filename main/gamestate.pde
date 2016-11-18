
//The amount of tiles needed to win the game
//Then gamestate that is being displayed
int tilesToWin;
String gamestate = "mainMenu";

void testWinner() {

  //Get information about the players
  for (int p=0; p<player.length; p++) {

    //Test if the player has more tiles than need to win the game
    //Set the gamestate to the end game screen
    //Set the player rank who won to 1
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

  //Set the amount of tiles to win equal to the size of the map divided by the percent needed to win
  tilesToWin = ceil(((mapWidth * mapHeight) / 4) * (optButton[2].value + 1));
}

void gamestateDraw() {

  //Test the gamestate to display is the main menu
  //Draw the functions relative to the gamestate
  if (gamestate == "mainMenu") {
    //Update the information about the mouse
    mainMenuMouse();

    //Draw the buttons on the main menu
    //Draw the dice that change on the main menu
    drawMainMenu();
    drawMenuAnimation();

    //Test the gamestate to display is the option menu
    //Draw the functions relative to the gamestate
  } else if (gamestate == "options") {

    //Draw the buttons on the options menu
    //Update information about the mouse
    drawOptions();
    optionsMouse();

    //Test the gamestate to display is the game
    //Draw the functions relative to the gamestate
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

    //Test the gamestate to display is the end screen
    //Draw the functions relative to the gamestate
  } else if (gamestate == "endGame") {
    //Draw the end game screen
    drawWinScreen();

    //Test the gamestate to display is the tutorial
    //Draw the functions relative to the gamestate
  } else if (gamestate == "tutorial") {

    //Draw the tutorial image and button
    drawTutorial();

    //Update information about the mouse
    tutorialMouse();

    //Test the gamestate to display is to exit
    //Draw the functions relative to the gamestate
  } else if (gamestate == "exit") {
    //Exit the game
    exit();
  }
}

void gamestateMouse() {

  //Test the gamestate to display
  //Execute functions when the mouse is pressed
  if (gamestate == "game") {

    //Select tiles relative to the mouse positions
    //End the turn if the mouse pressed the "end turn" button
    selectTile();
    endTurn();

    //Test if the right mouse button is pressed
    //End the player's turn and go to the next turn
    if (mouseButton == RIGHT) {
      nextTurn();
    }

    //Test the gamestate to display
    //Execute functions when the mouse is pressed
  } else if (gamestate == "mainMenu") {
    mainMouseClick();
  } else if (gamestate == "options") {
    optionsClick();
  } else if (gamestate == "tutorial") {
    tutorialClick();
  }
}