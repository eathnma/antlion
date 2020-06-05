// SWITCH STATE OF GAMEPLAY
int level = 1;

boolean game = false;
boolean dialogue = true;

import ddf.minim.*;
Minim minim;

// gameplay states
final int LEVEL1 = 0;
final int LEVEL2 = 1;
final int LEVEL3 = 2;
final int DEATH = 3;
// commentary states
final int LEVEL1C = 0;
final int LEVEL2C = 1;
final int LEVEL3C = 2;
final int LEVEL4C = 3;

void setup() {
  size( 800, 600 );
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
      // second level gameplay
      break;

    case 3:
      // third level gameplay
      break;
    }
  }  
  if (dialogue == true) {
    switch(lv) {
    case 1:
      println("case 1");
      fill(153);
      rect(30,20,55,55);
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

// SOUND SAMPLE 
//import ddf.minim.*;

//Minim minim;
//AudioInput in;
//color white;

//void setup()
//{
//  size(512, 200, P2D);
//  white = color(255);
//  colorMode(HSB,100);
//  minim = new Minim(this);
//  minim.debugOn();


//  // get a line in from Minim, default bit depth is 16
//  in = minim.getLineIn(Minim.STEREO, 512);
//  background(0);
//}

//void draw()
//{
//  background(0);
//  // draw the waveforms
//  for(int i = 0; i < in.bufferSize() - 1; i++)
//  {
//    stroke((1+in.left.get(i))*50,100,100);
//    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
//    stroke(white);
//    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
//  }
//}


//void stop()
//{
//  in.close();
//  minim.stop();
//  super.stop();
//}
