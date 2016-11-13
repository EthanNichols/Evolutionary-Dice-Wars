
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
    
    if (buttonName == "Players" || buttonName == "Computers") {
      value = 1;
    } else if (buttonName == "Map Size") {
      value = 3;
    }
  }
  
  void display() {
    
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
    textSize(50);
    textAlign(CENTER, CENTER);
    text(buttonText, posX + rectWidth / 2, posY + rectHeight / 2);
    
    if (buttonText != "Main Menu") {
      fill(0);
      textSize(50);
      textAlign(CENTER, CENTER);
      text(value, posX + rectWidth / 2, posY + floor(rectHeight * 1.2)); 
    
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

void createOptButtons() {
  optButton = (optionButtons[])append(optButton, new optionButtons("Players", width / 2, height / 7, 350, 150, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Computers", width / 2, (height / 7) * 2, 350, 150, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Map Size", width / 2, (height / 7) * 3, 350, 150, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Win Condition", width / 2, (height / 7) * 4, 350, 150, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Game Mode", width / 2, (height / 7) * 5, 350, 150, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Main Menu", width / 2, (height / 7) * 6, 350, 150, "mainMenu"));
}

void optionsMouse() {
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

void optionsClick() {
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
      
      if (optButton[b].value <= 0) {
        optButton[b].value = 0;
      }
    }
    
    if (mouseX > optButton[b].posX + optButton[b].rectWidth + optButton[b].rectWidth / 8 &&
    mouseX < optButton[b].posX + optButton[b].rectWidth + optButton[b].rectWidth / 3 &&
    mouseY > (optButton[b].posY - optButton[b].rectHeight / 8) &&
    mouseY < optButton[b].posY + optButton[b].rectHeight - optButton[b].rectHeight / 8) {
      optButton[b].value++;
      
      if (optButton[b].value >= 4) {
        optButton[b].value = 4;
      }
    }
  }
}

void drawOptions() {
  for (int b=0; b<optButton.length; b++) {
    optButton[b].display();
  }
}