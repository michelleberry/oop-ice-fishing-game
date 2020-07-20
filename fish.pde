import java.util.Random; 

//fish object, swim around and get caught
public class fish {

  int x; 
  int y; 
  boolean caught; 
  boolean inCooler; 
  boolean inFrame;
  PImage body; 

  public fish() {
    Random rand = new Random();
    x = 1100; 
    y = rand.nextInt(660) + 250; //spawn at random height in the ocean
    caught = false; 
    inFrame = true; //will need to update
    inCooler = false; 
    body = loadImage("fish.png");
  }

  public void swim() {
    x = x - 2;
  }

  public void show() {
    image(body, x - 100, y - 30); 
    //subtracting from coordinates is only to account for the size of the image (not perfectly cropped).
  }

  public boolean swamAway() {
    this.updateInFrame(); 
    if (inFrame == false) {
      return true;
    }
    return false;
  }

  public boolean getInFrame() {
    return inFrame;
  }

  public void setInCooler(boolean value) {
    inCooler = value;
  }

  public boolean inCooler() {
    return inCooler;
  }

  void updateInFrame() {
    if (x < -100) {
      inFrame = false;
    }
  }

  boolean isOnHook(fishingLine hook) {
    int s = 30; //sensitivity
    if ((hook.getX() < (x+s) && hook.getX() > (x-50) ) && (hook.getY() < (y+100) && hook.getY() > (y-s) ) && (!hook.isFishOnHook())) {
      hook.setFishOnHook(true); 
      body = loadImage("uprightFish.png");
      caught = true;
      return caught;
    } else if (caught == true) {
      return caught;
    }
    return false;
  }

  void slippedOffHook(fishingLine hook) {
    //OPTIONAL: display message saying what happened?
    hook.setFishOnHook(false);
    caught = false; 
    inFrame = false;
  }

  void showOnHook(fishingLine hook) { 
    x = hook.getX(); 
    y = hook.getY(); 
    image(body, x - 30, y);
  }
}
