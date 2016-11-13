
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

void loadAnimationImages() {
  hugeD4 = loadImage("images/hugeD4.png");
  hugeD6 = loadImage("images/hugeD6.png");
  hugeD8 = loadImage("images/hugeD8.png");
  hugeD10 = loadImage("images/hugeD10.png");
  hugeD12 = loadImage("images/hugeD12.png");
  hugeD20 = loadImage("images/hugeD20.png");
}

void drawMenuAnimation() {
  
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

void drawAttack() {
  
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

void setAttackVariables(int player1, int player2, int die1, int die2, int dieRoll1, int dieRoll2, int start, int finish) {
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

void attackAnimation(int player1, int player2, int die1, int die2, int dieRoll1, int dieRoll2, int start, int finish) {
  
  color dieColor1 = color(255);
  color dieColor2 = color(255);
  
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