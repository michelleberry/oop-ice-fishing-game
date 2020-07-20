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
  theGame = new game(); //put here to avoid seg faults if you wish to change gameStage (below) in setup, otherwise redundant
                        //new game is instantiated whenever "start" button is pressed.
  
  scores.loadTopScores(); 
  gameStage = 1;
}

//this is the "main" method for Processing, it executes constantly like a while(1) loop 
//i have tried to keep it as compact & organized as possible
void draw() {
  //title screen
  if (gameStage==1) { 
    theTitleScreen.displayTitleScreen(); 
    if(theTitleScreen.titleScreenButtonSensors() == 1){
      theGame = new game(); 
      theGame.setStartTime(millis()); 
    }
    gameStage = theTitleScreen.titleScreenButtonSensors();
  
  //help screen
  } else if(gameStage==2){
    theTitleScreen.displayHelpInstructions(); 
    gameStage = theTitleScreen.helpExitButtonSensor(); 
  
  //game play screen
  } else if (gameStage==3) {
    theGame.displayGamePlay(); 
    if(!theGame.isTimeLeft()){
      gameStage = 4; 
    }
    
  //game end screen ( time is up)
  } else if (gameStage==4){
    theTitleScreen.displayGameEndScreen(); 
    gameStage = theTitleScreen.gameEndScreenButtonSensors();
    
  //record user nickname for score recording screen
  } else if(gameStage==5){
    scores.scoreRecordingScreen(); 
    gameStage = scores.scoreRecordingButtonSensors(theGame.getScore()); 
    
  //view highscores screen
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
