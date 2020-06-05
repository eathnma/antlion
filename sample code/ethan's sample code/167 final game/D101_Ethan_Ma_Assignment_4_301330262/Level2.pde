class levelTwo extends Common
{
  int beeleft;
  int beeright;
  int beey;
  int beey2;
  int beespeed;
  int beespeed2;
  int vel;
  boolean beeburnt;
  boolean beegeneral = true;

  boolean burntbeetimerboo;
  int burntbeetimer;

  int shelfx;
  int shelfy;
  int shelfw;
  int shelfh;

  int fireextimer;

  boolean firedropped;
  boolean firepickedup;
  boolean firedragged;
  boolean fireplaced;
  boolean firex;

  int firextimer;
  boolean expickedup;
  boolean exdragged;
  boolean explaced;

  int shelfstate;

  boolean erictimerboo;
  boolean angrybeeboo;
  int erictimer;
  int fadetimerbee;

  int cabinetstate;
  boolean burningcabinetboo;
  int burningcabinet;
  boolean cabinetnoise = true;

  boolean ericcabinetboo;
  int ericcabinet;

  int finaltimer;
  // EASING FOR THE MATCH BANNER
  boolean matchbannerboo;
  boolean matchtimeron;
  boolean matchbannerdisplay;

  float matchtimer = 80;

  float matchtargetScaleout = 0;
  float matchtargetScale = 1;
  float matchogscale = 0;

  // EASING FOR THE FIRE EX
  boolean fireexboo;
  boolean fireextimeron;
  boolean fireexdisplay;

  float fireextimerr = 80;
  float fireexogscale = 0;

  float firextargetScale = 1;
  float firextargetScaleback = 0;

  boolean sound;
  boolean scarybeesound = true;
  boolean scarysound;

  levelTwo( float picx, float picy, float picxtwo )
  {
    super( picx, picy, picxtwo);
    beeleft = 0;
    beeright = 800;
    beespeed = 3;
    beespeed2 = 3;
    beey = 320;
    beey2 = 370;
    firextimer = 540; // controls when the fire ex comes up
    shelfx = width/2 - 70;
    shelfy = 100;
    shelfw = 160;
    shelfh = 200;
    easing = 0.08;
    erictimer = 30;
    fadetimerbee = 30;
    fireextimer = 120;
    burningcabinet = 500; 
    ericcabinet = 60;
    burntbeetimer = 60;
    matchtimer = 80;
    finaltimer = 60;
  }
  void sound()
  {
    if ( scarysound )
    {
      if ( scarybeesound )
      {
        cook.pause();
        scarybee.play();
        scarybeesound = false;
      }
    }
    if (sound)
    {
      cook.pause(); // pause the cook music
      YO.play();
      yosound = false;
    }
  }

  void update()
  { // original level stage
    if (cook1)
    {
      cook.rewind();
      cook.play();
      cook1 = false;
    }
    sound();
    pasteImage();
    active();
    cabinet( mouseX, mouseY );
    right( mouseX, mouseY ); 
    makefalse( mouseX, mouseY );
    leftSide();
    super.update();
    shelf( mouseX, mouseY );
    right( mouseX, mouseY );
    ex(mouseX, mouseY);
    draganddrop( mouseX, mouseY );
    death( mouseX, mouseY );
    end();
    theease();
    ericShakes();
  }
  void cabinet( float x, float y )
  {
    pushMatrix();
    translate( picx, picy );
    switch(cabinetstate)
    {
    case 0:
      image( woodcabinet, width/2 + 30, shelfy + 90, 400, 400 );
      break;

    case 1:
      image( woodcabinetfire, width/2 + 30, shelfy + 90, 400, 400 );
      break;

    case 2:
      image( openwoodcabinet, width/2 + 30, shelfy + 90, 400, 400 );
      break;

    case 3:
      image( bwoodcabinet, width/2 + 30, shelfy + 90, 400, 400 );
      break;

    case 4:
      image( ericwoodcabinet, width/2 + 30, shelfy + 90, 400, 400 );
      break;
    }
    popMatrix();

    if ( burningcabinetboo ) burningcabinet--;
    if ( burningcabinet < 0 ) 
    {
      cabinetstate = 1;
      if ( burningcabinet < -120 && cabinetnoise ) 
      {
        cook.pause();
        scarybee.rewind();
        scarybee.play();
        angrybeeboo = true;
        cabinetnoise = false;
      }
    }

    if ( explaced ) cabinetstate = 3;
    //------------------------------------ DEATH CONDITIONS FOR CABINET------------------------------------------

    if (mousePressed && screenone ) // ADD CONDITIONS
    {
      if ( x > shelfx && x < shelfx + shelfw && y > shelfy && y < shelfy + shelfh && picx > -100 ) 
      {
        sound = true;
        ericcabinetboo = true;
        cabinetstate = 4;
      }
    }
    if ( ericcabinetboo ) ericcabinet--;
    if ( ericcabinet < 0 ) shake = true;
  }

  void shelf( float x, float y )
  {
    pushMatrix();
    translate( picxtwo, picy );
    switch(shelfstate)
    {
    case 0:
      image( drawer, 400, 260, 1000, 1000);
      break;

    case 1:
      image( drawertop, 400, 260, 1000, 1000);
      break;

    case 2:
      image( drawertopmatch, 400, 260, 1000, 1000);
      break;

    case 3:
      image( ericdrawerbottom, 400, 260, 1000, 1000);
      break;
    }
    popMatrix();
    if ( mousePressed && screentwo )
    {
      if ( x > 450 && x < 507 && y > 310 & y < 353 )  // hit detection for the drawer top
      {
        shelfstate = 2;
      }
      if ( x > 442 && x < 516 && y > 370 && y < 413 ) // hit detection for the drawer bottom
      {
        shelfstate = 3;
        erictimerboo = true;
        sound = true;
      }
    }
    if (erictimerboo) erictimer--;
    if (erictimer <= 0 )
    {
      shake = true;
      erictimerboo = false;
    }
  }
  void leftSide( )
  {
    pushMatrix();
    // shelf temp
    translate( picx, picy );

    if ( beegeneral )
    {
      // movement for the bees lol
      beeleft = beeleft + beespeed;
      beeright = beeright - beespeed;
      // if statement for if bee burnt or not
      if ( beeburnt == false )
      {
        PImage img = i.beeMove[i.beeindex];

        image(img, beeleft, beey, 140, 140);
        image(img, beeright, beey2, 140, 140);
      } else 
      if ( beeburnt )
      {
        PImage img = i.beeBURN[i.beeBURNindex];

        image( img, beeleft, beey, 140, 140 );
        image( img, beeright, beey2, 140, 140 );
      }
    } else 
    {
      image( deadbee, beeleft, beey, 140, 140 );   // display dead bees
      image( deadbee, beeright, beey2, 140, 140 );
    }

    if ( burntbeetimerboo ) burntbeetimer--;
    if ( burntbeetimer < 0 ) beegeneral = false;


    if ( beeleft > 800 ) {
      beespeed *= -1; 
      scale( -1, 1 );
    }
    if ( beeleft < 0 ) {
      beespeed *= -1;
    }
    if ( beeright < 0 ) {
      beespeed2 *= -1; 
      scale( -1, 1 );
    }
    if ( beeright > 800 ) {
      beespeed2 *= -1;
    }

    popMatrix();
  }
  void right(float x, float y)
  {
    pushMatrix();
    translate( picxtwo, picy );
    if ( mousePressed && x > 391 && x < 448 && y > 284 && y < 356 && shelfstate == 2 ) {  // hit detection for the lighter
      firepickedup = true;
      shelfstate = 1;
      matchbannerboo = true;
      matchtimeron = true;
      matchbannerdisplay = true;
    }

    if ( firex ) {  // firex controls the timer
      firextimer--; 
      image( fireextinguisher, 510, 220, 150, 150 );
    } // put fire extinguisher here!
    if ( firextimer < 0 ) { 
      firex = false;
      firextimer = 240;
    } else if ( mousePressed && screentwo && firex && x > 481 && x < 533 && y > 160 && y < 264 ) // if the timer is less than 0, and ex clicked
    {
      firex = false;
      expickedup = true;
      fireexboo = true;
      fireextimeron = true;
      fireexdisplay = true;
    }
    popMatrix();

    if ( firepickedup ) image( match, 110, 547, 200, 200 ); // place in the inventory slot
  }
  void draganddrop( float x, float y )
  {
    // for the fire
    if (mousePressed && firepickedup )
    {
      if ( x > 75 && x < 123 && y > 525 && y < 573 ) firedragged = true;
    }
    if ( firedragged ) image( match, mouseX, mouseY, 200, 200 ); // place it on the mouse
    // when placed down
    if ( mousePressed && firedragged && x > 351 && x < 457 && y > 329 && y < 395 ) { // place in the middle of screen
      burningcabinetboo = true; // sets timer for burning closet
      fireplaced = true;  // says that fire has been placed
      firex = true;
      beeburnt = true;  // changes the bees to burnt
      burntbeetimerboo = true;
    }
    if ( fireplaced ) { 
      pushMatrix();
      translate( picx, picy);
      image( match, 414, 363, 200, 200 ); // placing down the fire..
      popMatrix();
      { 
        firepickedup = false; 
        firedragged = false;
      }
    }
  }
  void ex(float x, float y)
  {
    if (expickedup) image( fireextinguisher, 299, 549, 120, 120 ); // draw in inventory 
    if (mousePressed && expickedup && x > 280 && x < 319 && y > 512 && y < 584 ) exdragged = true; // if clicked inventory, then drag true
    if ( exdragged == true ) 
    {
      PImage img = i.fireExtinguisher[i.exindex]; 
      image(img, mouseX - 50, mouseY, 300, 300 );  // placed on mouse
    }
    if ( exdragged && x > 469 && x < 543 && y > 354 && y < 402 )fireextimer--; // if the mouse hovers over a certain state, then run the timer

    if (fireextimer < 0 )
    {
      burningcabinetboo = false;
      expickedup = false; 
      exdragged = false; 
      explaced = true;
    }
  }
  void makefalse(float x, float y)
  {
    if (mousePressed)
    {
      if ( firedragged && screentwo && x > 734 && x < 44 && y > 9 && y < 63 ) firedragged = false; // getting rid of mouseheld for fire
      if ( firedragged && screenone && x > 13 && x < 59 && y > 41 && y < 64 ) firedragged = false;
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
    rect( width/2-100, 440, 220, 5);
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
  void active()
  {
    pushMatrix();
    translate( picx, picy );
    image(trash, 40, 40, 50, 65); // trash
    popMatrix();

    pushMatrix();
    translate(picxtwo, picy);
    image(trash, 760, 40, 50, 65 ); // trash
    popMatrix();
  }
  void death(float x, float y)
  {
    // for the bees
    if ( mousePressed && screenone ) 
    {
      if ( x > beeleft - 70 && x < beeleft + 70 && y > beey - 70 && y < beey + 70 && picx > -200 ) 
      {
        angrybeeboo = true;
        scarysound = true;
      }

      if ( x > beeright - 70 && x < beeright + 70 && y > beey2 - 70 && y < beey2 + 70 && picx > -200 ) 
      {
        angrybeeboo = true;
        scarysound = true;
      }
      //right fish hit detection
    }
    // very angry bee
    if (angrybeeboo) 
    {
      fadetimerbee--;
      if ( fadetimerbee <= 0 ) fade = true;
      image( angrybee, width/2, height/2, 1000, 1000 );
    }
  }
  void theease()
  {
    pushMatrix();
    translate( bannerx, bannery );
    if (matchbannerboo)
    {
      if (matchtimeron) matchtimer--;
      if ( matchtimer < 80 && matchtimer > 40)
      {
        float g = matchtargetScale - matchogscale; // to ease when it comes up
        matchogscale += g * easing;
      }
      if ( matchtimer < 40 )
      {
        float tg = matchtargetScaleout - matchogscale; // to ease when it comes up
        matchogscale += tg * easing;
      }
      if ( matchtimer <= 0 )
      {
        matchbannerdisplay = false;
        matchtimeron = false;
      }
      scale(matchogscale);
      if (matchbannerdisplay) image( matchbanner, 0, 0, bannerd, bannerd );
    }

    if (fireexboo)
    {
      if (fireextimeron) fireextimer--;
      if ( fireextimer < 80 && fireextimer > 40)
      {
        float g = firextargetScale - fireexogscale; // to ease when it comes up
        fireexogscale += g * easing;
      }
      if ( fireextimer < 40 )
      {
        float tg = firextargetScaleback - fireexogscale; // to ease when it comes up
        fireexogscale += tg * easing;
      }
      if ( fireextimer <= 0 )
      {
        fireexdisplay = false;
        fireextimeron = false;
      }
      scale(fireexogscale);
      if (fireexdisplay) image( extinguisherbanner, 0, 0, bannerd, bannerd );
    }
    popMatrix();
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
        sentfromleveltwo = true;
        ericsays = 5;  // DEATH COMMENTARY
        game = false;
        dialogue = true;
      }// sets the transparency twice as fast
      fill( 255, transparency );
      rect( 0, 0, width, height );
    }
  }

  void end()
  {
    if ( fireplaced && explaced )
    {
      finaltimer--;
      if ( finaltimer < 0 )
      {
        d.horrorsound = true; 
        count = 0;
        cook.pause();
        game = false;  // gamestate false
        dialogue = true;  // dialogue-state true
        ericsays = 3;
      }
    }
  }
}