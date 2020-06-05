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
}
