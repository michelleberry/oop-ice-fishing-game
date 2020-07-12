game theGame; 
titleScreen theTitleScreen; 

int gameStage; 
/*  guide:
 *  1 - start up screen
 *  2 - help screen  ( triggered by help button )
 *  3 - game play
 *  4 - game over screen
 */

void setup() {
  size(1000, 900); 
  background(255); 

  theTitleScreen = new titleScreen(); 

  gameStage = 1;
}

void draw() {
  if (gameStage==1) {
    fill(253, 254, 254);
    rect(-1,-1,1001,901);
    
    theTitleScreen.displayTitle();
    theTitleScreen.titleScreenButtons(); 
    if(theTitleScreen.titleScreenButtonSensors() == 1){
      theGame = new game(); 
      theGame.setStartTime(millis()); 
    }
    gameStage = theTitleScreen.titleScreenButtonSensors();
    
  } else if(gameStage==2){
    theTitleScreen.displayHelpInstructions(); 
    gameStage = theTitleScreen.helpExitButton(); 
    
  } else if (gameStage==3) {
    //sea background 
    fill(0, 345, 255); 
    rect(0, 200, 1000, 700);

    //ice background
    fill(253, 254, 254); 
    rect(0, 0, 1000, 200); 

    theGame.displayFisherman(); 
    theGame.displayScore(); 
    theGame.displayTimer();

    //garbage collection on old fish and obstacles
    theGame.removeOldFish(); 
    theGame.removeOldObstacles(); 

    theGame.fishActions(); 
    theGame.obstacleActions();

    theGame.spawnNewObjects(); 
    theGame.bonkedFish();
    if(!theGame.isTimeLeft()){
      gameStage = 4; 
    }
  } else if (gameStage==4){
    fill(255, 87, 34);
    rect(-1,-1,1001,901);
    
    fill(0, 0, 0);  
    textSize(50); 
    text("Time's up!! \nYou caught " + theGame.getScore() + " fish.", 60, 100);
    text("Click anywhere \nto return to title screen.", 60, 300); 
    if(mousePressed){
      gameStage = 1; 
    }
  }
}

void mouseMoved() {
  if (mouseY > 60 && mouseY < 900) {
    theGame.getMyLine().updateLength(mouseY);
  }
}

void mousePressed() {
  for (fish fishy : theGame.getCreatures()) {
    if (fishy.isOnHook(theGame.getMyLine())) {
      if (theGame.getMyLine().getY() < 200) {
        theGame.addScore(1);  
        fishy.setInCooler(true);
      }
    }
  }
}
