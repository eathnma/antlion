// Initialize 
Antony a;

BottomOfPlatform [] bottomOfPlatform;
TopOfPlatform [] topOfPlatform;

Floor f;

void setupMiniGame0() {
  // Instantiate Antony
  a = new Antony(1000, 700, 50, 50);

  // Instantiate Bottom Of Platform
  bottomOfPlatform = new BottomOfPlatform[4];
  bottomOfPlatform[0] = new BottomOfPlatform(600, 630, 200, 10);
  bottomOfPlatform[1] = new BottomOfPlatform(250, 480, 200, 10);
  bottomOfPlatform[2] = new BottomOfPlatform(450, 130, 200, 10);
  bottomOfPlatform[3] = new BottomOfPlatform(100, 330, 200, 10);

  // Instantiate Top Of Platform
  topOfPlatform = new TopOfPlatform[4];
  topOfPlatform[0] = new TopOfPlatform(600, 600, 200, 30);
  topOfPlatform[1] = new TopOfPlatform(250, 450, 200, 30);
  topOfPlatform[2] = new TopOfPlatform(450, 100, 200, 30);
  topOfPlatform[3] = new TopOfPlatform(100, 300, 200, 30);

  // Instantiate Floor
  f = new Floor(0, 780, 1200, 40);
}

// Draw Method
void drawMiniGame0() {

  // Background
  background(0);

  // Draw Antony
  a.drawAntony();

  // Draw Platforms
  for (int i = 0; i < bottomOfPlatform.length; i++) {
    bottomOfPlatform[i].drawBottomPlat();
  }

  // Draw Platforms
  for (int i = 0; i < topOfPlatform.length; i++) {
    topOfPlatform[i].drawTopPlat();
  }

  // Draw Floor
  f.drawFloor();


  void keyPressed() {
    a.keyPressed();
  }

  void keyReleased() {
    a.keyReleased();
  }
}

////////////////////////////////////////////////////////////////////////////////

class Antony {

  float x, y, w, h;
  float floorCoord = 750;

  // Antony speedX and speedY
  float speedX;
  float speedY;

  // Gravity Multiplier
  float gravity = 0.95;

  // Booleans
  boolean left, right, jump;
  boolean connected = false;

  Antony(float xPos, float yPos, float wid, float hei) {
    x = xPos;
    y = yPos;
    w = wid;
    h = hei;
  }

  // Draw Antony
  void drawAntony() {

    // Antony
    pushMatrix();
    translate(x, y);
    rect(0, 0, w, h);
    popMatrix();

    // Call Move Method
    update();
  }

  // Move Method
  void update() {

    x += speedX;
    y += speedY;

    if (left) {
      speedX = -10;
    }

    if (right) {
      speedX = 10;
    }

    if (!left && !right) {
      speedX = 0;
    }

    if (connected == false) {
      speedY += gravity;
    }

    // If Spacebar Pressed, Jump Up Only Once
    if (jump && connected == true) {
      speedY = -20;
      connected = false;
    }

    // Bottom Platform
    for (int i = 0; i < bottomOfPlatform.length; i++) {

      // If Colliding with bottomOfPlatform, Call land() Method
      if (collideBottomPlatform(a, bottomOfPlatform[i])) {
        hitBottom(bottomOfPlatform[i].y);
      }

      if (!collideBottomPlatform(a, bottomOfPlatform[i]) && !jump) {
        connected=false;
      }
    }

    // Top Platform
    for (int i = 0; i < topOfPlatform.length; i++) {

      // If Colliding with topOfPlatform, Call land() Method
      if (CollideTopPlatform(a, topOfPlatform[i])) {
        landOnTop(topOfPlatform[i].y);
      }

      if (!CollideTopPlatform(a, topOfPlatform[i]) && !jump) {
        connected=false;
      }
    }

    // If Colliding with Floor, Call land() Method
    if (collideWithFloor(a, f)) {
      landOnTop(f.y);
    }

    // If Not Colliding With Floor, Apply Gravity
    if (!collideWithFloor(a, f) && !jump) {
      connected=false;
    }
  }

  // Only Land on Top of Platform/Floor
  void landOnTop(float destY) {
    speedY = 0;
    connected=true;
    y = destY - h;
  }

  void hitBottom(float destY2) {
    speedY=0;
    connected=false;
    y = destY2 + 10;
  }

  // Platform Collision
  boolean collideBottomPlatform(Antony a, BottomOfPlatform p) {

    return ((p.x < a.x + a.w) && 
      (p.x + p.w > a.x) &&
      (p.y < a.y + a.h) &&
      (p.h + p.y > a.y));
  }

  // Platform Collision
  boolean CollideTopPlatform(Antony a, TopOfPlatform p) {

    return ((p.x < a.x + a.w) && 
      (p.x + p.w > a.x) &&
      (p.y < a.y + a.h) &&
      (p.h + p.y > a.y));
  }

  // Floor Collision
  boolean collideWithFloor(Antony a, Floor p) {

    return ((p.x < a.x + a.w) && 
      (p.x + p.w > a.x) &&
      (p.y < a.y + a.h) &&
      (p.h + p.y > a.y));
  }

  // keyPressed
  void keyPressed() {

    if (key == 'a' || key == 'A') {
      left = true;
    }

    if (key == 'd' || key == 'D') {
      right = true;
    }

    if (key == ' ') {
      jump = true;
    }
  }

  // keyReleased
  void keyReleased() {

    if (key == 'a' || key == 'A') {
      left = false;
    }

    if (key == 'd' || key == 'D') {
      right = false;
    }

    if (key == ' ') {
      jump = false;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

class BottomOfPlatform {
  float x, y, w, h;

  BottomOfPlatform(float xPos, float yPos, float wid, float hei) {
    x = xPos;
    y = yPos;
    w = wid;
    h = hei;
  }

  void drawBottomPlat() {
    pushMatrix();
    translate(x, y);
    rect(0, 0, w, h);
    popMatrix();
  }
}

////////////////////////////////////////////////////////////////////////////////

class Floor {
  float x, y, w, h;

  Floor(float xPos, float yPos, float wid, float hei) {
    x = xPos;
    y = yPos;
    w = wid;
    h = hei;
  }

  void drawFloor() {
    pushMatrix();
    translate(x, y);
    rect(0, 0, w, h);
    popMatrix();
  }
}

////////////////////////////////////////////////////////////////////////////////

class TopOfPlatform {
  float x, y, w, h;

  TopOfPlatform(float xPos, float yPos, float wid, float hei) {
    x = xPos;
    y = yPos;
    w = wid;
    h = hei;
  }

  void drawTopPlat() {
    pushMatrix();
    translate(x, y);
    rect(0, 0, w, h);
    popMatrix();
  }
}
