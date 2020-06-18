// SWITCH STATE OF GAMEPLAY
int level = 3;
int startTimer;
int goodTimer;
int badTimer;

boolean game = false;
boolean dialogue = true;
int dialogueCount = 1;

import ddf.minim.*;
Minim minim;
Util myUtil;
Dialogue myDialogue;

Player play;
Antilla antilla;

void setup() {
  // load helper class
  myUtil = new Util();

  // generic 
  size( 1200, 800 );
  frameRate(60);
  smooth();

  myDialogue = new Dialogue("test dialogue");
  
  // setup for dialogue
  myDialogue.allDialogue();

  // setup's for minigames
  setupStartScreen();
  setupMiniGame0();
  setupMiniGame1();
  setupMiniGame2();
  setupMiniGame3();
}

void draw() {
  background(0);
  //level determines both playing & dialogue gamestate. 
  //You can change the variable of "level" at the top of the document.
  if (keyPressed) {

    if (key == '0') {
      level = 0;
      println("game zero");
    }
    
    if (key == '1'){
      startTimer = second();
      level = 1;
      println("game one");
    }

    if (key == '2') {
      goodTimer = second();
      badTimer = second();
      level = 2;
      println("game two");
    }

    if (key == '3') {
      level = 3;
      println("game three");
    }
  }

  gameState(level);
}

void gameState(int lv) {
  if (game == true) {
    switch(lv) {
    case 0:
      drawMiniGame0();
      break;

    case 1:
      drawMiniGame1();
      break;

    case 2:
      drawMiniGame2();
      break;

    case 3:
      drawMiniGame3();
      break;
    }
  }  

  if (dialogue == true) {
    switch(lv) {

    case 0:
      // starting screen dialogue
      drawStartScreen();
      break;

    case 1:
      myDialogue.counter(dialogueOne);
      break;

    case 2:
      myDialogue.counter(dialogueOneEnd);
      break;

    case 3:
      myDialogue.counter(minigameOne);
      break;

    case 4:
      myDialogue.counter(minigameTwo);
      break;

    case 5:
      myDialogue.counter(minigameThree);
      break;

    case 6:
      // lose state dialogue
      break;
    }
  }
}

 // Booleans
  boolean left, right, jump;
 // keyPressed
  void keyPressed() {

    // up3, down3, left3, right3.
    if (keyCode == UP || key == 'w' || key == 'W') up3 = true;
    if (keyCode == DOWN || key == 's' || key == 'S') down3 = true;
    //if (keyCode == ' ') space = true;

    if (key == 'a' || key == 'A' || keyCode == LEFT) {
      left = true;
      left3 = true;
    }

    if (key == 'd' || key == 'D' || keyCode == RIGHT) {
      right = true;
      right3 = true;
    }

    if (key == ' ') {
      space3 = true;
      jump = true;
    }
  }

  // keyReleased
  void keyReleased() {

    if (keyCode == UP || key == 'w' || key == 'W') up3 = false;
    if (keyCode == DOWN || key == 's' || key == 'S') down3 = false;

    if (key == 'a' || key == 'A' || keyCode == LEFT) {
      left = false;
      left3 = false;
    }

    if (key == 'd' || key == 'D' || keyCode == RIGHT) {
      right = false;
      right3 = false;
    }

    if (key == ' ') {
      jump = false;
      space3 = false;
      
      // shooting minigame 3
      play.shooting = true;
      // dialogue minigame
      dialogueCount = dialogueCount + 1;
      
      // to reset the char
      myDialogue.counter = 0;
    }
  }
