
//a text box that recieves text input from user keyboard
class textInput{

  boolean recievingInput; 
  String word; 
  
  public textInput(){
    recievingInput = true; 
    word = ""; 
  
  }
  
  public void showTyping(int x, int y){ 
    fill(0, 0, 0);  
    textSize(25); 
    text(word, x, y);
  }

  void aKeyTyped(){
    if(key == BACKSPACE && recievingInput){
      if(word.length() > 0){
        word = word.substring(0, word.length() -1);
      }
    } else if(word.length() < 21 && ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z') || (key >= 48 && key <= 57) || key == 95) && recievingInput){
      word = word + key; 
    }
  }
  
  void setRecievingInput(boolean value){
    recievingInput = value; 
  }
  
  boolean getRecievingInput(){
    return recievingInput;
  }
  
  void setWord(String newWord){
    word = newWord; 
  }
  
  String getWord(){
    return word; 
  }



}
