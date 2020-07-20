import java.util.SortedMap; 
import java.util.TreeMap; 
import java.util.Iterator; 
import java.util.Collections; 
import java.util.Map;
import java.util.Set;

//handles score recording/leaderboard feature
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
  
  public textInput getTextBox(){
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
    text("Leaderboard --- TOP FISHERS", 300, 80);

    // Using iterator in SortedMap 
    Set s = scores.entrySet();
    Iterator i = s.iterator(); 

    // Traversing map with iterator
    int x = 0; 
    while (i.hasNext() && x < 7) 
    { 
      Map.Entry m = (Map.Entry)i.next(); 
      text((x+1) + ". " + (String)m.getValue() + "    " + (Integer)m.getKey(), 200, 200+(80*x)); 
      x++;
    }  

    image(toTitle, 700, 780);
  }

  int scoreViewingScreenButtons() {
    if (mousePressed & mouseY < 850 && mouseY > 790 && mouseX > 700 && mouseX < 880) {
      return 1;
    }
    return 6;
  }
  
  //write recorded score to json file of scores.
  void writeScore(String name, int score) {
    //processing handles json operations slightly different than pure java, no parser needed
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
  
  //load json file of scores into sorted map (descending order)
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
