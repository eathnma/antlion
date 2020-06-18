PImage bg_MiniGame3, raidImg, antLionImg, tdAntony, tdAntonyHurt1, tdAntonyHurt2, tdAntonyDead, tdAntilla;
boolean up3, down3, left3, right3, space3;
PVector upForce = new PVector (0, -2);
PVector downForce = new PVector (0, 2);
PVector leftForce = new PVector (-2, 0);
PVector rightForce = new PVector (2, 0);

void setupMiniGame3() {
  raidImg = loadImage("raid.png");
  antLionImg = loadImage("antlion.png");
  bg_MiniGame3 = loadImage("game4.png");
  tdAntony = loadImage("Top_Down Antony.png");
  tdAntonyHurt1 = loadImage("Top_Down Antony_Hurt1.png");
  tdAntonyHurt2 = loadImage("Top_Down Antony_Hurt2.png");
  tdAntonyDead = loadImage("Top_Down AntonyDead.png");
  tdAntilla = loadImage("AntillaTheHunTopDown.png");

  play = new Player(40, new PVector(179, 541), new PVector(0, 0));
  antilla = new Antilla( 100, new PVector(width/2 + 400, 100), new PVector(-3, 0));
}

void drawMiniGame3() {
  imageMode(CORNER);
  image(bg_MiniGame3, 0, 0);
  play.update();
  antilla.update();

  if (play.health <= 0) {
    fill(0);
    rect(0, 0, 1200, 800);
    fill(255);
    textSize(50);
    text("YOU LOSE! PRESS R TO RESTART!", 600, 400);
    if (r) {
      play.health = 36;
      antilla.health = 100;
    }
  }

  // movement options
  if (up3) play.accelerate(upForce);
  if (down3) play.accelerate(downForce);
  if (left3) play.accelerate(leftForce);
  if (right3) play.accelerate(rightForce);
}

class Player extends Chara {

  // antony shoots raid at the boss.
  ArrayList <Projectile> raidList = new ArrayList<Projectile>(); 

  // determines the raid dots beside antony
  int fullCharge = 90;

  // determines the shot damage
  int shotDamage;

  // whether shooting is true or not
  boolean shooting;
  boolean reload;


  Player(int diam, PVector pos, PVector vel) {
    super(diam, pos, vel);
    pos = new PVector ( xpos, ypos );
    vel = new PVector ( xspeed, yspeed );
    health = 36;
  }

  void update() {
    checkProjectile();
    reload();
    super.update();
    checkWalls();
  }

  void checkProjectile() {
    for (int i = 0; i < raidList.size(); i++) {
      Projectile p = raidList.get(i);
      p.update();

      // if bullet surpasses certain screen height, remove from arraylist
      if (p.pos.y <= -10) {
        p.removeBullet(raidList);
      }
    }

    if ( space3 == false & shooting) {
      play.fire();
      if ( fullCharge < 0) {
        fullCharge = 1;
      }
    }

    if ( space3 == true) {
      fullCharge--;
    }

    if ( fullCharge <= 0) fullCharge = 0;

    //println(fullCharge);
  }

  void fire() {
    //different sizes for the rectangles
    if ( fullCharge < 90 && fullCharge > 75 )
    {
      raidList.add( new Projectile( pos.copy(), new PVector( 0, -10), 10, 50, raidImg ) );
      shotDamage = 1;
    } else if ( fullCharge < 75 && fullCharge > 60  )
    {
      raidList.add( new Projectile( pos.copy(), new PVector( 0, -15), 15, 60, raidImg ) );
      shotDamage = 2;
    } else if ( fullCharge < 60 && fullCharge > 45  )
    {
      raidList.add( new Projectile( pos.copy(), new PVector( 0, -20), 20, 70, raidImg ) );
      shotDamage = 3;
    } else if ( fullCharge < 45 && fullCharge > 30 )
    {
      raidList.add( new Projectile( pos.copy(), new PVector( 0, -25), 25, 80, raidImg ) );
      shotDamage = 4;
    } else if ( fullCharge < 30 && fullCharge > 15 )
    {
      raidList.add( new Projectile( pos.copy(), new PVector( 0, -30), 30, 90, raidImg ) );
      shotDamage = 5;
    } else if ( fullCharge < 15 )
    {
      raidList.add( new Projectile( pos.copy(), new PVector( 0, -35), 40, 100, raidImg ) );
      shotDamage =  6;
    }

    reload = true;
    shooting = false;
  }

  void reload() {
    if (reload) {
      fullCharge++;
      if ( fullCharge >= 90)
      {
        reload = false;
      }
    }
  }

  void drawCharacter() {
    // add antony here...
    float my = constrain(pos.y, 0, 775 );

    pushMatrix();
    noStroke();
    translate( pos.x, my );
    //the square in the middle
    // body
    //rect( 0, 0, diam, diam, 160 );
    tdAntony.resize(diam, diam);
    tdAntonyHurt1.resize(diam, diam);
    tdAntonyHurt2.resize(diam, diam);
    tdAntonyDead.resize(diam, diam);
    // antony slowly dying :(
    if ( this.health <= 36 && this.health > 24) {
      image(tdAntony, 0, 0);
      //fill( #E67E22 );
    } else if ( this.health <= 24 && this.health > 12) {
      image(tdAntonyHurt1, 0, 0);
      //fill( #E77714 );
    } else if ( this.health <= 12 && this.health > 0) {
      image(tdAntonyHurt2, 0, 0);
      //fill( #D86C0D );
    } else if ( this.health <= 0) {
      image(tdAntonyDead, 0, 0);
      //fill( #80420C );
    }

    int rounded = 30;
    // small cans
    if ( fullCharge < 90 )
    {
      rect( -15, 0, 10, 10, rounded );
    }
    if ( fullCharge < 75 )
    {
      rect( 45, 0, 10, 10, rounded );
    }
    if ( fullCharge < 60 )
    {
      rect( -15, 15, 10, 10, rounded );
    }
    if ( fullCharge < 45 )
    {
      rect( 45, 15, 10, 10, rounded );
    }
    if (fullCharge < 30 )
    { 
      rect( -15, 30, 10, 10, rounded );
    }
    if (fullCharge < 15 )
    {
      rect( 45, 30, 10, 10, rounded );
    }

    popMatrix();
  }

  void checkWalls()
  {
    if ( pos.x < 0 - diam ) {
      pos.x = width;
    }
    if ( pos.x > width ) {
      pos.x = 0;
    }
  }
}

class Projectile {
  PVector pos, vel;
  float xspeed, yspeed, w, h, small;
  PImage img;

  Projectile ( PVector pos, PVector vel, float w, float h, PImage img) {
    this.pos = pos;
    this.vel = vel;
    this.w = w;
    this.h = h;
    this.img = img;
  }

  void update() {
    drawbullet();
    pos.add(vel);
  }

  void drawbullet()
  {   
    pushMatrix();
    fill(255);
    translate( pos.x + 15, pos.y );
    image(img, 0, 0, w, h );
    popMatrix();
  }

  void move() {
    pos.add(vel);
  }

  void removeBullet(ArrayList list) {
    list.remove(this);
  }

  // hit detection between circle and rectangle retrieved from
  //http://www.jeffreythompson.org/collision-detection/circle-rect.php
  // reformatted for game purposes

  boolean hit(Chara c)
  {
    // temporary variables to set edges for testing
    float testX = c.pos.x;
    float testY = c.pos.y;

    if ( c.pos.x < pos.x )         testX = pos.x;
    else if ( c.pos.x > pos.x + w) testX = pos.x+ w;
    if ( c.pos.y < pos.y )         testY = pos.y;
    else if ( c.pos.y > pos.y+ h ) testY = pos.y+h ;

    float distX = c.pos.x - testX;
    float distY = c.pos.y - testY;
    float distance = sqrt( (distX*distX) + (distY*distY) );    

    // if the distance is less than the radius, collision!
    if (distance <= c.diam/2) {
      return true;
    }
    return false;
  }
}

class Antilla extends Chara {

  // antony shoots raid at the boss.
  ArrayList <Projectile> antLionList = new ArrayList<Projectile>(); 

  // how frequently the each of the antlions come out
  boolean bossProjectile;
  float projectileTimer = 10;

  // determines the angle of the anteater shooting
  float noseAngle;

  Antilla( int diam, PVector pos, PVector vel) {
    super(diam, pos, vel);
    diam = 5;
    health = 5;
  }

  void update() {
    super.update();
    bulletDetection();
    bossShooting();
    bossHealth();
  }

  void drawCharacter() {
    pushMatrix();
    //fill(255);
    translate( pos.x, pos.y );
    //ellipse( 0, 0, diam, diam );
    tdAntilla.resize(diam, diam);
    image(tdAntilla, -diam/2, -diam/2);
    popMatrix();
  }

  void moveCharacter() {
    pos.add(vel);

    // TRACKS each bounce
    float bounce = 1.0;

    if (pos.x + diam >= 1200 || pos.x - diam <= 0) {
      bounce = bounce + 0.02;
      vel.set(vel.x * -1 * bounce, vel.y);
    }
  }

  void bossHealth() {
    float m = map(health, 0, 100, 0, 1200);
    pushMatrix();
    fill(255, 0, 0);
    rect(0, 0, m, 30);
    popMatrix();
  }

  void bossShooting() {
    // if the boss reaches a certain point in the level
    if (projectileTimer <= 10) {
      // start counting down the timer.
      projectileTimer--;

      if (projectileTimer <= 0) {
        vel.y = 0;
        noseAngle = random(-10, 10);
        antLionList.add( new Projectile( new PVector(pos.x - 60, pos.y), new PVector(noseAngle, 10), 100, 100, antLionImg ) );
        projectileTimer = 10;
      }

      for (int i = 0; i < antLionList.size(); i++) {
        Projectile p = antLionList.get(i);
        p.update();

        if (p.hit(play)) {
          play.health = play.health - 1;
        }
      }
    }
  }

  void bulletDetection() {

    for (int i = 0; i < play.raidList.size(); i++) {
      Projectile p = play.raidList.get(i);

      if (p.hit(this)) {
        play.raidList.remove(i);
        this.health = health - play.shotDamage;
        println(health);
      }
    }

    if (health <= 0) {
      level = 6;

    } // send to end game credits.
  }
}
