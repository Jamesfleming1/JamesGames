
void setup(){
  size(400, 700);
  
}
 

int charY = 550;
int charW = 20;
int charH = 60; 
int charX = 190;
int score = 0;
Obstacle[] obstacles;
int numObstacle = 40;
int currentObstacle = 0;
int speed =10;
int a;
int jump =0;
int middle, left, right;
int lane;
boolean scene = false;
boolean havePlayed = false;
void load(){
  score = 0; // start/reset the score
  obstacles = new Obstacle[numObstacle]; // Create/reset the array
  for (int i = 0; i <obstacles.length; i++) {
    obstacles[i] = new Obstacle(); // Create/recreate each object in the array
} 
}
boolean moveLeft = false;
boolean moveRight = false;
class Obstacle {
  float xPos, yPos, Height;
  int Arrange;
  boolean on = false;
  void start(float ypos, int arrange){
    
    yPos = ypos; 
    Arrange = arrange;
    on = true;
  } // closing bracket for Obstacle.start
  void move(){ // moving the obstacle
    if (on){ // if displaying obstacles
      
      yPos+=speed; // move the obstacle left across the screen. Moves "speed" pixels every frame
    }
    if (yPos > height+100){ // stop displaying the obstacles once the object is far enough off the screen
      on = false;
      yPos = 800;
    }
  }
  void drawObstacle(){
    if (on == true){
      fill(20, 70, 200);
      
      if (Arrange == 1){
        rect(62.5, yPos, 75,75);
      }
      if (Arrange == 2){
        rect(162.5, yPos, 75 ,75);
      }
      if (Arrange == 3){
        rect(262.5, yPos, 75 ,75);
      }
      if (Arrange == 4 || Arrange == 9){
        rect(62.5, yPos, 75,75);
        rect(162.5, yPos, 75 ,75);
      }
      if (Arrange == 5 || Arrange == 8){
        rect(62.5, yPos, 75 ,75);
        rect(262.5, yPos, 75 ,75);
      }
      if (Arrange == 6 || Arrange == 7){
        rect(162.5, yPos, 75 ,75);
        rect(262.5, yPos, 75 ,75);
      }
      
    }
    
  }
  void detect(){
    boolean oneway = charY<yPos && charY+charH > yPos;
    boolean another = charY < yPos+75 && charY+charH > yPos+75;
    boolean one = lane == 1 && (oneway == true || another == true)&& (Arrange == 5 || Arrange == 8 || Arrange == 4 || Arrange ==9 || Arrange == 1 );
    boolean two = lane == 2 && (oneway == true || another == true)&& (Arrange == 6 || Arrange == 7 || Arrange == 4 || Arrange ==9 || Arrange == 2 );
    boolean three = lane == 3 && (oneway == true || another == true)&& (Arrange == 6 || Arrange == 7 || Arrange == 5 || Arrange ==8 || Arrange == 3 );
    if(one || two || three){
      scene = false;
      
      
    }
    
    
  }
  
}
void mousePressed(){
  if (scene == false){
    scene = true;
    havePlayed = true;
    load();
  }
};
void draw(){
  textAlign(CENTER);
  if (scene){
  background(150, 25,25);
  strokeWeight(5);
  stroke(#ffffff);
  
  line(150, 0 , 150, height);
  line(250, 0, 250, height);
  strokeWeight(3);
  line(350, 0 ,350, height);
  line(50, 0, 50, height);
  noStroke();
  fill(70,70,70);
  rect(0,0, 50, height);
  rect(width-50, 0, 50, height);
  if (keyPressed){
    if(keyCode == UP){
     if (jump < 101){
    jump+=20;
     }
    }
    if(keyCode == DOWN){
      if (jump>20){
      jump-=20;
      }
    }
    
  }
  fill(10,100,150);
  
  strokeWeight(1);
  rect(charX, charY, charW, charH);
 
  
  if ((charX==190 || charX ==290) && keyPressed && keyCode == LEFT){
    moveLeft = true;
    moveRight = false;
    a = 0;
  }
  if ((charX == 90 || charX ==190) && keyPressed && keyCode == RIGHT){
    moveRight = true;
    moveLeft = false;
    a =0;
  }
  if (moveLeft == true){
      while (a<20){
      charX-=5;
      a++;
      }
      keyCode = 0;
  }
  if (moveRight == true){
    while(a<20){
    charX+=5;
    a++;
    }
    keyCode = 0;
  }
  if (charX == 90){
    lane = 1;
  }else if (charX == 190){
    lane = 2;
  }else if (charX == 290){
    lane = 3;
  }
  
  for (int i = 0; i < obstacles.length; i++) { //running the modules for each object 
    obstacles[i].move();
    obstacles[i].drawObstacle();
    obstacles[i].detect();
  }
  score++;
  if (score % 30 == 0){
  int arrangement = round(random(0,9));
  obstacles[currentObstacle].start(0, arrangement);
  currentObstacle++;
  }
  if (currentObstacle >= numObstacle-3){
    currentObstacle = 0;
  } 
  }
  else if (scene == false){
    background(0, 50, 75);
    if(havePlayed){
    
    textSize(25);
    text("Your Score Was: " + round(score/5),width/2, (height/2)+40);
    }
    else {
      textSize(25);
      fill(#ffffff);
      text("Middle School Track and Field", width/2, (height/2)-200);
      textSize(20);
      
      text("Click to Begin, Arrow Keys to Move", width/2, 600);
      textSize(15);
     
      fill(255,0,0);
      text("You, being the athlete that you are, hate running hurdles. To avoid the embarrassment of having to jump over hurdles, you choose to instead dodge the hurdles. The PE coach uses his intelligence and decides that he can force you to jump by flooding the track with hurdles in all three lanes. You snuggly disagree and attempt to run through the track without jumping over a single hurdle. You soon find out that it is harder than you thought to avoid the hurdles... ", (width/2)-150, (height/2)-150, (width/2)+100, (height/2)+50);
      
      
  }
    
}
}