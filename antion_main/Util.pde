//import processing.sound.*;
//AudioPlayer s1;

public class Util {

  public double random(int min, int max) {
    return Math.random()*(max-min) + min;
  }
  
  public double random(int max){
    return Math.random()*max;
  }
  
  public color randomColor(){
    int r = (int) random(255);
    int g = (int) random(255);
    int b = (int) random(255);
    
    return color(r,g,b);
  }
  
  //public void loadSound(){
  //  Minim m;
  //  m = new Minim(this);
  //  s1 = m.loadFile("textVoice.mp3");
  //  s1.play();
  //}
  
}

public class StringIntegerPair{
  private String string;
  private int integer;
  
  public String getString(){
    return string;
  }
  
  public int getInteger() {
    return integer;
  }
  
  public void setString(String string) {
    this.string = string;
  }
  
  public void setInteger(int integer) {
    this.integer = integer;
  }
  
}

// LOADING ALL ASSETS
