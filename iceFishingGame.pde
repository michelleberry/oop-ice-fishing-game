game theGame; 
titleScreen theTitleScreen;  
scoreKeeper scores; 

int gameStage; 
/*  guide:
 *  1 - start up screen
 *  2 - help screen  ( triggered by help button )
 *  3 - game play
 *  4 - game over screen
 *  5 - score recording (getting nickname input)
 *  6 - score viewing (view top highscores)
 */

void setup() {
  size(1000, 900); 
  background(255); 
   
  scores = new scoreKeeper();
  theTitleScreen = new titleScreen(); 
  
  //theGame = new game(); //REMOVE JUST FOR TESTING PLS REMOVE!!!!!!!!!!1
  
  scores.loadTopScores(); 
  gameStage = 1;
}

void draw() {
  if (gameStage==1) {
    theTitleScreen.displayTitleScreen(); 
    gameStage = theTitleScreen.titleScreenButtonSensors();
    
  } else if(gameStage==2){
    theTitleScreen.displayHelpInstructions(); 
    gameStage = theTitleScreen.helpExitButton(); 
    
  } else if (gameStage==3) {
    background(255); 
    
    //sea background 
    fill(0, 345, 255); 
    rect(0, 200, 1000, 700);

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
    PImage recordScore = loadImage("saveScore.png"); 
    PImage toTitle = loadImage("returnToTitle.png"); 
    
    background(255); 
    
    fill(0, 0, 0);  
    textSize(50); 
    text("Time's up!! \nYou caught " + theGame.getScore() + " fish.", 250, 400);
   
    if(mousePressed & mouseY < 670 && mouseY > 610){
      if(mouseX > 260 && mouseX < 440){
        gameStage = 1; 
      } else if(mouseX > 510 && mouseX <690){
        gameStage = 5; 
      }
    }
    image(recordScore, 500, 600); 
    image(toTitle, 250, 600); 
    
    //fill(231, 76, 60);
    //rect(260, 610, 180, 60);
    
    //fill(88, 214, 141);
    //rect(510, 610, 180, 60);
    
  } else if(gameStage==5){
    scores.scoreRecordingScreen(); 
    gameStage = scores.scoreRecordingButtonSensors(theGame.getScore()); 
  } else if(gameStage==6){
    scores.scoreViewingScreen(); 
    gameStage = scores.scoreViewingScreenButtons(); 
  }
}

void keyTyped(){
  scores.getTextBox().aKeyTyped(); 
  
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
