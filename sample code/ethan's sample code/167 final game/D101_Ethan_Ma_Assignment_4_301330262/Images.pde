final int LAMPOFF = 0;
final int LAMPDIM = 1;
final int LAMPON = 2;

class Image 
{  // level one
  int lampstate;
  int lampTimer;

  int fishstate;
  // level two
  
  // anything animated
  int index = 0;
  int foodindex = 0;
  int beeindex = 0;
  int beeBURNindex = 0;
  int exindex = 0;
  int ericFishindex = 0;
  int arrowindex = 0;
  
  PImage[] fishMove = new PImage[3];
  PImage[] fishFoodMove = new PImage[3];
  PImage[] beeMove = new PImage[2];
  PImage[] beeBURN = new PImage[2];
  PImage[] fireExtinguisher = new PImage[3];
  PImage[] ericFish = new PImage[3];
  PImage[] arrowAnimation = new PImage[7];
  PImage[] beginning = new PImage[20];
  
  Image()
  {
    // level 1
    // for the fish
    for( int i = 0; i< fishMove.length; i++)
    {
      fishMove[i] = loadImage("fish" + i + ".png");
    }
    // for the fishfood
        for( int i = 0; i< fishFoodMove.length; i++)
    {
      fishFoodMove[i] = loadImage("fishfood" + i + ".png");
    }
    
    //level 2
    // for the beeee
    for( int i = 0; i< beeMove.length; i++)
    {
      beeMove[i] = loadImage("bee" + i + ".png");
    }
    
    for( int i = 0; i< beeBURN.length; i++)
    {
      beeBURN[i] = loadImage("firebee" + i + ".png");
    }
    
    for( int i = 0; i< fireExtinguisher.length; i++)
    {
      fireExtinguisher[i] = loadImage("out" + i + ".png");
    }
    
    // level 3 for ericfish
    for( int i = 0; i< ericFish.length; i++)
    {
      ericFish[i] = loadImage("jesus" + i + ".png");
    }
    // for arrow
    for( int i = 0; i< arrowAnimation.length; i++)
    {
      arrowAnimation[i] = loadImage("b" + i + ".png");
    }
  }

  void lvone()
  { 
    // the lamp state
    pushMatrix();
    translate( c.picx, c.picy );
    imageMode(CENTER);
    switch(lampstate) {
    case 0:
      image( lamps[lampstate], 620, 45, 200, 200); 
      break;

    case 1:
      image( lamps[lampstate], 620, 45, 200, 200);
      break;

    case 2:
      image( lamps[lampstate], 610, 180, 470, 470);
      break;
    }
    popMatrix();
    
    // fish framecount for level one
    if( frameCount % 6 == 0)
    {
      index++;
      if( index == fishMove.length)
      {
        index = 0;
      }
    }
    // fish food framecount for level one 
    if( frameCount % 10 == 0)
    {
      foodindex++;
      if ( foodindex == fishFoodMove.length)
      {
        foodindex = 0;
      }
    }
    
    mouseClicked( mouseX, mouseY );
    if ( lampTimer > 0 )
    {
      lampTimer--;
    }
  }
  
  void lvtwo()
  {
    // for the beeeeeeeee
     if( frameCount % 6 == 0)
    {
      beeindex++;
      if( beeindex == beeMove.length)
      {
        beeindex = 0;
      }
    }
    // SUPA HOT
    if( frameCount % 6 == 0)
    {
      beeBURNindex++;
      if( beeBURNindex == beeBURN.length)
      {
        beeBURNindex = 0;
      }
    }
    // for the extin
     if( frameCount % 6 == 0)
    {
      exindex++;
      if( exindex == fireExtinguisher.length)
      {
        exindex = 0;
      }
    }
  }
  
  void lvthree()
  {
    if( frameCount % 5 == 0)
    {
      ericFishindex++;
      if( ericFishindex == ericFish.length)
      {
        ericFishindex = 0;
      }
    }
    if( frameCount % 15 == 0)
    {
      arrowindex++;
      if( arrowindex == arrowAnimation.length)
      {
        arrowindex = 0;
      }
    }
  }
  
  void mouseClicked( float x, float y )
  {
    if (mousePressed) {
      if (x >= 303 && x <= 340 && y >= 140 && y <= 193 && lampstate == LAMPOFF) 
      {
        lampstate = LAMPDIM;
      }

      if (x >= 303 && x <= 340 && y >= 140 && y <= 193 && lampTimer == 1 && lampstate == LAMPDIM)
      {
        lampstate = LAMPOFF;
      }
    }
  }
}