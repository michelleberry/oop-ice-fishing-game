import java.util.Random; 

public class obstacle {
  
  int x; 
  int y; 
  PImage garbage; 
  Random rand;
  boolean hitter = false; 
  boolean removeMe = false; 
  
  public obstacle(){
    rand = new Random(); 
    x = 1100; 
    y = rand.nextInt(660) + 250;
    garbage = loadImage("bottle.png"); 
 }
 
 
 public boolean hit(fishingLine hook){
   int s = 10; 
   if( x < (hook.getX() +s) && x > (hook.getX()-s) && y < (hook.getY()+200) && hook.isFishOnHook()){
      return true;   
   } 
   return false;  
 }
 
 void setRemoveMe(){
   if(x < -50){
     removeMe = true; 
   }
 }
 
 boolean getRemoveMe(){
   return removeMe; 
 }
 
 public void move(){
   x = x - 9; 
 
 }

 public void show(){
   image(garbage, x -30, y-50); 
 }




}
