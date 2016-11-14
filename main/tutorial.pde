
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
  rect(25, height - 200, 200, 50);
  
  fill(0);
  textSize(25);
  textAlign(CENTER, CENTER);
  text("Main Menu", 25 + 200 / 2, height - 200 + 25);
}

void tutorialMouse() {
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

void tutorialClick() {
  for (int b=0; b<button.length; b++) {
    if (mouseX > 25 &&
    mouseX < 25 + 200 &&
    mouseY > height - 200 &&
    mouseY < height - 200 + 50) {
      gamestate = "mainMenu";
    }
  }
}