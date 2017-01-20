Phrase[] phrases;
String userInput;
void drawText(String t){
  userInput = t;
}

int numPhrase = 300;
int currentPhrase = 0;

void setup(){
  size(300,300);
  load();
  
}
void load(){
  phrases = new Phrase[numPhrase];
  for (int i = 0; i<phrases.length; i++){
    phrases[i] = new Phrase();
  }

}


class Phrase{
  float xPos, yPos;
  
  boolean on = false;
  int txt = 50;
  int blue = 255;
  void start(float xpos, float ypos){
    
    xPos = xpos;
    yPos = ypos;
    on = true;
    
  }
  void grow(){
   if (on){
     if (txt>1){
       txt-=1;
       blue-=4;
     }
     else{
       on = false;
       txt = 1;
     }
   }
  }
  void drawWord(){
    if (on){
      fill(10,75,blue);
      textSize(txt);
      textAlign(CENTER);
      
      text(userInput, xPos, yPos);
    }
  }
}

void draw(){
  background(200,200,200);
  for(int i = 0; i<phrases.length; i++){
    phrases[i].drawWord();
    phrases[i].grow();
  }
}
void mouseDragged(){
  if (currentPhrase>= numPhrase){
    
    load();
    currentPhrase = 0;
  }
  phrases[currentPhrase].start(mouseX, mouseY);
  currentPhrase++;
  
}
