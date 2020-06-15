class Chara
{
  PVector pos, vel;
  float damp = 0.85;
  
  int diam;
  int hit;
  int healthDecrease;
  
  int shotdamage;
  int deathTimer;
  
  float xpos;
  float ypos;
  float health;
  float w;
  float h;
  float xspeed;
  float yspeed;
  
  Chara(float w, float h, PVector pos, PVector vel )
  {
  this.w = w;
  this.h = h;
  this.pos = pos;
  this.vel = vel;
  health = 3;
  healthDecrease = 1;
  }
  
void update()
{
  moveCharacter();
  checkWalls();
}
  
void moveCharacter()
{
  pos.add(vel);
  vel.mult(damp);
}
  
void accelerate(PVector acc)
{ // this happens when bumping occurs
  vel.add(acc);
}

void drawCharacter()
{
  ellipse(0,0,0,0);
  // this should not matter
}

void checkWalls()
{
  if ( pos.x < 0 - w )
  {
    pos.x = 400;
  }
  if ( pos.x > 400 )
  {
    pos.x = 0;
  }
}

boolean hitCharacter(Basic_Enemy be)
  {
  return abs( be.pos.x-pos.x) < w/2 + be.diam/2 && abs( be.pos.y - pos.y ) < h/2 + be.diam/2;
  }


}