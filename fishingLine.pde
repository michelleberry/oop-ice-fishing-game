
//used to catch fish with, moves with mouse movements
public class fishingLine {

  boolean fishOnHook;
  boolean disabled; 
  int depth; //y coord
  PImage hook; 
  
  public fishingLine(){
    hook = loadImage("fishHook.png"); 
    fishOnHook = false; 
    depth = 300; 
  }
  
  public void show(){
    strokeWeight(3); 
    line(500, 50, 500, depth); 
    image(hook, 462, depth - 20); 
    strokeWeight(0); 
  }
  
  public void showPole(){
    strokeWeight(3); 
    line(500,50, 640, 100);
    strokeWeight(0);
  }
  
  public void setFishOnHook(boolean value){
    fishOnHook = value; 
  }
  
  public boolean isFishOnHook(){
    return fishOnHook; 
  }
  
  public void updateLength(int newY){
    depth = newY; 
  
  }
  
  public int getX(){
    return 500; 
  }
  
  public int getY(){
    return depth; 
  }
}
