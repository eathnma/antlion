int level = 0; // IF YOU WANT TO CHANGE LEVELS CHANGE THIS VALUE
// 0 = level 1 
// 1 = level 2 
// 2 = level 3
// CHECK THE README TO FIND THE SOLUTION
boolean game;
boolean dialogue = true;

import ddf.minim.*;
Minim minim;
AudioPlayer cook;
AudioPlayer melody;
AudioPlayer boop;
AudioPlayer YO;
AudioPlayer scarybee;
AudioPlayer evilman;
AudioPlayer herewego;

// states for gameplay
final int LEVEL1 = 0;
final int LEVEL2 = 1;
final int LEVEL3 = 2;
final int DEATH = 3;
// states for commentary
final int LEVEL1C = 0;
final int LEVEL2C = 1;
final int LEVEL3C = 2;
final int LEVEL4C = 3;

int count;

PImage titlepage;
PImage main0;
PImage main1;
PImage main2;
PImage gamebackground1;
PImage instruct;

// dialogue
PImage angryethan;
PImage normalethan;
PImage surprisedethan;
PImage ericimage;
PImage fisheric;
PImage junwei;
PImage erictextbox;
PImage ethantextbox;
PImage junweitextbox;
PImage fisherictextbox;
PImage nursejunweitextbox;
PImage lvoneend;

// level one
PImage lamp1; 
PImage lamp2;
PImage lamp3;

PImage fish0;
PImage fish1;
PImage fish2;

PImage fishfood0;
PImage fishfood1;
PImage fishfood2;

PImage door;
PImage dooreric;
PImage dooropen;
PImage drawer;
PImage drawerbottom;
PImage drawertop;
PImage drawertopmatch;

PImage woodcabinet;
PImage openwoodcabinet;
PImage woodcabinetfire;
PImage bwoodcabinet;
PImage ericwoodcabinet;

// level two
PImage fireextinguisher;
PImage match;
PImage ericdrawerbottom;
PImage angrybee;
PImage deadbee;

// level three
PImage curtain;
PImage curtainleft;
PImage curtainright;
PImage curtainopen;

PImage slidingdoor;
PImage slidingdoorempty;
PImage slidingdooropen;
PImage ericslidingdoor;

PImage straightladder;
PImage wallladder;

PImage wallhole;
PImage ericwallhole;
PImage bar1;
// ------------------------end-----------------------
PImage arrow;
PImage cabinet;
PImage fishbowl;
PImage greyfish;
PImage yellowfish;
PImage lightswitch;
PImage trash;

PImage foodbanner;
PImage fishbanner;
PImage matchbanner;
PImage barbanner;
PImage extinguisherbanner;
PImage ladderbanner;

PImage aletter;
PImage bletter;
PImage cletter;

PImage lvtwoend;
PImage lvthreeend;

PImage goodbye;
PImage theend;

levelOne l;
levelTwo lt;
levelThree lt3;
Common c;
Image i;
Dialogue d;


//properties for the level
int ericsays = 0;

// the arrays for the Image movements
PImage[] lamps = new PImage[3];

void setup()
{
  size( 800, 600 );
  titlepage = loadImage("titlepage.png");
  cabinet = loadImage( "cabinet.png");
  fishbanner = loadImage("fishbanner.png");
  fishbowl = loadImage("fishbowl.png");
  foodbanner = loadImage("foodbanner.png");
  greyfish = loadImage("greyfish.png");
  yellowfish = loadImage("yellowfish.png");
  arrow = loadImage( "arrow.png");
  lightswitch = loadImage("lightswitch.png");
  trash = loadImage("trash.png");
  junweitextbox = loadImage("junweitextbox.png");
  ethantextbox = loadImage("ethantextbox.png");
  erictextbox = loadImage("erictextbox.png");
  nursejunweitextbox = loadImage("nursejunweitextbox.png");
  fisherictextbox = loadImage("fisherictextbox.png");
  lvoneend = loadImage("background0.PNG");
  fish1 = loadImage("fish1.png");
  fish2 = loadImage("fish2.png");
  fishfood0 = loadImage("fishfood0.png");
  fishfood1 = loadImage("fishfood1.png");
  fishfood2 = loadImage("fishfood2.png");
  woodcabinet = loadImage("woodcabinet.png");
  openwoodcabinet = loadImage("openwoodcabinet.png");
  woodcabinetfire = loadImage("woodcabinetfire.png");

  curtain = loadImage("curtain.png");
  curtainleft = loadImage("curtainleft.png");
  curtainright = loadImage("curtainright.png");
  curtainopen = loadImage("curtainopen.png");
  door = loadImage("door.png");
  dooreric = loadImage("dooreric.png");
  dooropen = loadImage("dooropen.png");
  drawer = loadImage("drawer.png");
  drawerbottom = loadImage("drawerbottom.png");
  drawertop = loadImage("drawertop.png");
  drawertopmatch = loadImage("drawertopmatch.png");
  fireextinguisher = loadImage("fireextinguisher.png");
  fisheric = loadImage("fisheric.png");
  match = loadImage("match.png");
  slidingdoor = loadImage("slidingdoor.png");
  slidingdoorempty = loadImage("slidingdoorempty.png");
  slidingdooropen = loadImage("slidingdooropen.png");
  straightladder = loadImage("straightladder.png");
  wallladder = loadImage("wallladder.png");
  wallhole = loadImage("wallhole.png");
  ericimage = loadImage("eric.png");
  ericslidingdoor = loadImage("ericslidingdoor.png");
  bar1 = loadImage("bar.png");
  ericwallhole = loadImage("ericwallhole.png");
  matchbanner = loadImage("matchbanner.png");
  barbanner = loadImage("barbanner.png");
  extinguisherbanner = loadImage("extinguisherbanner.png");
  ladderbanner = loadImage("ladderbanner.png");
  ericdrawerbottom = loadImage("ericdrawerbottom.png");
  angrybee = loadImage("angrybee.png");
  aletter = loadImage("a.png");
  bletter = loadImage("b.png");
  cletter = loadImage("c.png");
  lvthreeend = loadImage("lvthreeend.PNG");
  ericwoodcabinet = loadImage("ericwoodcabinet.png");
  bwoodcabinet = loadImage("bwoodcabinet.png");
  deadbee = loadImage("deadbee.png");
  lvtwoend = loadImage("lvtwoend.PNG");
  main0 = loadImage("main0.png");
  main1 = loadImage("main1.png");
  main2 = loadImage("main2.png");
  gamebackground1= loadImage("teest.png");
  goodbye = loadImage("goodbye.png");
  theend = loadImage("theend.png");
  instruct = loadImage("instruct.png");

  l = new levelOne(1, 0, 800 ); 
  lt = new levelTwo( 1, 0, 800 );
  lt3 = new levelThree( 1, 0, 800 );
  c = new Common( 0, 0, 0 );
  i = new Image();
  d = new Dialogue();

  for ( int i = 0; i < lamps.length; i++)
  {
    lamps[i] = loadImage("lamp" + i + ".png");
  }
  minim= new Minim(this);
  cook = minim.loadFile("cook.mp3");
  melody= minim.loadFile("melody.mp3");
  boop = minim.loadFile("boop.mp3");
  YO = minim.loadFile("YO.mp3");
  scarybee = minim.loadFile("scarybee.mp3");
  evilman = minim.loadFile("evilman.mp3");
  herewego = minim.loadFile("herewego.mp3");

  //player.play();
}
void draw()
{
  noStroke();
  imageMode(CENTER);
  c.circles();// so circles are behind the images
  c.changeScreen(); //change the screen man
  if ( count < 0 ) count = 0;
  if (game)
  {
    switch(level)
    {
    case 0:
      l.pasteImage();
      i.lvone();// drawing array of images onto the canvas
      l.update(); // level one update
      break;

    case 1:
      lt.update();
      i.lvtwo(); // drawing array of images on the canvas
      break;

    case 2:
      lt3.update();
      i.lvthree();
      break;

    case 3:
      break;
    }
  }
  if (dialogue)
  {
    switch( ericsays )
    {
    case 0: // beginning
      d.titlescreen();
      break;

    case 1: // beginning dialogue
      d.beginning();
      break;

    case 2: // lv 1
      d.lvone();
      break;

    case 3: // lv 2
      d.lvtwo();
      break;

    case 4: // lv 3
      d.lvthree();
      break;

    case 5: // death commentary
      d.death( mouseX, mouseY );
      break;

    case 6:
      d.theend();
      break;
    }
    println(d.transparency);
    d.blackscreen(); // this must always be over everything.
    if (mousePressed)
    {
      println( mouseX, mouseY);
    }
  }
}
void keyReleased()
{
  if (keyCode == ' ') 
  {
    boop.rewind();
    boop.play();
    count = count + 1;
    println(count);
  }
  if (keyCode == BACKSPACE) 
  {
    boop.rewind();
    boop.play();
    count = count - 1;
  }
}