// IMAGES

// SCENES
PImage scene1, scene2, scene3;

// SOUND //
// Narrator
AudioPlayer NarratorLine1;
AudioPlayer NarratorLine2;
AudioPlayer NarratorLine3;

// Platformer
AudioPlayer AntonyIntroVoice;
AudioPlayer AntonyReachesTopVoice;
AudioPlayer AntillaEatsVoice;

// Minigame 1
AudioPlayer AntonyMinigame1Start;
AudioPlayer AntonyMinigame1Instructions;

// Minigame 2
AudioPlayer AntonyMinigame2Start;
AudioPlayer AntonyMinigame2Instructions;

// Minigame 3
AudioPlayer AnttilaPuke;
AudioPlayer AnttilaFinal;
AudioPlayer AntonyGross;
AudioPlayer AntonyFinal;
AudioPlayer AntifaHelp;
AudioPlayer AntifaFinal;

// Setup
void setupImages(){
  
  scene1 = loadImage("Scene1.png");
  scene2 = loadImage("Scene2.png");
  scene3 = loadImage("Scene3.png");
  
}

void setupMusic(){
  
  NarratorLine1 = minim.loadFile("NARRATOR_LINE1.mp3");
  NarratorLine2 = minim.loadFile("NARRATOR_LINE2.mp3");
  NarratorLine3 = minim.loadFile("NARRATOR_LINE3.mp3");
  
  AntonyIntroVoice = minim.loadFile("ANTONY_INTRO_PLATFORMER.mp3");
  AntonyReachesTopVoice = minim.loadFile("ANTONY_REACHTOP_PLATFORMER.mp3");
  AntillaEatsVoice = minim.loadFile("ANTONY_EATS_PLATFORMER.mp3");
  
  AntonyMinigame1Start = minim.loadFile("ANTONY_STARTLINE_MINIGAME1.mp3");
  AntonyMinigame1Instructions = minim.loadFile("ANTONY_INSTRUCTIONS_MINIGAME1.mp3");
  
  AntonyMinigame2Start = minim.loadFile("ANTONY_STARTLINE_MINIGAME2.mp3");
  AntonyMinigame2Instructions = minim.loadFile("ANTONY_INSTRUCTIONS_MINIGAME2.mp3");
  
  AnttilaPuke = minim.loadFile("ANTTILA PUKES.mp3");
  AnttilaFinal = minim.loadFile("ANTONY_FINAL.mp3");
  AntonyGross = minim.loadFile("ANTONY_GROSSLINE_MINIGAME3.mp3");
  AntonyFinal = minim.loadFile("ANTONY_FINAL_MINIGAME3.mp3");
  AntifaHelp = minim.loadFile("ANTIFA_HELP.mp3");
  AntifaFinal = minim.loadFile("ANTIFA_FINAL.mp3");
}
