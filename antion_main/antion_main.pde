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

AudioPlayer platformerSong;
AudioPlayer minigame1Song;
AudioPlayer minigame2Song;
AudioPlayer minigame3Song;

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

  // Setup Minim
  minim = new Minim(this);

  //Setup Music
  platformerSong = minim.loadFile("PLATFORMER BACKGROUND MUSIC.mp3");
  minigame1Song = minim.loadFile("MINIGAME 1-2 BACKGROUND MUSIC.mp3");
  minigame2Song = minim.loadFile("MINIGAME 1-2 BACKGROUND MUSIC.mp3");
  minigame3Song = minim.loadFile("MINIGAME 3 BACKGROUND MUSIC.mp3");
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

    if (key == '1') {
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

      // Play Platformer Song
      platformerSong.play();
      platformerSong.setGain(-15);

      // Stop Other Songs
      minigame1Song.pause();
      minigame2Song.pause();
      minigame3Song.pause();
      break;

    case 1:
      drawMiniGame1();

      // Play Minigame 1 Song
      minigame1Song.play();
      minigame1Song.setGain(-15);

      // Stop Other Songs
      platformerSong.pause();
      minigame2Song.pause();
      minigame3Song.pause();
      break;

    case 2:
      drawMiniGame2();

      // Play Minigame 1 Song
      minigame2Song.play();
      minigame2Song.setGain(-15);

      // Stop Other Songs
      platformerSong.pause();
      minigame1Song.pause();
      minigame3Song.pause();
      break;

    case 3:
      drawMiniGame3();

      // Play Minigame 3 Song
      minigame3Song.play();
      //minigame3Song.loop();
      minigame3Song.setGain(-20);

      // Stop Other Songs
      platformerSong.pause();
      minigame1Song.pause();
      minigame2Song.pause();


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

  //if (keyCode == ' ') 
  //{
  //  // if space is not pressed and making shooting true
  //  // shooting is defined false in play.fire with each individual shot
  //  space = false;
  //  //play.shooting = true;
  //}

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
    play.shooting = true;
  }
}
