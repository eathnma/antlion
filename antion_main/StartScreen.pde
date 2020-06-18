boolean buttonPressed;
int buttonX, buttonY, buttonW, buttonH;
PImage startScreen;
 
void setupStartScreen() {
  
  buttonPressed = false;
  
  // loading the image into the sketch
  startScreen = loadImage("startscreen.png");
 
  // Some basic parameters for a button
  buttonW = 200;
  buttonH = 50;
  textSize(buttonH/2);
  buttonX = (width-buttonW)/2;
  buttonY = (height-buttonH)/2;
}
 
void drawStartScreen() {
  background(startScreen);
  if (buttonPressed) {
    // The code related to your game
    println("The button has been pressed");
  } else {
    // Show the button
    fill(#ADD8E6);
    rect(buttonX, buttonY+buttonW, buttonW, buttonH);
    fill(0);
    text("Click to Start", buttonX+15, buttonY+buttonW+30);
  }
}
 
void mousePressed() {
  if (mouseX > buttonX && 
      mouseX < buttonX+buttonW && 
      mouseY > buttonY && 
      mouseY < buttonY+buttonH+buttonW+30){
        println("this clicked!");
        fadeOut = true;
      }
}
