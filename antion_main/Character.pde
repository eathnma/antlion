class Chara {
  PVector pos, vel;
  float damp = 0.85;

  // all characters are circles
  int diam;
  float xpos, ypos, health, xspeed, yspeed;
  
  // health for each of the characters

  Chara(int diam , PVector pos, PVector vel) {
    this.diam = diam;
    this.pos = pos;
    this.vel = vel;
    //health = 3;
    //healthDecrease = 1;
  }

  void update() {  
    drawCharacter();
    // user controls square movement
    moveCharacter();
  }

  // moving
  void moveCharacter() {
    pos.add(vel);
    vel.mult(damp);
  }

  void drawCharacter() {
    // EMPTY
  }

  void accelerate(PVector acc) { 
    // this happens when bumping occurs
    vel.add(acc);
  }

  boolean hitCharacter(Chara c){
    return abs(c.pos.x-pos.x) < diam/2 + c.diam/2 && abs( c.pos.y - pos.y ) < diam/2 + c.diam/2;
    }
}
