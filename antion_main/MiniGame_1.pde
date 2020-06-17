import ddf.minim.*;
import ddf.minim.analysis.*;

AudioInput in;
FFT fft;

//# of frequency band rows detected
int nFreqBand = 10;

int note;
int currentTimer;
int score = 0;

//screen height
int h = 800;
float guideY = h/nFreqBand;
float guideSize = h/nFreqBand;

color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color yellow = color(253, 255, 56);

Guide g = new Guide(10, guideY, guideSize, guideSize);
ArrayList<Notes> notes = new ArrayList<Notes>();

void setupMiniGame1() {
  //size(800, 1024);

  //minim object initialization
  minim = new Minim(this);
  fft = new FFT(1024, 44100);
  in = minim.getLineIn(Minim.STEREO, 1024);

  noStroke();
}


//30 Bands, 1= 0-43(C0-E1), 2= 43-86(F1-E2), 3= 86-129(F2-B2), 4= 129-172(C3-E3), 5= 172-215(F3-G#3), 6= 215-258(A3-B3), 
//7= 258-301(C4-D4), 8= 301-344(D#4-E4), 9= 344-388(F4 & F#4), 10= 388-430(G4 & G#4), 11= 430-474(A4 & A#4), 12= 474-517(B4),
//13= 517-560(C5 & C#5), 14= 560-603(D5), 15= 603-646(D#5), 16= 646-689(E5), 17= 689-732(F5), 18= 732-775(F#5), 19= 775-818(G5),
//20= 818-861(G#5), 21= 861-904(A5), 22= 904-947(A#5), 23= 947-991(B5), 24= 991-1034(not music LOL), 25= 1034-1076(C6)
void drawMiniGame1()
{
  background(0);
  currentTimer = second() - startTimer;
  textSize(30);
  text("Score: " + score, 20, 50);

  //analyzes audio from input mix
  fft.forward(in.mix);
  //for all frequency bands...
  for (int i = 0; i < nFreqBand; i++)
  {
    //if volume of a particular frequency band is large enough, set it as the note being sung
    float amplitude = fft.getBand(i)*10;
    if (amplitude > 1000) {
      note = i;
      g.note = i;
    }
  }

  //spawns in notes based on seconds passed since level started
  if (currentTimer == 1) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 9), 1, guideSize, red));
  } 
  if (currentTimer == 2) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 8), 1, guideSize, blue));
  } 
  if (currentTimer == 3) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 9), 1, guideSize, red));
  } 
  if (currentTimer >= 4 && currentTimer <= 6) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 6), 1, guideSize, green));
  } 
  if (currentTimer == 8) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 9), 1, guideSize, red));
  } 
  if (currentTimer == 9) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 8), 1, guideSize, blue));
  } 
  if (currentTimer >= 10 && currentTimer < 12) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 7), 1, guideSize, yellow));
  } 
  if (currentTimer == 12) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 6), 1, guideSize, green));
  } 
  if (currentTimer >= 13 && currentTimer < 15) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 7), 1, guideSize, yellow));
  } 
  if (currentTimer == 15) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 8), 1, guideSize, blue));
  } 
  if (currentTimer == 16) {
    notes.add(new Notes(width, height - ((height/nFreqBand) * 7), 1, guideSize, yellow));
  }


  //for every note spawned, move it, and remove + add score if notes hit guide
  for (int i = 0; i < notes.size(); i++) {
    Notes n = notes.get(i);
    n.tick();
    if (n.hit(g)) {
      score += 1;
      notes.remove(i);
    }
  }
  for (Notes n : notes) {
    n.draw();
  }

  //draw and update guide
  g.tick();
  g.draw();

  //lose/win conditions go here
  if (score >= 500) {
    println("YOU ARE WORTHY...");
  } else {
    println("YOU ARE NOT WORTHY!");
  }
}

///////////////////////////////////////////////////////////////////

class Guide {
  float x, y, w, h;
  int note = 0;

  float screenH = 800;

  Guide(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void draw() {
    colorMode(RGB);
    fill(255, 255, 255);
    rect(x, y, w, h);
  }

  //the screen is divided into 30 rows, each row correlates to a frequency band
  //the guide snaps to each row depending on frequency currently being detected
  void tick() {
    y = screenH - ((screenH/nFreqBand)*note);
  }
}

//////////////////////////////////////////////

class Notes {
  float x, y, w, h;
  color c;

  Notes(float x, float y, float w, float h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }

  void draw() {
    colorMode(RGB);
    fill(c);
    rect(x, y, w, h);
  }

  boolean hit(Guide g) {
    boolean hit = false;
    if (x + w > g.x && x < g.x + g.w && y + h > g.y && y < g.y + g.h) {
      hit = true;
    }
    return hit;
  }

  void tick() {
    x -= 1;
  }
}
