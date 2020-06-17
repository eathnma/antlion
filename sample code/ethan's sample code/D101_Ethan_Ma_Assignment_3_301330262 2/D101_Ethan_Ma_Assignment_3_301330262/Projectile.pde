class Projectile
{
  PVector pos, vel;
  float xspeed;
  float yspeed;
  float w;
  float h;
  float small;
  
  boolean hit = false;
  
  Projectile ( PVector pos, PVector vel, float w, float h, float small )
  {
  this.pos = pos;
  this.vel = vel;
  this.w = w;
  this.h = h;
  this.small = small;
  }
  // for bad
  boolean collision( Basic_Enemy be)
  {
    return abs( pos.x - be.pos.x) < w/2 + be.diam && abs ( be.pos.y - pos.y) < h/2 + be.diam;
  }
  // for good
  boolean collision( Player play)
  {
    return abs( pos.x - play.pos.x) < w/2 + play.w && abs ( play.pos.y - pos.y) < h/2 + play.h;
  }

void update()
{ // should be calling move, draw and checkWalls methods
// projectiles that go out of the screen should be removed from arraylist
pos.add(vel); // DO NOT REMOVE THIS? IDK
drawbullet();
checkWalls();
println(play.projectAL.size());


}
void move()
{
 pos.add(vel);
}

void drawbullet()
{   pushMatrix();
    fill(255);
    translate( pos.x - small + 15,pos.y );
    rect( 0, 0, w, h );
    popMatrix();
}


void hit(ArrayList list) 
{// this is removed in player
 list.remove(this);
}

void checkWalls()
{
  if( pos.y < 0 )
  {
    play.projectAL.remove(this);
  }
}
boolean hit( Chara c)
  {
    return abs( pos.x -c.pos.x) < w/2 + c.diam && abs (c.pos.y - pos.y) < h/2 + c.diam;
  }
  
}