
PImage tutorialImage;

boolean tutorialHover = false;

void loadTutorial() {
  tutorialImage = loadImage("images/tutorial.png");
}

void drawTutorial() {
  image(tutorialImage, 0, 0);
  
  if (tutorialHover) {
    fill(75, 255, 150);
  } else {
    fill(255);
  }
  rect(50, height - 400, 300, 150);
  
  fill(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Main Menu", 50 + 300 / 2, height - 400 + 150 / 2);
}

void tutorialMouse() {
  for (int b=0; b<button.length; b++) {
    if (mouseX > 50 &&
    mouseX < 50 + 300 &&
    mouseY > height - 400 &&
    mouseY < height - 400 + 150) {
      tutorialHover = true;
    } else {
      tutorialHover = false;
    }
  }
}

void tutorialClick() {
  for (int b=0; b<button.length; b++) {
    if (mouseX > 50 &&
    mouseX < 50 + 300 &&
    mouseY > height - 400 &&
    mouseY < height - 400 + 150) {
      gamestate = "mainMenu";
    }
  }
}