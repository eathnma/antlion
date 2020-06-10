ArrayList<Circle> circles;

int stage = 1;
int timer = 100;

void setupMiniGame3() {
  
  circles = new ArrayList<Circle>();
    
      for(int i=0; i < 7; i++) { 
       circles.add(new Circle(random(width/3, width-44), random(height/4, height/4*3), 88, 11, 214, 160));
       circles.add(new Circle(random(width/3, width-44), random(height/4, height/4*3), 88, 255, 0, 0));
       circles.add(new Circle(random(width/3, width-44), random(height/4, height/4*3), 88, 98, 98, 155));
       circles.add(new Circle(random(width/3, width-44), random(height/4, height/4*3), 88, 255, 134, 146));
       circles.add(new Circle(random(width/3, width-44), random(height/4, height/4*3), 88, 176, 0, 176));
       circles.add(new Circle(random(width/3, width-44), random(height/4, height/4*3), 88, 255, 214, 11));
       circles.add(new Circle(random(width/3, width-44), random(height/4, height/4*3), 88, 131, 255, 236));
       }    
}

void drawMiniGame3() {
  background(255);
  
  if (stage==1){
    for(int i=0; i < 3; i++) {                          
       Circle circle = circles.get(i);                                
       circle.display();  
       circle.w = 88;
       }
       fill(0);
       textSize(28);
       text("Select the", width/2, height/5-40);
       fill(255, 0, 0);
       text("green", width/2, height/5);
       fill(0);
       text("circle", width/2+85, height/5);
  } 
  
  if (stage==2){
    textSize(54);
    text("Good Job!", width/3-20, height/2);
    timer--;
     if (timer < 0) {
     stage=3; 
     timer=100;
     }  
  } 
  if (stage==3){
    for(int i=0; i < 7; i++) {                          
      Circle circle = circles.get(i);                                
      circle.display();    
      circle.w = 55; 
      }
      fill(0);
      textSize(28);
      text("Select the", width/2, height/5-40);
      fill(0, 255, 0);
      text("pink", width/2, height/5);
      fill(0);
      text("circle", width/2+85, height/5);
      }
   if (stage==4){
    textSize(54);
    text("Good Job!", width/3-20, height/2);
    timer--;
     if (timer < 0) {
     stage=5; 
     timer=100;
     }  
  }
  if (stage==5){
    for(int i=0; i < 15; i++) {                          
      Circle circle = circles.get(i);                                
      circle.display();    
      circle.w = 35; 
      }
      fill(0);
      textSize(28);
      text("Select the", width/2, height/5-40);
      fill(188, 0, 188);
      text("blue", width/2, height/5);
      fill(0);
      text("circle", width/2+85, height/5);
      }
   if (stage ==6) {
      textSize(54);
      text("Win!", width/2, height/2);
   }   
   if (stage ==7) {
      textSize(54);
      text("Lose :(", width/3, height/2);
      timer--;
      if (timer <0) stage=1;
   }

}


void mouseClicked() {
  if (stage ==1) {
    for(int i=0; i < 3; i++) {  
      Circle circle = circles.get(i);  
       if ((mouseX < circle.x+circle.w/2) && 
          (mouseX > circle.x-circle.w/2) && 
          (mouseY < circle.y+circle.w) &&
          (mouseY>circle.y-circle.w/2)&&
          (circle.c == 11)) {
          stage = 2; 
        } else  if 
          ((mouseX < circle.x+circle.w/2) && 
          (mouseX > circle.x-circle.w/2) && 
          (mouseY < circle.y+circle.w) &&
          (mouseY>circle.y-circle.w/2)&&
         (circle.c != 11)) {
          stage = 7;
           }
       }
      } 
      
   if(stage==3){
    for(int i=0; i < 5; i++) {  
      Circle c = circles.get(i);  
       
       if ((mouseX < c.x+c.w/2) && 
          (mouseX > c.x-c.w/2) && 
          (mouseY < c.y+c.w) &&
          (mouseY>c.y-c.w/2)&&
          (c.c == 255)) {
          stage = 4; 
        } else if 
          ((mouseX < c.x+c.w/2) && 
          (mouseX > c.x-c.w/2) && 
          (mouseY < c.y+c.w) &&
          (mouseY>c.y-c.w/2)&&
          (c.c != 255)) {
          stage = 7;
        }
       }
      }  
    if(stage==5){
    for(int i=0; i < 15; i++) {  
      Circle c = circles.get(i);  
       
       if ((mouseX < c.x+c.w/2) && 
          (mouseX > c.x-c.w/2) && 
          (mouseY < c.y+c.w) &&
          (mouseY>c.y-c.w/2)&&
          (c.c == 98)) {
          stage = 6; 
        } else  if 
          ((mouseX < c.x+c.w/2) && 
          (mouseX > c.x-c.w/2) && 
          (mouseY < c.y+c.w) &&
          (mouseY>c.y-c.w/2)&&
          (c.c != 98)) {
          stage = 7;
        }
       }
      }     
}

class Circle {
  float x;
  float y;
  float w;
  int c;
  int c2;
  int c3;
  
  Circle(float posx, float posy, float wid, int col, int col2, int col3) {
  x=posx;
  y=posy;
  w=wid;
  c=col;
  c2=col2;
  c3=col3;
}

  void display(){
  fill(c, c2, c3);
  ellipse(x, y, w, w);
  }
}
