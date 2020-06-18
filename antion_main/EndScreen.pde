void drawEndScreen() {
  imageMode(CORNER);
  image(kissQueen1, 0, 0);
  textSize(50);
  fill(255);
  text("YOU WIN! PRESS R TO KISS THE QUEEN", 600, 400);
  minigame3Song.pause();
  if (r) {
    level = 7;
  }
}

void drawKissQueen() {

  //if (r) {
  imageMode(CORNER);
  image(kissQueen2, 0, 0);
  //}
}
