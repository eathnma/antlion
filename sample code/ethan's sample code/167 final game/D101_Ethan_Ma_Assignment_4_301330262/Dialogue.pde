class Dialogue 
{
  float ericjunweix;
  float ericjunweiy;
  float ethanx;
  float ethany;

  float targetScale = 1;
  float targetRotate = 0;
  float ogScale = 0.1;
  float ogRotate = PI;
  float easing = 0.1;
  boolean melodyon = true;

  boolean blackscreenin;
  boolean blackscreenout;

  boolean whitescreenin;
  boolean whitescreenout;

  int transparency;
  float transparencywhite = 0;

  int bbswitch;
  int beganindex = 0;
  int endendindex = 0;
  PImage[] beginningA = new PImage[13];
  PImage[] beganA = new PImage[10];
  PImage[] endA = new PImage[8];
  PImage[] endendA = new PImage[3];
  //levels
  PImage[] leveloneA = new PImage[18];
  PImage[] leveltwoA = new PImage[16];
  PImage[] levelthreeA = new PImage[24];

  boolean beginningcom;
  boolean begancom;
  boolean dialogueend1;

  boolean beginimage = true;
  boolean firstinstance;
  boolean secondinstance;
  boolean one;
  boolean one_five;

  boolean countdeath = true;

  boolean horrorsound;

  boolean ending;
  boolean finale;
  boolean finalSound;

  Dialogue( )
  {
    // beginning..
    for ( int i = 0; i< beginningA.length; i++)
    {
      beginningA[i] = loadImage("begin" + i + ".png");
    }
    // for began
    for ( int i = 0; i< beganA.length; i++)
    {
      beganA[i] = loadImage("began" + i + ".png");
    }
    // levels
    for ( int i = 0; i< leveloneA.length; i++)
    {
      leveloneA[i] = loadImage("levelone" + i + ".png");
    }

    for ( int i = 0; i< leveltwoA.length; i++)
    {
      leveltwoA[i] = loadImage("leveltwo" + i + ".png");
    }

    for ( int i = 0; i< levelthreeA.length; i++)
    {
      levelthreeA[i] = loadImage("levelthree" + i + ".png");
    }

    // ENDING
    for ( int i = 0; i< endA.length; i++)
    {
      endA[i] = loadImage("end" + i + ".png");
    }

    for ( int i = 0; i< endendA.length; i++)
    {
      endendA[i] = loadImage("endend" + i + ".png");
    }

    ericjunweix = 370;
    ericjunweiy = 350;
  }
  void titlescreen()
  {
    image( titlepage, width/2-1, height/2, 800, 600 );
    if ( mousePressed && mouseX > 313 && mouseX < 520 && mouseY > 497 && mouseY < 552 )
    {
      blackscreenin = true;
      one = true;
    }
  }
  void beginning()
  {
    if ( beginningcom )
    {
      if (count >= 13)
      {
        beginningcom = false;
        blackscreenin = true;
        one_five = true;
      }
      if (count < 13) { 
        PImage img = beginningA[count];
        image(img, width/2, height/2 );
      } else 
      image( main1, width/2, height/2 );
      if ( count <= 2 ) image( instruct, 150, 509, 300, 210 );
    }  

    if ( begancom )
    {
      if ( count >= 10)
      {
        blackscreenin = true;
        dialogueend1 = true;
        begancom = false;
      }
      if ( count < 10)
      {
        PImage img = beganA[count];
        image(img, width/2, height/2 );
      }
    }

    if (melodyon) 
    {
      melody.play();
      melodyon = false;
    }
  }
  void lvone()
  { 
    if ( horrorsound )
    {
      evilman.play();
      horrorsound = false;
    }

    image( lvoneend, width/2, height/2 );

    if ( count < 18 )
    {
      PImage img = leveloneA[count];
      image(img, width/2, height/2 );
    }
    if ( count >= 18 )
    {
      blackscreenin = true;
      firstinstance = true;  // sets the level and gameplay state
    }
  }
  void lvtwo()
  {
    if ( horrorsound )
    {
      evilman.rewind();
      evilman.play();
      horrorsound = false;
    }
    if ( count < 16 )
    {
      PImage img = leveltwoA[count];
      image(img, width/2, height/2 );
    }
    if ( count >= 16 )
    {
      blackscreenin = true;
      secondinstance = true;  // sets the level and gameplay state
    }
  }

  void lvthree()
  {
    if ( horrorsound )
    {
      evilman.rewind();
      evilman.play();
      horrorsound = false;
    }
    if ( count < 24 )
    {
      PImage img = levelthreeA[count];
      image(img, width/2, height/2 );
    }
    if ( count >= 24 )
    {
      finale = true;
      println("ping");
      blackscreenin = true;
    }
    if ( count >= 24 ) // sound triggers everything
    {
      scarybee.rewind();
      scarybee.play();
      horrorsound = false;
    }
    if( count == 24 ) count = 24;
    if ( finale == true ) image( goodbye, width/2, height/2 );
  }
void death( float x, float y)
{ 
  println(transparencywhite);
  if ( countdeath ) // reset the count && reset the white background
  {
    count = 0;
    whitescreenout = true;
    countdeath = false;
  }

  if ( count < 8 )
  {
    PImage img = endA[count];
    image(img, width/2, height/2 );
  } else 
  if ( count >= 8 )
  {
    if ( frameCount % 15 == 0)
    {
      endendindex++;
      if ( endendindex == endendA.length)
      {
        endendindex = 0;
      }
    }
    PImage img = endendA[endendindex];
    image(img, width/2, height/2 );
    if ( mousePressed && x > 136 && x < 385 && y > 460 && y < 589) // reset the levels here
    {
      herewego.play();
      whitescreenin = true;
      if (c.sentfromlevelone) level = 0;
      if (c.sentfromleveltwo) level = 1;
      if (c.sentfromlevelthree) level = 2;
    }
    if ( mousePressed && x > 457 && x < 683 && y > 460 && y < 589 ) exit();
  }

  if ( whitescreenin )  // whitescreenout
  {
    if ( transparencywhite < 255 )
    {
      transparencywhite = transparencywhite + 0.5;
    } else if
      ( transparencywhite >= 255 )
    {
      herewego.pause(); // pause the heaven noises
      dialogue = false;
      game = true;
      whitescreenin = false;
      c.whitescreenout = true;
      setup();
    }
    fill( 255, transparencywhite );
    rect( 0, 0, width, height );
  }
}
void blackscreen()
{
  if ( blackscreenin )
  {
    if ( transparency < 255 ) // nothing to black
    {
      transparency = transparency + 2;
    } else if
      ( transparency >= 255 )
    {
      if ( finale )
      {
        ericsays = 6;
      }
      if (dialogueend1) // ending condition
      {
        game = true;
        level = 0;
        dialogue = false;
        melody.pause();
      }
      if (one)
      {        
        ericsays = 1;     // beginning commentary
        beginningcom = true;
        one = false;
      }
      if (one_five)
      {
        begancom = true;
        count = 0;
        one_five = false;
      }
      if (firstinstance)
      {
        game = true;
        level = 1;
        dialogue = false;
        evilman.pause();
      }
      if (secondinstance)
      {
        game = true;
        level = 2;
        dialogue = false;
        evilman.pause();
      }
      blackscreenout = true;
      blackscreenin = false;
    }// sets the transparency twice as fast
    fill( 0, transparency );
    rect( 0, 0, width, height );
  }

  if ( blackscreenout )
  {
    transparency = transparency - 1;
    if ( transparency == 0 )
    {
      blackscreenout = false;
    }// sets the transparency twice as fast
    fill( 0, transparency );
    rect( 0, 0, width, height );
  }

  if ( whitescreenout )
  {
    transparency = transparency - 1;
    if ( transparency == 0 )
    {
      whitescreenout = false;
    }// sets the transparency twice as fast
    fill( 255, transparency );
    rect( 0, 0, width, height );
  }
}
void theend()
{
    image( theend, width/2, height/2 );
  
}
}