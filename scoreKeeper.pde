

import java.util.SortedMap; 
import java.util.TreeMap; 
import java.util.Iterator; 
import java.util.Collections; 
import java.util.Map;
import java.util.Set;


class scoreKeeper {

  SortedMap<Integer, String> scores;

  textInput textBox; 

  PImage enterButton; 
  PImage cancelButton; 

  public scoreKeeper() {
    scores = new TreeMap<Integer, String>(Collections.reverseOrder());

    textBox = new textInput();
    enterButton = loadImage("enter.png"); 
    cancelButton = loadImage("cancel.png");
  }

  textInput getTextBox() {
    return textBox;
  }

  void scoreRecordingScreen() {
    background(255); 

    fill(0, 34, 155); 
    rect(50, 150, 900, 400); 

    fill(253, 254, 254);
    rect(90, 250, 800, 60); 

    textSize(30); 
    text("Please enter a nickname (20 characters or less):", 90, 230);
    textBox.showTyping(100, 290); 

    image(enterButton, 500, 397); 
    image(cancelButton, 250, 400);
  }

  int scoreRecordingButtonSensors(int scored) {
    //fill(88, 214, 141); 
    //rect(510, 420, 200, 80);

    //fill(231, 76, 60);  
    //rect(255, 420, 200, 80);
    if (mousePressed && mouseY > 420 && mouseY < 500) {
      if (mouseX > 510 && mouseX < 710) {
        writeScore(textBox.getWord(), scored); 
        textBox.setWord("");
        loadTopScores(); 
        return 6;
      } else if (mouseX > 255 && mouseX < 455 ) {
        textBox.setWord("");
        return 4;
      }
    }
    return 5;
  }

  void scoreViewingScreen() {
    PImage toTitle = loadImage("returnToTitle.png");
    background(253, 254, 254); 

    fill(79, 195, 247); 
    rect( 100, 100, 800, 640); 

    fill(253, 254, 254); 
    rect( 120, 120, 760, 600); 

    fill(0, 0, 0);  
    textSize(30); 
    text("Leaderboard --- TOP 5 FISHERS", 300, 80);

    Set s = scores.entrySet(); 

    // Using iterator in SortedMap 
    Iterator i = s.iterator(); 

    // Traversing map. 
    int x = 0; 
    while (i.hasNext() && x < 6) 
    { 
      Map.Entry m = (Map.Entry)i.next(); 
      text((x+1) + ". " + (String)m.getValue() + "    " + (Integer)m.getKey(), 200, 200+(80*x)); 
      x++; 
    }  

    //fill(88, 214, 141); 
    //rect(700, 790, 180, 60); //back to start
    image(toTitle, 700, 780);
  }

  int scoreViewingScreenButtons() {
    if (mousePressed & mouseY < 850 && mouseY > 790 && mouseX > 700 && mouseX < 880) {
      return 1;
    }
    return 6;
  }

  void writeScore(String name, int score) {
    JSONObject scoreFile = loadJSONObject("scores.json"); 
    JSONArray playersArr = (JSONArray) scoreFile.get("players");

    JSONObject toAdd = new JSONObject(); 
    toAdd.put("name", name); 
    toAdd.put("score", score); 

    playersArr.append(toAdd); 

    //overwrite old jsonfile with new one with appended data
    JSONObject toWrite = new JSONObject(); 
    toWrite.put("players", playersArr); 
    saveJSONObject(toWrite, "data/scores.json");
  }

  void loadTopScores() {
    JSONObject scoreFile = loadJSONObject("scores.json"); 
    JSONArray playersArr = (JSONArray) scoreFile.get("players");

    JSONObject tempPlayer; 
    for (int i=0; i< playersArr.size(); i++) {
      tempPlayer = (JSONObject) playersArr.get(i); 
      scores.put((Integer)tempPlayer.get("score"), (String) tempPlayer.get("name"));
    }
  }
}
