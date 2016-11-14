
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
    textSize(25);
    textAlign(CENTER, CENTER);
    text(buttonText, posX + rectWidth / 2, posY + rectHeight / 2);
    
    if (buttonText != "Main Menu") {
      
      if (buttonText != "Win Condition" &&
      buttonText != "Game Mode") {
        
        fill(0);
        textSize(25);
        textAlign(CENTER, CENTER);
        text(value, posX + rectWidth / 2, posY + floor(rectHeight * 1.4)); 
        
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
        text(percentage + " of the map", posX + rectWidth / 2, posY + floor(rectHeight * 1.4)); 
      } else if (buttonText == "Game Mode") {
        
        String mode = "";
        
        if (value >= 1) {
          value = 1;
        }
        
        switch(value) {
          case 0: mode = "One Tile Mode"; break;
          case 1: mode = "Full Map Mode"; break;
        }
        
        text(mode, posX + rectWidth / 2, posY + floor(rectHeight * 1.4)); 
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

void createOptButtons() {
  optButton = (optionButtons[])append(optButton, new optionButtons("Players", width / 2, height / 6, 250, 50, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Map Size", width / 2, (height / 6) * 2, 250, 50, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Win Condition", width / 2, (height / 6) * 3, 250, 50, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Game Mode", width / 2, (height / 6) * 4, 250, 50, "none"));
  optButton = (optionButtons[])append(optButton, new optionButtons("Main Menu", width / 2, (height / 6) * 5, 250, 50, "mainMenu"));
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

void drawOptions() {
  for (int b=0; b<optButton.length; b++) {
    optButton[b].display();
  }
}