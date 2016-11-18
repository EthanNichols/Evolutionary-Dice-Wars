
//How long the animation is going for
int animationTimer = 0;

//Which player the dice belongs to
int playerDice1;
int playerDice2;

//How big the dice is
int sidesOnDie1;
int sidesOnDie2;

//The number that the dice rolls
int dieRolled1;
int dieRolled2;

//The position of the attacking die
//The position of the defending die
int starting;
int finishing;

//Whether the attack is happening or not
boolean animatedAttack;

//How long it takes for the dice to change on the main menu
//The die that is being drawn on the left
//The die that is being drawn on the right
int mainMenuDelay = 10;
int die1 = 0;
int die2 = 0;

//Set all the image names for the huge dice
PImage hugeD4;
PImage hugeD6;
PImage hugeD8;
PImage hugeD10;
PImage hugeD12;
PImage hugeD20;

void loadAnimationImages() {
  //Set all the images to the image names
  hugeD4 = loadImage("images/hugeD4.png");
  hugeD6 = loadImage("images/hugeD6.png");
  hugeD8 = loadImage("images/hugeD8.png");
  hugeD10 = loadImage("images/hugeD10.png");
  hugeD12 = loadImage("images/hugeD12.png");
  hugeD20 = loadImage("images/hugeD20.png");
}

void drawMenuAnimation() {

  //Test if the main menu dice can be changes
  if (mainMenuDelay <= 0) {
    //Set the new dice value for the left and right die
    die1 = floor(random(6));
    die2 = floor(random(6));

    //Reset the timer before the die changes
    mainMenuDelay = 10;
  }

  //Set a default image for the two dice
  PImage dieImg1 = hugeD4;
  PImage dieImg2 = hugeD4;

  //Test the value of the randomization
  //Set the die image relative to the random value
  switch(die1) {
  case 0: 
    dieImg1 = hugeD4; 
    break;
  case 1: 
    dieImg1 = hugeD6; 
    break;
  case 2: 
    dieImg1 = hugeD8; 
    break;
  case 3: 
    dieImg1 = hugeD10; 
    break;
  case 4: 
    dieImg1 = hugeD12; 
    break;
  case 5: 
    dieImg1 = hugeD20; 
    break;
  }

  //Test the value of the randomization
  //Set the die image relative to the random value
  switch(die2) {
  case 0: 
    dieImg2 = hugeD4; 
    break;
  case 1: 
    dieImg2 = hugeD6; 
    break;
  case 2: 
    dieImg2 = hugeD8; 
    break;
  case 3: 
    dieImg2 = hugeD10; 
    break;
  case 4: 
    dieImg2 = hugeD12; 
    break;
  case 5: 
    dieImg2 = hugeD20; 
    break;
  }

  //reduce the amount of time it will take for the dice to change
  mainMenuDelay--;

  //Draw the dice on the left and the right side of the button on the main menu
  image(dieImg1, width / 4 - hugeD6.width / 2, height / 2 - hugeD6.height / 2);
  image(dieImg2, (width / 4) * 3 - hugeD6.width / 2, height / 2 - hugeD6.height / 2);
}

void drawAttack() {

  //Test if the attacking animation is currently happening
  if (animationTimer >= 0 && animatedAttack) {

    //Call the attack animation function to draw the attack
    attackAnimation(playerDice1, playerDice2, sidesOnDie1, sidesOnDie2, dieRolled1, dieRolled2, starting, finishing);

    //Reduce te amount of time the animation will run
    animationTimer--;

    //Test if the attacking animation is finished
  } else if (animationTimer < 0 && animatedAttack) {

    //Create a delay so the actual values of the dice are visible
    //Set the the attacking animation is done
    delay(1000);
    animatedAttack = false;

    //Test if the attacking die rolls higher than the defending die
    //Move the the dice with respect to the result
    if (dieRolled1 > dieRolled2) {
      moveDice(starting, finishing);
    }
  }
}

void setAttackVariables(int player1, int player2, int die1, int die2, int dieRoll1, int dieRoll2, int start, int finish) {

  //Set the player the die belongs to
  playerDice1 = player1;
  playerDice2 = player2;

  //Set the amount of sides the die has
  sidesOnDie1 = die1;
  sidesOnDie2 = die2;

  //Set the amount that the die rolled
  dieRolled1 = dieRoll1;
  dieRolled2 = dieRoll2;

  //Set the starting and defending positions for the die
  starting = start;
  finishing = finish;

  //Set the length of time for the animation
  //Set that an animation is happening
  animationTimer = 10;
  animatedAttack = true;
}

void attackAnimation(int player1, int player2, int die1, int die2, int dieRoll1, int dieRoll2, int start, int finish) {

  //Set the color of the die to a default color
  color dieColor1 = color(255);
  color dieColor2 = color(255);

  //Get information about the players
  for (int p=0; p<player.length; p++) {

    //Test if the player id is equal to the player the die belongs to
    //Set the color of the die to the color of the player
    if (player[p].id == player1) {
      dieColor1 = player[p].playerColor;
    }

    //Test if the player id is equal to the player the die belongs to
    //Set the color of the die to the color of the player
    if (player[p].id == player2) {
      dieColor2 = player[p].playerColor;
    }
  }

  //Set a default image for the two dice
  PImage dieImg1 = hugeD4;
  PImage dieImg2 = hugeD4;

  //Test the value of the randomization
  //Set the die image relative to the random value
  switch(die1) {
  case 4: 
    dieImg1 = hugeD4; 
    break;
  case 6: 
    dieImg1 = hugeD6; 
    break;
  case 8: 
    dieImg1 = hugeD8; 
    break;
  case 10: 
    dieImg1 = hugeD10; 
    break;
  case 12: 
    dieImg1 = hugeD12; 
    break;
  case 20: 
    dieImg1 = hugeD20; 
    break;
  }

  //Test the value of the randomization
  //Set the die image relative to the random value
  switch(die2) {
  case 4: 
    dieImg2 = hugeD4; 
    break;
  case 6: 
    dieImg2 = hugeD6; 
    break;
  case 8: 
    dieImg2 = hugeD8; 
    break;
  case 10: 
    dieImg2 = hugeD10; 
    break;
  case 12: 
    dieImg2 = hugeD12; 
    break;
  case 20: 
    dieImg2 = hugeD20; 
    break;
  }

  //Test if the animation is still happening
  if (animationTimer > 0) {

    //Set the color of the die to the player color
    //Draw the die
    tint(dieColor1);
    image(dieImg1, width / 3 - dieImg1.width / 2, height / 2 - dieImg1.height / 2);

    //Set the color of the die to the player color
    //Draw the die
    tint(dieColor2);
    image(dieImg2, (width / 3) * 2 - dieImg2.width / 2, height / 2 - dieImg2.height / 2);

    //Set the color of the text to black
    //Set the size of the text to 100
    //Center the text on the dice animation
    fill(0);
    textSize(100);
    textAlign(CENTER, CENTER);

    //Draw a random value that the die could roll on the die 
    text(floor(random(die1) + 1), width / 3, height / 2);
    text(floor(random(die2) + 1), (width / 3) * 2, height / 2);
  }

  //Test if the attacking animation is done 
  if (animationTimer <= 0) {

    //Set the color of the die to the player color
    //Draw the die
    tint(dieColor1);
    image(dieImg1, width / 3 - dieImg1.width / 2, height / 2 - dieImg1.height / 2);

    //Set the color of the die to the player color
    //Draw the die
    tint(dieColor2);
    image(dieImg2, (width / 3) * 2 - dieImg2.width / 2, height / 2 - dieImg2.height / 2);

    //Set the color of the text to black
    //Set the size of the text to 100
    //Center the text on the dice animation
    fill(0);
    textSize(100);
    textAlign(CENTER, CENTER);

    //Draw the rolled amount on the dice to give the player a visual indicator of who onwon
    text(dieRoll1, width / 3, height / 2);
    text(dieRoll2, (width / 3) * 2, height / 2);
  }
}