//ArrayList <Basic_Enemy> basicAL = new ArrayList < Basic_Enemy>();

Player play;

boolean up3, down3, left3, right3, space;
PVector upForce = new PVector (0, -2);
PVector downForce = new PVector (0, 2);
PVector leftForce = new PVector (-2, 0);
PVector rightForce = new PVector (2, 0);

void setupMiniGame3() {
  play = new Player(40, 40, new PVector(179, 541), new PVector(0, 0));
}

void drawMiniGame3() {
  play.update();

  // movement options
  if (up3) play.accelerate(upForce);
  if (down3) play.accelerate(downForce);
  if (left3) play.accelerate(leftForce);
  if (right3) play.accelerate(rightForce);
}


class Projectile {
  PVector pos, vel;
  float xspeed, yspeed, w, h, small;

  Projectile ( PVector pos, PVector vel, float w, float h, float small) {
    this.pos = pos;
    this.vel = vel;
    this.w = w;
    this.h = h;
    this.small = small;
  }

  //boolean collision(Basic_Enemy be)
  //{
  //  return abs( pos.x - be.pos.x) < w/2 + be.diam && abs ( be.pos.y - pos.y) < h/2 + be.diam;
  //}

  void drawbullet()
  {   
    pushMatrix();
    fill(255);
    translate( pos.x - small + 15, pos.y );
    rect( 0, 0, w, h );
    popMatrix();
  }

  void hit(ArrayList list) {
    list.remove(this);
  }
  
  boolean hit(Chara c)
  {
    return abs( pos.x -c.pos.x) < w/2 + c.diam && abs (c.pos.y - pos.y) < h/2 + c.diam;
  }
  
}
