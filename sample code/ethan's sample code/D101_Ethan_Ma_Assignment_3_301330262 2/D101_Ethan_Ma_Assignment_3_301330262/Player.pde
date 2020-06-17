class Player extends Chara
{
  float roundness = 30;
  
  // boolean for the bullet fired
  boolean shooting;
  // boolean for the reload time called in play.fire()
  boolean reload; 
  
  float playerHealth;
  
  ArrayList <Projectile> projectAL = new ArrayList <Projectile>();
  
  
  Player(float w, float h, PVector pos, PVector vel )
  {
    super( w, h, pos, vel );
    pos = new PVector ( xpos, ypos );
    vel = new PVector ( xspeed, yspeed ); 
    playerHealth = 8;
  }
  
void update()
{
  super.update(); // this calls the move function
  drawCharacter(); // unique
  reload(); // unique
  smallBalls(); // unique
  projectile(); // used to shoot everything
  checkProjectile();
  // this is to call the projectile
}
void checkProjectile()
{
  for (int i = 0; i < projectAL.size(); i++ )
  {
    Projectile p = projectAL.get(i);
    p.update();
    // to remove if going over a certain threshold
    if (pos.y > 504) 
    {
      projectAL.remove(i);
      enemyCount--;
    }
    // this is to call the enemies to register the hit detection
    for (int j = 0; j < basicAL.size(); j++)
    {
      Basic_Enemy be = basicAL.get(j);
      if( p.collision(be))
      {
        p.hit(projectAL);
        be.hityes = true;
        if(be.health <= 0)
        {
        be.startAnimation = true;
        }
        be.hit(); // calling the hit method
      }
    }
  }
  
  if( fullCharge == 0 )
    {
      fullCharge = 0;
    }
}

void fire()
{
  //different sizes for the rectangles
  if( fullCharge < 90 && fullCharge > 75 )
    {
    projectAL.add( new Projectile( pos.copy(), new PVector( 0, -10), 10, 10, 0 ) );
    shotdamage = 1;
    }
    else if( fullCharge < 75 && fullCharge > 60  )
    {
    projectAL.add( new Projectile( pos.copy(), new PVector( 0, -15), 15, 15, 2 ) );
    shotdamage = 2;
    }
    else if ( fullCharge < 60 && fullCharge > 45  )
    {
    projectAL.add( new Projectile( pos.copy(), new PVector( 0, -20), 20, 20, 4 ) );
    shotdamage = 3;
    }
    else if ( fullCharge < 45 && fullCharge > 30 )
    {
    projectAL.add( new Projectile( pos.copy(), new PVector( 0, -25), 25, 25, 6 ) );
    shotdamage = 4;
    }
    else if ( fullCharge < 30 && fullCharge > 15 )
    {
    projectAL.add( new Projectile( pos.copy(), new PVector( 0, -30), 30, 30, 8 ) );
    shotdamage = 5;
    }
    else if ( fullCharge < 15 )
    {
    projectAL.add( new Projectile( pos.copy(), new PVector( 0, -35), 40, 40, 15 ) );
    shotdamage =  6;
    }
    
    reload = true;
    shooting = false;
}

void reload()
{
  if( reload )
  {
    fullCharge++;
    if( fullCharge >= 90)
    {
      reload = false;
    }
  }
}

void drawCharacter()
{
  float my = constrain(pos.y, 0, 569 );
  //the square in the middle
  pushMatrix();
  fill( 230, 126, 34 );
  noStroke();
  translate( pos.x, my );// this one my );
  // body
  rect( 0, 0, w, h, 160 );
  popMatrix();
}

void smallBalls(){
  // makes the countdown timer
  // draws the small balls onto the character
  float my = constrain(pos.y, 0, 569 );
  pushMatrix();
  fill(255);
  translate( pos.x, my );
  
  if( fullCharge < 90 )
  {
  rect( -15, 0, 10, 10, roundness );
  }
  if( fullCharge < 75 )
  {
  rect( 45, 0, 10, 10, roundness );
  }
  if ( fullCharge < 60 )
  {
  rect( -15, 15, 10, 10, roundness );
  }
  if ( fullCharge < 45 )
  {
  rect( 45, 15, 10, 10, roundness );  
  }
  if (fullCharge < 30 )
  { 
  rect( -15, 30, 10, 10, roundness );
  }
  if (fullCharge < 15 )
  {
  rect( 45, 30, 10, 10, roundness );
  }
  popMatrix();
}

void projectile()
{
  // if keyreleased, shooting is true, and bullets fire
  if ( space == false && shooting ) 
  {
    if( shooting )
    {
      play.fire();
    }
    // calls it so even if they hold it for a long time, it won't go under 3 seconds of reload time
    if( fullCharge < 0 )
    {
      fullCharge = 1;
    }
  }
  if ( space == true )
  {
    fullCharge--;
  }
}

void no(Basic_Enemy bs)
{
  rect(bs.pos.x, bs.pos.y, w, h );
}
boolean checkProjectiles(Basic_Enemy be)
  {
  return abs( be.pos.x-pos.x) < w/2 + be.diam/2 && abs( be.pos.y - pos.y ) < h/2 + be.diam/2;
  }
//boolean hitCharacter(Basic_Enemy be)
//  {
//  return abs( be.pos.x-pos.x) < w/2 + be.diam/2 && abs( be.pos.y - pos.y ) < h/2 + be.diam/2;
//  }
  
//boolean checkProjectiles( Basic_Enemy be)
//  {
//    return abs( pos.x - be.pos.x) < w/2 + be.diam && abs ( be.pos.y - pos.y) < h/2 + be.diam;
//  }
}