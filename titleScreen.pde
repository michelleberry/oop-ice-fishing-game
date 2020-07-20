
//handles user interface operations that aren't actual gameplay
class titleScreen {

  PImage title; 
  PImage helpInstructions; 
  PImage startButton;
  PImage helpButton; 
  PImage scoresButton;
  PImage recordScore; 
  PImage toTitle; 
  PImage penguin; 

  public titleScreen() {
    title = loadImage("iceFishingTitleText.png");
    helpInstructions = loadImage("helpBox.PNG"); 
    helpButton = loadImage("helpBut.png"); 
    startButton = loadImage("startBut.png"); 
    scoresButton = loadImage("viewScores.png"); 
    recordScore = loadImage("saveScore.png");
    toTitle = loadImage("returnToTitle.png");
  }
  
  ///////////////////////////////////////////////title//////////////////////////////////////////////////////
  public void displayTitleScreen(){
    background(255); 
    displayTitle();
    titleScreenButtons(); 
  }
  
  void displayTitle() {
    image(title, 120, 100);
  }
  
  //show start and help buttons
  void titleScreenButtons() {
    image(startButton, 390, 490); 
    image(helpButton, 390, 590); 
    image(scoresButton, 390, 690); 
  }
  
  //return the gameStage number
  int titleScreenButtonSensors(){
    if (mousePressed && mouseX > 400 && mouseX < 580) {
      if (mouseY > 500 && mouseY < 560) {
        return 3; //start game
      } else if (mouseY > 600 && mouseY < 660 ) {
        return 2; //help screen
      } else if(mouseY > 700 && mouseY < 770){
        return 6; 
      }
    }
    return 1; 
  }
  
  ///////////////////////////////////////////////help//////////////////////////////////////////////////////
   void displayHelpInstructions(){
    image(helpInstructions, 150, 10); 
  }
  
  int helpExitButtonSensor(){
    if(mousePressed && mouseX > 680 && mouseX < 730 && mouseY > 90 && mouseY < 140){
      return 1; 
    }
    return 2; 
  }
  
  ///////////////////////////////////////////////game end//////////////////////////////////////////////////////
  public void displayGameEndScreen(){
    background(255); 
    
    fill(0, 0, 0);  
    textSize(50); 
    text("Time's up!! \nYou caught " + theGame.getScore() + " fish.", 250, 400);
   
    image(recordScore, 500, 600); 
    image(toTitle, 250, 600); 
  }
  
  int gameEndScreenButtonSensors(){
    if(mousePressed & mouseY < 670 && mouseY > 610){
      if(mouseX > 260 && mouseX < 440){
        return 1; 
      } else if(mouseX > 510 && mouseX <690){
        return 5; 
      }
    }
    return 4; 
  }

 


  
  
}
