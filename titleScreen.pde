class titleScreen {

  PImage title; 
  PImage helpInstructions; 
  PImage startButton;
  PImage helpButton; 
  PImage penguin; 

  public titleScreen() {
    title = loadImage("iceFishingTitleText.png");
    helpInstructions = loadImage("helpBox.PNG"); 
    helpButton = loadImage("helpBut.png"); 
    startButton = loadImage("startBut.png"); 
  }

  void displayTitle() {
    image(title, 120, 100);
  }
  
  void displayHelpInstructions(){
    image(helpInstructions, 150, 10); 
    //fill(0,0,0); 
    //rect(680, 90, 50,50); 
  }
  
  int helpExitButton(){
    if(mousePressed && mouseX > 680 && mouseX < 730 && mouseY > 90 && mouseY < 140){
      return 1; 
    }
    return 2; 
  }
  
  int helpExitButtonSensor(){
    return 2; 
  }

  //show start and help buttons
  void titleScreenButtons() {
    //fill(88, 214, 141); 
    //rect(400, 500, 180, 60);
    //fill(0, 0, 0);  
    

    ///fill(231, 76, 60);  
    ///rect(400, 600, 180, 60);
    ///fill(0, 0, 0);  
    image(startButton, 390, 490); 
    image(helpButton, 390, 590); 
    
  }
  
  //return the gameStage number
  int titleScreenButtonSensors(){
    if (mousePressed && mouseX > 400 && mouseX < 580) {
      if (mouseY > 500 && mouseY < 560) {
        return 3; //start game
      } else if (mouseY > 600 && mouseY < 660 ) {
        return 2; //help screen
      }
    }
    return 1; 
  }
}
