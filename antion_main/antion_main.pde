// SWITCH STATE OF GAMEPLAY
int level = 0;
int startTimer;

boolean game = true;
boolean dialogue = false;

import ddf.minim.*;
Minim minim;
Util myUtil;
Dialogue myDialogue;

void setup() {
  // load helper class
  myUtil = new Util();

  // generic 
  size( 1200, 1024 );
  frameRate(60);
  smooth();

  myDialogue = new Dialogue("test dialogue");

  // setup's for minigames
  setupStartScreen();
  setupMiniGame0();
  setupMiniGame1();
  setupMiniGame3();
}

void draw() {
  background(0);
  //level determines both playing & dialogue gamestate. 
  //You can change the variable of "level" at the top of the document.
  if (keyPressed) {
    
    if (key == '0'){
      level = 0;
      println("game zero");
    }
    
    if (key == '1'){
      startTimer = second();
      level = 1;
      println("game one");
    }

    if (key == '2'){
      level = 2;
      println("game two");
    }
  
    if (key == '3'){
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
      drawStartScreen();
      break;

    case 1:
      break;

    case 2:
      // first-game dialogue
      myDialogue.drawDialogue("hehe", 0, 0);
      break;


    case 3:
      // second-game dialogue
      break;

    case 4:
      // third-game dialogue
      break;

    case 5:
      // end-game dialogue
      break;

    case 6:
      // lose state dialogue
      break;
    }
  }
}
