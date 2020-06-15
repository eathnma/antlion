void puteverythingyoudontwantinhere()
{
  float widthHealth = map(play.playerHealth, 0, 8, 0, 400);
  pushMatrix();
  fill( 192, 57, 43, 200 );
  rect( 0, 504, widthHealth, 100 );
  popMatrix();
  
}

void starting()
{
  fill(0);
  rect( 0, 0, 400, 600 );
  textMode(CENTER);
  fill(255);
  stroke(255);
  textSize(20);
  text("PRESS ANY KEY TO START", width/2 - 120, height/2);
  if(keyPressed)
  {
    screen = 1;
  }
}

void gameover()
{
  text("GAME OVER", width/2 - 70, height/2);
}