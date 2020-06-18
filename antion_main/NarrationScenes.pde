

// NARRATION MUSIC METHODS
void playNarrationMusic(){
  
 NarrationMusic.play();
 NarrationMusic.setGain(-19);
}

void stopNarrationMusic(){
  NarrationMusic.pause();  
}

// SCENE 1 METHODS
void drawScene1(){
  imageMode(CORNER);
  image(scene1, 0, 0);
}

void playNarrationScene1(){
  NarratorLine1.play();
  NarratorLine1.setGain(4);
}

void stopNarrationScene1(){
  NarratorLine1.pause();
}

// SCENE 2 METHODS
void drawScene2(){
  imageMode(CORNER);
  image(scene2, 0, 0);
}

void playNarrationScene2(){
  NarratorLine2.play();
  NarratorLine2.setGain(4);
}

void stopNarrationScene2(){
  NarratorLine2.pause();
}

// SCENE 3 METHODS
void drawScene3(){
  imageMode(CORNER);
  image(scene3, 0, 0);
}

void playNarrationScene3(){
  NarratorLine3.play();
  NarratorLine3.setGain(4);
}

void stopNarrationScene3(){
  NarratorLine3.pause();
}
