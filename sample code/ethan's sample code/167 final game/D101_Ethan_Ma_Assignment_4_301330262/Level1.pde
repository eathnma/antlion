class levelOne extends Common
{
  int eric;
  int erictimer;
  int erictimer2;

  float easingfish;
  float timerone = 60;

  float targetFishY = 227;

  float fishx;
  float fishy;
  float fishd;

  float fishfoodx;
  float fishfoody;
  float fishfoodw;
  float fishfoodh;

  float fishtwox;
  float fishtwoy;

  int bannertimer;
  int bannerfish;
  boolean foodbannerboo = true;
  boolean fishbannerboo = true;

  int endtimer;

  boolean bannertimeron;
  boolean tfishbanner;

  boolean itemsgrabbed; // tracks how many items you can pick up at a time

  boolean deskFishClicked = true;

  boolean lamptimer;  // timer starts when you click the projector
  boolean fishfoodgrabbed; // send it to the inventory when you click from screen

  // booleans for 2 different fish states
  boolean fishtriggered; // starts the timer, makes it go up
  boolean fishgrabbed; // sends it to the inventory when you click from screen
  boolean fishbannerclicked; // fishbanner has been clicked already

  // boolean for picking up stuff
  boolean foodpickedup; // picking up the food from inventory
  boolean fishpickedup; // picking up the fish from inventory

  boolean foodplaceddown;
  boolean fishplaceddown;

  levelOne( float picx, float picy, float picxtwo )
  {
    super( picx, picy, picxtwo );
    easing = 0.08;
    easingfish = 0.08;
    fishfoodx = 120;
    fishfoody = 520;
    fishfoodw = 300;
    fishfoodh = 400;
    inventory = 0;
    fishx = 40;
    fishy = 440;
    fishd = 150;
    fishtwox = mouseX + 30;
    fishtwoy = mouseY - 20;
    bannertimer = 80;
    bannerfish = 80;
    endtimer = 60;
    erictimer = 1;
    erictimer2 = 30;
    shaketimer = 60;
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
  {  // should always be at the back
    if (cook1)
    {
      cook.rewind();
      cook.play();
      cook1 = false;
    }
    sound();
    activeBehind();
    dragAndDrop();
    lamp(); // these two should always be at the back
    deskFish();
    super.update();
    active();
    end();
    loseConditions( mouseX, mouseY );
    ericShakes();
  }
  void loseConditions( float x, float y )
  {
    pushMatrix();
    translate( picxtwo, picy );
    // paste different images based on cases
    switch(eric)
    {
    case 0:
      image( door, 600, 290, 1200, 1200 );
      break;

    case 1:
      image( dooropen, 600, 290, 1200, 1200 );
      break;

    case 2:
      image( dooreric, 600, 290, 1200, 1200 );
      break;

    case 3:
      image( dooropen, 600, 290, 1200, 1200 );
      break;
    }
    popMatrix();
    // for the door...
    if ( mousePressed && screentwo && x > 569 && x < 654 && y > 212 && y < 394 )
    {
      eric = 2;
      sound = true;
    }
    if ( eric == 1 ) erictimer--; // if the door opens, countdown to eric
    if ( erictimer == 0 ) eric = 2; // eric appears
    if ( eric == 2 ) erictimer2--; // timer for popup
    if ( erictimer2 <= 0 ) eric = 3;
    if ( eric == 3 ) shake = true;
  }
  void pasteImage()
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

  void lamp() //click the projector and the fish food comes up
  {
    if ( mousePressed && mouseX > 550 && mouseX < 663 && mouseY > 63 && mouseY < 129 && timerone == 60 && i.lampstate == LAMPDIM )
    {
      lamptimer = true;
    }

    if ( lamptimer && screenone )
    {
      timerone--;
      // tint refers to object with no colour
      pushMatrix();
      translate( picx, picy );
      image( fish1, 614, 235, 300, 400 );  // PLACE FISH OBJECT HERE
      popMatrix();

      i.lampstate = LAMPON; // sets the state of the lamp to BRIGHT

      if ( mousePressed && mouseX > 542 && mouseX < 643 && mouseY > 237 && mouseY < 280 ) // when the timer is true, and is clicked
      {
        fishfoodgrabbed = true;
        bannertimeron = true;
      }

      if ( timerone == 0 )
      {
        lamptimer = false;
        timerone = 60;
        i.lampstate = LAMPDIM; // sets the state of the lamp to dim
      }
    }

    if (fishfoodgrabbed) // if the fish is picked up
    {
      if (bannertimeron) bannertimer --;
      if ( bannertimer <= 0 ) 
      { 
        fishbannerboo = false;
        bannertimeron = false;
        bannertimer = 80;
      }
      if ( bannertimer < 80 && bannertimer > 40 )
      {
        float tg = targetScale - ogscale; // to ease when it comes up
        ogscale += tg * easing;
      }
      if ( bannertimer < 40 )
      {
        float tg = targetScaleback - ogscale; // to ease when it comes up
        ogscale += tg * easing;
      }

      pushMatrix();
      translate( bannerx, bannery );
      scale(ogscale);
      if (fishbannerboo)image( fishbanner, 0, 0, bannerd, bannerd ); // the fish banner
      popMatrix();

      lamptimer = false;
      i.lampstate = LAMPDIM; // if the fish is picked up, then the state of the lamp is false
      fill( 214, 48, 49 ); 
      image( fish2, fishfoodx + inventory, fishfoody, fishfoodw, fishfoodh); // inventory slot for the fish
      // to put the placeholder down
    }
  }

  void deskFish() // if you click the desk, then YOU DIE!@!!!@#!@$%#@@#$#
  {
    pushMatrix();
    translate( picx, picy );
    if (deskFishClicked)
    {
      if ( mousePressed && mouseX > 0 && mouseX < 180 && mouseY > 240 && mouseY < 478 )
      {
        fishtriggered = true;
      }

      if ( fishtriggered && screenone )
      {
        fill( 9, 132, 227 );
        image( fishfood0, fishx, fishy, fishd, fishd );  // object that comes up

        float dy = targetFishY - fishy; // to ease when it comes up
        fishy += dy * easing;
        if ( mousePressed && mouseX > 12 && mouseX < 54 && mouseY > 168 && mouseY < 258 )
        {
          fishgrabbed = true;
          fishtriggered = false;
          tfishbanner = true;
        }
      }
    }
    popMatrix();
    if (fishgrabbed) // if the fishfood has been clicked
    {
      if ( tfishbanner )
      { 
        bannerfish--;
        if ( bannerfish <= 0 ) 
        { 
          bannertimer = 80; 
          foodbannerboo = false;
          tfishbanner = false;
        }
        if ( bannerfish < 80 && bannerfish > 40 )
        {
          float tg = targetScale - ogscale; // to ease when it comes up
          ogscale += tg * easingfish;
        }
        if ( bannerfish < 40 )
        {
          float tg = targetScaleback - ogscale; // to ease when it comes down
          ogscale += tg * easingfish;
        }

        pushMatrix();
        translate( bannerx, bannery );
        scale(ogscale);
        if (foodbannerboo) image( foodbanner, 0, 0, bannerd, bannerd ); // the fish banner
        popMatrix();
      }

      fill( 9, 132, 227 );
      image( fishfood0, 300, 560, 120, 120); // then draw the item in the inventory
      deskFishClicked = false;
    }
  }

  void dragAndDrop() // the function so you can hold the object
  {
    if ( mouseX > 48 && mouseX < 149 && mouseY > 534 && mouseY < 567 && fishfoodgrabbed && mousePressed )
    {
      foodpickedup = true;
    }
    if ( mouseX > 279 && mouseX < 319 && mouseY > 527 && mouseY < 563 && fishgrabbed && mousePressed )
    {
      fishpickedup = true;
    }

    if ( foodpickedup ) // remember to set state to false when dropped
    {
      fill( 214, 48, 49 );
      image( fish2, mouseX+30, mouseY-20, 300, 400 ); // set as fishpickedup

      if ( mousePressed && mouseX > 18 && mouseX < 60 && mouseY > 16 && mouseY < 70 )
      {
        foodpickedup = false;
      }
    } else if ( fishpickedup ) // remember to set state to false when dropped
    {
      fill( 9, 132, 227 );
      image( fishfood0, mouseX, mouseY, 120, 120 );  // set as foodpickedup
      if ( mousePressed && mouseX > 18 && mouseX < 60 && mouseY > 16 && mouseY < 70 )
      {
        fishpickedup = false;
      }
    }
    // this is for placing the food in the fishbowl
    if ( screentwo && mouseX > 130 && mouseX < 338 && mouseY > 201 && mouseY < 367 && mousePressed && foodpickedup )
    {
      foodpickedup = false;
      foodplaceddown = true;
    }

    if ( foodplaceddown ) // haven't figured it out yet, but rect should go with screen
    {
      pushMatrix();
      translate( picxtwo, picy);
      PImage img = i.fishMove[i.index];
      image(img, 250, 340, 300, 300);
      popMatrix();
      fishfoodgrabbed = false;
    }

    // this if for placing the fish in the fishbowl
    if ( screentwo && mouseX > 130 && mouseX < 338 && mouseY > 201 && mouseY < 367 && mousePressed && fishpickedup )
    {
      fishpickedup = false;
      fishplaceddown = true;
    }

    if ( fishplaceddown )
    {
      // this is for the fishfood animation
      pushMatrix();
      translate( picxtwo, picy);
      PImage img = i.fishFoodMove[i.foodindex];
      image(img, 300, 200, 175, 175 ); 
      popMatrix();

      fishgrabbed = false;
    }
  }

  void active()
  {
    // multiple objects left side
    pushMatrix();
    translate(picx, picy);
    image(cabinet, 130, 380, 500, 500); // the cabinet
    image(trash, 40, 40, 50, 65); // trash
    popMatrix();

    // multiple objects right side
    pushMatrix();
    translate(picxtwo, picy);
    image(trash, 760, 40, 50, 65 ); // trash
    popMatrix();
  }
  void activeBehind()
  {
    pushMatrix();
    translate(picx, picy);
    image(lightswitch, 320, 170, 70, 70 ); // the lightswitch
    popMatrix();


    pushMatrix();
    translate(picxtwo, picy);
    image(fishbowl, 250, 380, 460, 460 ); // fishbowl
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
        ericsays = 5;
        sentfromlevelone = true;
        dialogue = true;
        game = false;// DEATH COMMENTARY
      }// sets the transparency twice as fast
      fill( 255, transparency );
      rect( 0, 0, width, height );
    }
  }
  void end()
  {
    if ( foodplaceddown && fishplaceddown )
    {
      screentimer = true;
      endtimer--;
      if (endtimer == 0)
      {
        d.horrorsound = true;  // EVIL MUSIC
        count = 0;  // resets the count to 0
        cook.pause();  // pauses the music
        game = false;  // gamestate false
        dialogue = true;  // dialogue-state true
        ericsays = 2; // to call for level one commentary
      }
    }
  }
}