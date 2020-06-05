class Common
{
  boolean shake;
  int shaketimer;
  float shakex;
  float shakey;

  float bannerd = 600;
  float bannerx = width/2;
  float bannery = height-350;

  float picx;
  float picy;
  float picxtwo;
  //target for easing to the left
  float targetX =-802; // 402 because there is a bit of overlap
  float targetXtwo = 0;
  //target for easing to the right
  float twotargetX = 0;
  float twotargetXtwo = 802;

  float targetblack = 0;

  float easing = 0.1;

  int inventory;

  boolean slideScreen;
  boolean screenone = true;
  boolean screentwo;

  // the scaling for the banner objects
  float ogscale = 0;
  float targetScale = 1;
  float targetScaleback = 0;

  // for the sliding black screen
  float transparency;
  boolean fade;
  int fadeTimer;
  // for the white screen
  boolean whitescreenout;
  float transparencywhite = 255;

  boolean screentimer;
  boolean cook1 = true;

  boolean sentfromlevelone;
  boolean sentfromleveltwo;
  boolean sentfromlevelthree;
  
  boolean sound;
  boolean yosound = true;

  Common( float picx, float picy, float picxtwo )
  {
    this.picx = picx;
    this.picy = picy;
    this.picxtwo = picxtwo;
    fadeTimer = 30;
  }
  void sound()
  {
    if ( sound )
    {
      /// YOOOOOOOOO
      if (yosound)
      {
        cook.pause(); // pause the cook music
        YO.play();
        yosound = false;
      }
    }
  }

  void update()
  {
    changeScreen();
    arrow();
  }

  void circles() // placeholders for items
  {
    fill(0);
    rect( 0, 500, 800, 100);
    fill(255);
    ellipse( 100, 550, 20, 20 );
    ellipse( 300, 550, 20, 20 );
    ellipse( 500, 550, 20, 20 );
    ellipse( 700, 550, 20, 20 );
  }

  void changeScreen() // changes the screen
  {
    if ( mousePressed )
    {
      if ( lt3.specialcase == false )
      {
        if (mouseX > 728 && mouseX < 783 && mouseY > 20 && mouseY < 71 && screenone && lt3.noMove == false ) // scrolling screen going to the left
        {
          slideScreen = true;   // sets the movement of the screen
        }
      }

      if ( mouseX > 30 && mouseX < 70 && mouseY > 40 && mouseY < 120 && screentwo ) //scrollilng screen going to the right
      {
        slideScreen = true;  // sets the movement of the screen
      }
    }

    if ( slideScreen )
    {
      if ( screenone ) {  //move the images to the left
        //image one  
        float dx = targetX - picx;
        picx += dx * easing;

        //image two
        float dxtwo = targetXtwo - picxtwo;
        picxtwo += dxtwo * easing;
      }
      if ( screentwo )   //moves all images to the right
      {
        float dx = twotargetX - picx;
        picx += dx * easing;

        //image two
        float dxtwo = twotargetXtwo - picxtwo;
        picxtwo += dxtwo * easing;
      }

      if ( picx <= -800 ) // og -800
      {
        slideScreen = false; // sets the moving state
        screenone = false; // sets the screen state
        screentwo = true;
      }
      if ( picx >= -1 )
      {
        slideScreen = false;
        screenone = true;
        screentwo = false;
      }
    }
  }
  void arrow()  // arrows for switching the screen
  {
    // arrow pointing to the right
    pushMatrix();
    translate( picx, picy );
    image( arrow, 754, 50, 70, 70);
    popMatrix();

    // arrow pointing to the left
    pushMatrix();
    translate( picxtwo, picy );
    scale(-1, 1);
    image( arrow, -40, 50, 70, 70);
    popMatrix();
  }
  
  void pasteImage()//
  {
    // the first rectangle on the left
    pushMatrix();
    translate( picx, picy );
    noStroke();
    fill(52, 152, 219);
    rect( 0, 0, 800, 500 );

    stroke(0);
    strokeWeight(2);
    line( 0, 300, 800, 300 );
    popMatrix();

    // the second rectangle on the right
    pushMatrix();
    translate( picxtwo, picy );
    noStroke();
    fill(52, 152, 219);
    rect( 0, 0, 800, 500);

    stroke(0);
    strokeWeight(2);
    line( 0, 300, 350, 300 );
    line( 350, 300, 800, 500 );
    popMatrix();
  }
 
}