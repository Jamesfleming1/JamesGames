Obstacle[] obstacles; // Declare the array
int numObstacle = 10;
int currentObstacle = 0; 
void setup(){
  size(700, 200);
  frameRate(60);
  println("help");
  obstacles = new Obstacle[numObstacle]; // Create the array
  for (int i = 0; i <obstacles.length; i++) {
    obstacles[i] = new Obstacle(); // Create each object
  }
 
  
}

float charY = 125;
int x=45;
int a = 0;
boolean jumper;
int wide = 15;
int tall = 50; 
float animater;
int run;

int c;

void animat(){
  animater = 10*sin((PI*a)/15)+30;
  a++;
  
  if (jumper == false){
  if (animater < 30){
    run = 0;
  }else if (animater > 30){
    run = 1;
  }
  }
  if (run == 0){
    tall = 50;
  }else if (run == 1){
    tall = 35;
  }else if (run == 2){
    tall = 15;
    
  }
}
void jum(){
    if (keyPressed ){
      if(charY >125){
      if(keyCode == UP){
    x = 0;
    a = 0;
    println("help");
      }
  }
    }
  if (x < 45 ){
      x+=1;
  }
  charY = -100*sin((3.14159265359*x)/45) +125;
  if (charY > 125){
    jumper = false;
  }else {
    jumper = true;
    run =2;
  }
}



void draw(){
  background(225,225,225); 
  line(0,150, 700, 150); 
  rect( 50 , charY , wide , tall);
 
 for (int i = 0; i < obstacles.length; i++) {
    
    obstacles[i].move();
    obstacles[i].drawObstacle();
    
  }
  animat();
  jum();
  
}

void mousePressed(){
 
  obstacles[currentObstacle].start(500, 125);
  currentObstacle++;
  
  if (currentObstacle >= numObstacle){
    currentObstacle = 0;
  }
}
class Obstacle{
  float xPos, yPos;
  boolean on = false;
  void start(float xpos, float ypos){
    xPos = xpos;
    yPos = ypos;
    on = true;
  }
  void move(){
    if (on == true){
      xPos-=6;
    }
    if (xPos <- 50){
      on = false;
      xPos = -100;
    }
  }
  void drawObstacle(){
    if (on == true){
    
    rect (xPos, yPos, 50, 50);
    }
  }
  
}