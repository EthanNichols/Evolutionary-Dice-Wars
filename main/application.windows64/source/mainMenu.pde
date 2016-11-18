
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
  
  void display() {
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

void createButtons() {
  button = (menuButtons[])append(button, new menuButtons("Play Game!", width / 2, height / 5, 250, 50, "game"));
  button = (menuButtons[])append(button, new menuButtons("Options", width / 2, (height / 5) * 2, 250, 50, "options"));
  button = (menuButtons[])append(button, new menuButtons("Tutorial", width / 2, (height / 5) * 3, 250, 50, "tutorial"));
  button = (menuButtons[])append(button, new menuButtons("Exit", width / 2, (height / 5) * 4, 250, 50, "exit"));
}

void mainMenuMouse() {
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

void mainMouseClick() {
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

void drawMainMenu() {
  
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