boolean click = false; 
float acidX = 450; 

void drawMiniGame2() { 
  background(0); 

  //antony 
  fill(255, 255, 255); 
  ellipse(70, 325, 50, 50); 

  //stomach acid 
  fill(0, 255, 0); 
  rect(acidX, 0, 450, 650); 

  acidX -= 0.5; 
  if (click == true) { 
    if (acidX <= 300) { 
      acidX += 5;
    } else { 
      acidX += 4.5;
    } 
    click = false;
  } 
  if (acidX < 120) { 
    println("YOU LOST!!!");
  }
} 

void mouseClickedMiniGame2() { 
  click = true;
}
