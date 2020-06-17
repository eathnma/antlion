static final int start = 0;
static final int playing = 1;
static final int ending = 2;

int screen = start;

int n = 6;
int score = 0;
int fullCharge = 90;

int level = 1;

int deathTimer = 60;

boolean spawnonce;

Chara chara;
Player play;
Projectile project;
Basic_Enemy b;
Boss_Enemy BE;


ArrayList <Basic_Enemy> basicAL = new ArrayList < Basic_Enemy>();

void setup()
{
 size( 400, 600 );
 frameRate(60);
 play = new Player( 40, 40, new PVector(179,541), new PVector(0,0) );
  
}

void draw()
{
  if( screen == start)
  {
    starting();
  } else if ( screen == playing)
  {
  // this is the main
  //println(roundCount);
  println(enemyCount);
  
  background(0);
  puteverythingyoudontwantinhere();
  //player and stuff
  play.update();
  
  // movement of the arrowkeys
  if(up) play.accelerate(upForce);
  if(down) play.accelerate(downForce);
  if(left) play.accelerate(leftForce);
  if(right) play.accelerate(rightForce);
  
  for( int i = 0; i < basicAL.size(); i++)
  {
    Basic_Enemy be = basicAL.get(i);
    be.update();
  }
  // this is to call the waves
  rounds();
  text( score, 10, 20 );
  } else if ( screen == ending )
  {
    gameover();
  }
  
  // this is the main
  
 if(mousePressed)
 {
   println(mouseX,mouseY);
 }
 
}

PVector upForce = new PVector (0,-2);
PVector downForce = new PVector (0,2);
PVector leftForce = new PVector (-2,0);
PVector rightForce = new PVector (2,0);

boolean up, down, left, right, space;

void keyPressed()
{
    if(keyCode == UP) up = true;
    if(keyCode == DOWN) down = true;
    if(keyCode == LEFT) left = true;
    if(keyCode == RIGHT) right = true;
    if(keyCode == ' ') space = true;
}

void keyReleased()
{
    if(keyCode == UP) up = false;
    if(keyCode == DOWN) down = false;
    if(keyCode == LEFT) left = false;
    if(keyCode == RIGHT) right = false;
    if(keyCode == ' ') 
    {
    // if space is not pressed and making shooting true
    // shooting is defined false in play.fire with each individual shot
    space = false;
    play.shooting = true;
    
    }
}