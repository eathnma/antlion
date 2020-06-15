class Boss_Enemy extends Basic_Enemy
{
  float Timer;
  boolean bossprojectile;
  
  float projectileTimer;
 
  Boss_Enemy( float w, float h, PVector pos, PVector vel)
  {
    super( w, h, pos, vel );
    diam = 100;
    health = 60;
    Timer = 30;
    projectileTimer = 10;
  }
  
void update()
{
  super.update();
  smallenemies();
  checkProjectiles(play);
  
  //println(enemyCount);
}
  
// needs to appear captured or dead for 1 seconds  
void death()
{
  pushMatrix();
  translate( pos.x, pos.y );
  if(Timer %2 == 0 && health <= 0)
  {
    fill(random(0,255), random(0,255), random(0,255));
    scale( deathTimer / 20);
  }
  ellipse( 0, 0, diam, diam );
  popMatrix();

}
// override from player class  
void smallenemies()
{
 if(pos.y > 45 && projectileTimer <= 10)
 {
  projectileTimer--;
  if(bossprojectile)
  {
  vel.y = 0;
  projectAL.add( new Projectile( new PVector( pos.x - 20, pos.y), new PVector( random(-6,6), 10), 10, 10, 0 ) );
  bossprojectile = false;
  }
 }
  for (int i = 0; i < projectAL.size(); i++ )
  {
    Projectile p = projectAL.get(i);
    p.update();
    
    if( p.collision(play))
    {
      play.playerHealth = play.playerHealth - 0.05;
    }
  }
  if(projectileTimer <= 0)
  {
    bossprojectile = true;
    projectileTimer = 10;
  }
}
void drawMe()
{
  pushMatrix();
  translate( pos.x, pos.y );
  ellipse( 0, 0, diam, diam );
  popMatrix();
}
boolean checkProjectiles( Player p)
  {
    return abs( pos.x -p.pos.x) < w/2 + p.diam && abs (p.pos.y - pos.y) < h/2 + p.diam;
  }

}