// SWITCH STATE OF GAMEPLAY
int level = 1;

boolean game = false;
boolean dialogue = true;

import ddf.minim.*;
Minim minim;
Util myUtil;
Dialogue myDialogue;



void setup() {
  size( 1200, 800 );
  
  // load helper class
  myUtil = new Util();
  
  setupStartScreen();
  setupMiniGame0();
  setupMiniGame3();
}

void draw() {
  background(0);
  
  //level determines both playing & dialogue gamestate. 
  //You can change the variable of "level" at the top of the document.
  gameState(level);
  
   
  
}

void gameState(int lv){
  if (game == true) {
    switch(lv) {
    case 1:
      // first level gameplay
      break;

    case 2:
      drawMiniGame2();
      break;

    case 3:
      drawMiniGame3();
      // third level gameplay
      break;
    }
  }  
  if (dialogue == true) {
    switch(lv) {
    
    case 1:
      //println("case 1");
      //drawMiniGame0();
      //fill(myUtil.randomColor());
      //rect(30,20,55,55);
      drawStartScreen();
      break;

    case 2:
      // first-game dialogue
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
