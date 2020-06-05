class levelThree extends Common
{
  int wallholeswitch;
  int animationtimer;

  int window;
  int windowerictimer;
  boolean windoweric;
  int slidedoor;
  int ladderwait;

  int timerfordoor;
  boolean doortimer;
  boolean noMoreStool;
  boolean pushed;

  boolean ericappears;
  int ericappearstimer;

  boolean omgno;
  boolean omgnoboo;
  int omgnotimer;

  boolean right;
  boolean left;
  boolean bar;
  boolean open;

  boolean leftrect;
  boolean rightrect;

  boolean topbar;
  boolean topbarimage = true;
  boolean topbardragged;
  boolean topbarplaced;

  boolean cabinet;
  boolean noLadder;
  boolean stool; // can't change because too complicated
  boolean ladderpickedup;
  boolean ladderdragged;
  boolean ladderwin;
  boolean ladderlose;
  int ladderlosetimer;
  boolean straightladderdisplay;
  boolean crookedladderdisplay;

  boolean noMove;
  boolean specialcase;

  // EASING FOR THE LADDER BANNER
  boolean ladderbannerboo;
  boolean laddertimeron;
  boolean ladderbannerdisplay;

  float laddertimer = 80;

  float targetScaleoutladder = 0.1;
  float targetScaleladder = 1;
  float ogscaleladder = 0;

  // EASING FOR THE TOP BAR
  boolean topbarboo;
  boolean bartimeron;
  boolean barbannerdisplay;

  float bartimer = 80;
  float ogscalebar = 0;

  float targetScalebar = 1;
  float targetScalebarback = 0;
  //letter
  boolean Acomesout;
  boolean Acomesoutboo;
  int Acomesouttimer;

  boolean sound;

  levelThree( float picx, float picy, float picxtwo )
  {
    super(picx, picy, picxtwo);
    timerfordoor = 120;
    ericappearstimer = 30;
    windowerictimer = 30;
    omgnotimer = 30;
    ladderlosetimer = 25;
    animationtimer = 75;
    transparency = 1;
    easing = 0.08;
    Acomesouttimer = 30;
  }

  void sound()
  {
    if (sound)
    {
      cook.pause(); // pause the cook music
      YO.play();
      yosound = false;
    }
  }

  void update()
  {
    if (cook1)
    {
      cook.rewind();
      cook.play();
      cook1 = false;
    }
    sound();
    pasteImage();
    right( mouseX, mouseY );
    cabinet(mouseX, mouseY );
    wallhole( mouseX, mouseY );
    windows( mouseX, mouseY);
    letter();                     // the letter has to be under the arrow
    barAbove( mouseX, mouseY );   // the arrow animation is placed here
    super.update();
    yellowFish( mouseX, mouseY );
    slide( mouseX, mouseY );
    ladder( mouseX, mouseY );
    theease();
    ericShakes();
  }
  void windows( float x, float y )
  {
    pushMatrix();
    translate( picx, picy );
    switch(window)
    {
    case 0:
      image( curtain, 260, 180, 400, 400 );
      break;

    case 1:
      image( curtainright, 260, 180, 400, 400 );
      break;

    case 2:
      image( curtainleft, 260, 180, 400, 400 );
      break;

    case 3:
      image( curtainopen, 260, 180, 400, 400 );
      break;
    }
    popMatrix();
    // for the window on the right
    if ( mousePressed && screenone && open == false && x > 248 && x < 352 && y > 64 && y < 270 )
    {
      if ( left == false )
      {
        window = 1;
        right = true;
      } else 
      if ( left == true )
      {
        window = 3;
        open = true;
      }
    }
    // for the window on the left
    if ( mousePressed && screenone && open == false && x > 151 && x < 237 && y > 64 && y < 270 )
    {
      windoweric = true; // set the timer

      if ( right == false )
      {
        window = 2; // for the one with eric
        left = true;
      } else
        if ( right == true )
        {
          window = 3;  // for the one with eric
          open = true;
        }
    }
    if (windoweric) 
    {
      windowerictimer--;
      sound = true;
    }
    if (windowerictimer <= 0 ) shake = true;
  }
  void yellowFish( float x, float y )
  {
    pushMatrix();
    translate( picx, picy );
    image( greyfish, 550, 400, 400, 400 );
    popMatrix();

    if ( mousePressed && screenone && x > 459 && x < 583 && y > 404 && y < 451)
    {
      omgnoboo = true;
      sound = true;
    }
    if (omgnoboo)
    {
      omgnotimer--; 
      pushMatrix();
      translate( picx, picy);
      PImage img = i.ericFish[i.ericFishindex];
      image(img, 550, 400, 400, 400);
      popMatrix();
    }
    if (omgnotimer <= 0 ) omgno = true;
    if (omgno) shake = true;
  }

  void slide( float x, float y )
  {
    pushMatrix();
    translate( picxtwo, picy );
    switch(slidedoor)
    {
    case 0:
      image( slidingdoor, 325, 225, 1000, 1000 );
      break;

    case 1:
      image( slidingdooropen, 325, 225, 1000, 1000 );
      break;

    case 2:
      image( slidingdoorempty, 325, 225, 1000, 1000 );
      break;

    case 3:
      image( ericslidingdoor, 325, 225, 1000, 1000 );
      break;
    }
    popMatrix();
    if ( mousePressed && screentwo && x > 388 && x < 501 && y > 124 && y < 332 ) // for the door
    {
      if (noMoreStool == false)
      {
        slidedoor = 1;
        doortimer = true;
      } 
      if ( pushed ) ericappears = true;
    }
    if (ericappears) 
    {
      slidedoor = 3;
      sound = true;
      ericappearstimer--;
      if ( ericappearstimer <= 0 ) shake = true;
    }
    // properties for the screendoor
    if ( doortimer ) timerfordoor--;
    if ( timerfordoor <= 0 )
    {
      slidedoor = 0;
      pushed = true;
      doortimer = false;
      timerfordoor = 120;
    }
    if ( mousePressed && screentwo && x > 389 && x < 436 && y > 226 && y < 312 ) // for the ladder hitdetection
    {
      slidedoor = 2;
      // PLACE HERE
      ladderbannerboo = true;
      ladderbannerdisplay = true;
      laddertimeron = true;
      ladderpickedup = true;
      noMoreStool = true;
    }
  }
  void ladder( float x, float y )
  {
    if (ladderdragged)
    {
      if ( mousePressed && screenone && x > 708 && x < 775 && y > 128 && y < 384 ) 
      {
        straightladderdisplay = true;
        ladderdragged = false; // doesn't allow hit detection anymore
        ladderpickedup = false; // removes it from the inventory
        ladderwin = true; // sets the winning condition for the ladder
      }
      if ( mousePressed && screentwo && x > 554 && x < 737 && y > 187 && y < 471 )  // red herring
      {
        crookedladderdisplay = true;
        ladderdragged = false; // doesn't allow hit detection anymore
        ladderpickedup = false; // removes it from the inventory
        ladderlose = true;  // sets the losing condition for the ladder
      }
    }
    pushMatrix();
    translate( picx, picy );
    if (straightladderdisplay) 
    {
      image( straightladder, 720, 250, 500, 500 ); // ladder image
    }
    popMatrix();

    pushMatrix();
    translate( picxtwo, picy );
    if (crookedladderdisplay) image( wallladder, 600, 300, 500, 500 );
    popMatrix();
  }
  void wallhole( float x, float y )
  {
    pushMatrix();
    translate( picxtwo, picy );
    switch( wallholeswitch )
    {
    case 0:
      image( wallhole, 500, 225, 700, 700 ); 
      break;

    case 1:
      image( ericwallhole, 690, 178, 530, 530 ); 
      break;
    }
    popMatrix();

    if ( ladderlose ) 
    {
      sound = true;
      ladderlosetimer--;
      wallholeswitch = 1;
    }
    if ( ladderlosetimer <= 0 ) shake = true;
  }
  void right( float x, float y )
  {
    if (screentwo && mousePressed )
    {
      if ( x > 450 && x < 530 && y > 125 && y < 375 ) { 
        cabinet = true; 
        stool = true;
      } 
      // add if ladder grabbed and placed down!
    }
  }
  void cabinet(float x, float y) // comes from right
  {
    // if the cabinet shows the stool
    if ( screentwo && mousePressed && cabinet == true ) 
    {
      if ( noLadder == false && x > 470 && x < 510 && y > 310 && y < 350 ) ladderpickedup = true;
    }

    if ( ladderpickedup == true ) {
      fill(255);
      rect( 70, 510, 70, 70 );
      image( wallladder, 100, 550, 160, 160 );
      stool = false;
      noLadder = true;
    }
    if ( ladderpickedup && mousePressed && x > 79 && x < 116 && y > 525 && y < 563 ) ladderdragged = true; // hit detection for inventory ladder
    if ( ladderdragged ) image( wallladder, mouseX, mouseY, 260, 260 ); // on the cursor
  }
  void barAbove( float x, float y )
  {
    if ( mousePressed && screenone && x > 138 && x < 355 && y > 41 && y < 56 ) 
    {
      topbar = true; 
      topbarboo = true;
      bartimeron = true;
      barbannerdisplay = true;
    }// inital hit detection for the bar above

    if (topbar) { 
      pushMatrix();
      translate( picx, picy );
      noStroke();
      fill( 52, 152, 219 );
      rect( 132, 30, 230, 30 );
      popMatrix();

      image( bar1, 300, 550, 300, 200 ); // place in inventory
      topbarimage = false;
    }
    if (topbar && mousePressed && x > 222 && x < 375 && y > 529 && y < 560 ) topbardragged = true;

    if ( topbardragged && ladderwin ) image( bar1, mouseX, mouseY, 300, 200 ); // place image on mouse

    // ---------------------------------- WIN CONDITION ------------------------------------------
    if ( mousePressed && x > 723 && x < 773 && y > 34 && y < 57 && topbardragged && ladderwin ) 
    { 
      specialcase = true;
      topbarplaced = true;
      topbardragged = false;
      noMove = true;
      Acomesout = true;
      Acomesoutboo = true;
    }
    if ( topbarplaced ) 
    {
      animationtimer--;
      if (animationtimer > 0 )
      {
        pushMatrix();
        translate( picx, picy );
        PImage img = i.arrowAnimation[i.arrowindex];
        image(img, 720, 100, 240, 240);
        popMatrix();
      }
    }
  }
  void pasteImage()
  { 
    pushMatrix();
    translate( picx, picy );
    noStroke();
    fill(52, 152, 219);
    rect( 0, 0, 800, 500 );

    stroke(0);
    strokeWeight(2);
    line( 0, 300, 800, 300 );
    fill(255);
    noStroke();
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
  void arrow()  // arrows for switching the screen
  {
    // arrow pointing to the right
    if ( topbarplaced == false )
    {
      pushMatrix();
      translate( picx, picy );
      image( arrow, 754, 50, 70, 70);
      popMatrix();
    }

    // arrow pointing to the left
    pushMatrix();
    translate( picxtwo, picy );
    scale(-1, 1);
    image( arrow, -40, 50, 70, 70);
    popMatrix();
  }
  void theease()
  {
    pushMatrix();
    translate( bannerx, bannery );
    //---------------------------------- FOR THE LADDER BANNER-----------------------------------
    if (ladderbannerboo)
    {
      if (laddertimeron) laddertimer--;
      if ( laddertimer < 80 && laddertimer > 40)
      {
        float tg = targetScaleladder - ogscaleladder; // to ease when it comes up
        ogscaleladder += tg * easing;
      }
      if ( laddertimer < 40 )
      {
        float tg = targetScaleoutladder - ogscaleladder; // to ease when it comes up
        ogscaleladder += tg * easing;
      }
      if ( laddertimer <= 0 )
      {
        ladderbannerdisplay = false;
        laddertimeron = false;
      }
      scale(ogscaleladder);
      if (ladderbannerdisplay) image( ladderbanner, 0, 0, bannerd, bannerd );
    }
    //---------------------------------- FOR THE BAR BANNER-----------------------------------
    if (topbarboo)
    {
      if (bartimeron) bartimer--;
      if (bartimer < 80 && bartimer > 40 )
      {
        float g = 1 - ogscalebar; // to ease when it comes up
        ogscalebar += g * easing;
      }
      if ( bartimer < 40 )
      {
        float g = 0 - ogscalebar; // to ease when it comes up
        ogscalebar += g * easing;
      }
      if ( laddertimer <= 0 )
      {
        barbannerdisplay = false;
        bartimeron = false;
      }
      scale(ogscalebar);
      if (barbannerdisplay) image( barbanner, 0, 0, bannerd, bannerd );
    } 
    popMatrix();
  }
  void letter()
  {
    if ( Acomesoutboo ) Acomesouttimer--;
    if (Acomesout) image( aletter, 753, 49, 40, 40 );

    if (Acomesouttimer <= -15 )
    {
      window = 2;
      count = 0;
      cook.pause();
      d.horrorsound = true;
      d.finalSound = true;
      ericsays = 4;
      dialogue = true;
      game = false;
    }
  }
  void ericShakes()
  {
    if ( shake )
    {
      fadeTimer--;
      pushMatrix();
      translate( shakex, shakey );
      image(fisherictextbox, width/2, height/2, 700, 700 );
      popMatrix();

      shakex = shakex + random(-25, 25);
      shakey = shakey + random(-25, 25);

      shakex = shakex * 0.5;
      shakey = shakey * 0.5;
    }
    if ( fadeTimer <= 0 ) fade = true;

    if (fade)
    {
      if ( transparency < 255 ) 
      {
        transparency = transparency + 4;
      } else if
        ( transparency > 255 )
      {
        sentfromlevelthree = true;
        ericsays = 5;  // DEATH COMMENTARY
        game = false;
        dialogue = true;
      }// sets the transparency twice as fast
      fill( 255, transparency );
      rect( 0, 0, width, height );
    }
  }
}