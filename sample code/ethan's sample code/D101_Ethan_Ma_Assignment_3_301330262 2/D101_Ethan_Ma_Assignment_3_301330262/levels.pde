int enemyCount = 4;

int roundCount = 300;
int aniTimer = 60;

boolean wave1;
boolean wave2;
boolean wave3;

void rounds()
{
  if (enemyCount == 4 && wave1 == false)
  {
    wave1 = true;
    for ( int i = 0; i < 4; i++ )
    {
      basicAL.add( new Basic_Enemy( 0, 0, new PVector (random(0, 400), random(-200, 0)), new PVector (0, 0.5) ) );
    }
  } else if
    ( enemyCount <= 0 && wave1 == true)
  {
    roundCount--;
    if ( roundCount == 0 && wave1)
    {
      enemyCount = 6;
      wave1 = false;
    }
  }
  
  if (wave2 == false && enemyCount == 6)
  {
    wave2 = true;
    roundCount = 300;
  }

  if (wave2)
  {
   //if(basicAL.size() <= 6) { 
    for ( int i = 0; i < enemyCount; i++ )
    {
      basicAL.add( new Basic_Enemy( 0, 0, new PVector (random(0, 400), random(-200, 0)), new PVector (0, 0.5) ) );
    }
    enemyCount = 0;
    wave2 = false;
  }
  if ( enemyCount <= 0 && wave2 == false && wave1 == false )
  {
    wave3 = true;
  }
  
  if(wave3)
  {
    enemyCount = 100;
    basicAL.add (new Boss_Enemy( 0, 0, new PVector(random(100,350),0), new PVector(0,0.1)) );
    wave3 = false;
  }
  
  if((basicAL.size() == 0 && wave3 == false && wave2 == false && wave1 == false)|| play.playerHealth <= 0)
  {
    aniTimer--;
  }
  if(aniTimer <= 0)
  {
    screen = 2;
  }
  
  if( roundCount < 300)
  {
    text("the boss is coming", width/2-100, height/2);
  }
}