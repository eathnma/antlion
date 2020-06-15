class Player extends Chara {

  Player(float w, float h, PVector pos, PVector vel) {
    super(w, h, pos, vel);
    pos = new PVector ( xpos, ypos );
    vel = new PVector ( xspeed, yspeed );
    //playerHealth = 8;
  }

  void drawCharacter() {
    // add antony here...
    float my = constrain(pos.y, 0, 569);
    //the square in the middle
    pushMatrix();
    fill( 230, 126, 34 );
    noStroke();
    translate( pos.x, my );
    // body
    rect( 0, 0, w, h, 160 );
    popMatrix();
  }

  void update() {
    super.update();
    drawCharacter();
  }
}


class Antilla extends Chara{
  
  Antilla( float w, float h, PVector pos, PVector vel){
    super( w, h, pos, vel );
  }
  
  void update(){
    
  }
}


class Chara {
  PVector pos, vel;
  float damp = 0.85;

  int diam;
  float xpos, ypos, health, w, h, xspeed, yspeed;

  Chara(float w, float h, PVector pos, PVector vel) {
    this.w = w;
    this.h = h;
    this.pos = pos;
    this.vel = vel;
    //health = 3;
    //healthDecrease = 1;
  }

  // updating super function for all characters
  void update() {
    moveCharacter();
  }

  // moving
  void moveCharacter() {
    pos.add(vel);
    vel.mult(damp);
  }

  void accelerate(PVector acc) { 
    // this happens when bumping occurs
    vel.add(acc);
  }

  void checkWalls()
  {
    if ( pos.x < 0 - w )
    {
      pos.x = width;
    }
    if ( pos.x > width )
    {
      pos.x = 0;
    }
  }

  //boolean hitCharacter(Basic_Enemy be){
  //  return abs( be.pos.x-pos.x) < w/2 + be.diam/2 && abs( be.pos.y - pos.y ) < h/2 + be.diam/2;
  //  }
}
