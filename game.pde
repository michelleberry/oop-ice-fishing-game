/*
 * this class performs the gameplay operations
 * using objects of other classes, such as fish, obstacle, and fishingLine
 */
class game {

  //all fish and obstacles in play are stored here
  ArrayList<fish> creatures;
  ArrayList<obstacle> things;

  int score; 
  fishingLine myLine; 

  ArrayList<Integer> bonkedXCoords; //for fish that have been knocked off the fishing line
  ArrayList<Integer> bonkedYCoords; 

  //only used for animations / the images are not of objects in play
  PImage penguin; 
  PImage feesh;
  PImage standingFeesh; 
  
  int startTime; 
  int endTime; 
  int timeLeft; 

  public game() {
    score = 0; 
    startTime = 0; 
    endTime = 0; 
    timeLeft = 0; 

    creatures = new ArrayList<fish>(); 
    things = new ArrayList<obstacle>();

    bonkedXCoords = new ArrayList<Integer>(); 
    bonkedYCoords = new ArrayList<Integer>();  

    myLine = new fishingLine();

    penguin = loadImage("smallPenguin.png");
    feesh = loadImage("fish.png");
    standingFeesh = loadImage("uprightFish.png");
  }

  void displayScore() {
    fill(0, 0, 0);  
    textSize(25); 
    text("score: " + score, 60, 40);
  }
  
  void displayTimer(){
    fill(0,0,0); 
    textSize(25); 
    int minutes = (endTime-millis())/60000;
    int seconds = ((endTime-millis())/1000) - minutes*60;
    text( "time left: " + minutes + ":" + seconds , 10, 90); 
    
  }

  void displayFisherman() {
    //fisherman penguin
    image(penguin, 610, 20); 
    myLine.showPole();
    myLine.show();
    caughtFishStack();
  }

  void fishActions() {
    for (fish fishy : creatures) {
      if (fishy.isOnHook(myLine)) {
        fishy.showOnHook(myLine);
        for (obstacle tings : things) {
          if (tings.hit(myLine)) {
            fishy.slippedOffHook(myLine);
            bonkedXCoords.add(myLine.getX()); 
            bonkedYCoords.add(myLine.getY());
          }
        }
      } else {
        fishy.show();
        fishy.swim();
      }
    }
  }

  void obstacleActions() {
    for (obstacle stuff : things) {
      stuff.show(); 
      stuff.move();
    }
  }

  void spawnNewObjects() {
    if (frameCount%105==0 && creatures.size() < 10) {
      fish baby = new fish(); 
      creatures.add(baby);
    }

    if (frameCount%120 == 0) {
      obstacle trash = new obstacle(); 
      things.add(trash);
    }
  }

  /**
   * removes fish that are out of frame or have been caught
   * from the game's arraylist of fish
   **/
  void removeOldFish() { 
    for (int i=0; i < creatures.size(); i++) {
      creatures.get(i).updateInFrame(); 
      if ( creatures.get(i).getInFrame() == false || creatures.get(i).inCooler()) {
        if (creatures.get(i).inCooler()) { 
          myLine.setFishOnHook(false);
        }
        creatures.remove(i); 
        i--;
      }
    }
  }

  /**
   * removes obstacles that are out of frame 
   * from the game's arraylist of obstacles
   **/
  void removeOldObstacles() {
    for ( int i=0; i < things.size(); i++) {
      things.get(i).setRemoveMe();
      if ( things.get(i).getRemoveMe() == true ) {
        things.remove(i); 
        i--;
      }
    }
  }

  // displays stack of fish that have been caught in upper left corner
  void caughtFishStack() {
    if (score > 0  ) {
      for (int i=0; i < score; i++) { 
        image(feesh, 100, 100-(10*i));
      }
    }
  }

  //animates fish zooming away after they have been knocked off the fishing line
  void bonkedFish() {
    for (int i=0; i < bonkedXCoords.size(); i++) {
      bonkedXCoords.set(i, bonkedXCoords.get(i) + 10); 
      bonkedYCoords.set(i, bonkedYCoords.get(i) + 10); 
      image(standingFeesh, bonkedXCoords.get(i) - 30, bonkedYCoords.get(i) - 100 );
    }

    removeFarawayBonkedFish();
  }

  //prevents fish from continuing to be animated when they have zoomed out of frame
  void removeFarawayBonkedFish() {
    for (int x=0; x < bonkedXCoords.size(); x++) {
      if (bonkedXCoords.get(x) > 1100) {
        bonkedXCoords.remove(x); 
        bonkedYCoords.remove(x); 
        x--;
      }
    }
  }
  
  void setStartTime(int time){
    startTime = time; 
    endTime = time + 120000; 
  }
  
  public boolean isTimeLeft(){
    if(endTime - millis() > 0){
      return true; 
    }
    return false; 
  }

  public fishingLine getMyLine() {
    return myLine;
  }

  public ArrayList<fish> getCreatures() {
    return creatures;
  }

  public void addScore(int add) {
    score += add;
  }
  
  public int getScore(){
    return score; 
  }
}
