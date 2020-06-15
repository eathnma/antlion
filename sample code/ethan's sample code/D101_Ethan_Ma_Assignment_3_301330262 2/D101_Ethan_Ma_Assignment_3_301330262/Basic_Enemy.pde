class Basic_Enemy extends Chara
{
  int diam = 30;
  boolean hityes;
  boolean startAnimation;
  boolean hitagain;
  boolean reset;
  int health;
  
  int deathTimer = 60;
  
  ArrayList <Projectile> projectAL = new ArrayList <Projectile>();
 
  Basic_Enemy( float w, float h, PVector pos, PVector vel )
  {
   super( w, h, pos, vel );
   diam = 20;
   damp = 1;
   health = 3;
   healthDecrease = 1;
   deathTimer = 60;
  }

void update()
{
  super.update();
  move();
  drawMe();
  detect();
  if (pos.y > 504) 
    {
      play.playerHealth = play.playerHealth - 1;
      enemyCount--;
      basicAL.remove(this);
    }
  if(hityes)
  { 
    health -= play.shotdamage;
    hityes = false;
    }
  if(startAnimation)
        {
          deathTimer--;
          death();
          vel.x = vel.y = 0;
        } else { 
          drawMe();
        }
   if (deathTimer <= 1 && health <= 0)
   {
   basicAL.remove(this);
   enemyCount--;
   score = score + 1;
   startAnimation = false;
   reset = true;
   }
   if(reset)
   {
     health = 3;
     deathTimer = 60;
     reset = false;
   }
}

void detect()
{
  // if the player and the enemy hit, then the player bounces off the enemy 
  if( play.hitCharacter(this)){  
  play.playerHealth = play.playerHealth - 0.05;
  float angleBetween = atan2(play.pos.y - pos.y, play.pos.x - pos.x);
  
  PVector f=PVector.fromAngle(angleBetween);
  
  f.mult(10);
  
  play.accelerate(f);
  
  
  }
}

void move()
{
  pos.add(vel);
}
  
void death()
{
  pushMatrix();
  translate( pos.x, pos.y );
  if(deathTimer %2 == 0 && health <= 0)
  {
    fill(random(0,255), random(0,255), random(0,255));
    scale( deathTimer / 10);
  }
  ellipse( 0, 0, diam, diam );
  popMatrix();
}

void hit()
{ // when the bullet hits the enemy, then remove it from the arraylist

  
}

void drawMe()
{// the enemy
  pushMatrix();
  translate( pos.x, pos.y );
  ellipse( 0, 0, diam, diam );
  popMatrix();
}

void decreaseHealth()
{
  // i used a different method to achieve this
}

}