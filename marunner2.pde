/* @pjs preload="run1.png","run2.png","run3.png"; */
Obstacle[] obstacles; // Declare the array
int numObstacle = 10;
float speed = 4;
int currentObstacle = 0; 
int score = 88; 
PImage run1,run2, run3, doRun;
void setup(){
  size(700, 200);
  frameRate(60);
  run1 = loadImage("run1.png");
  run2 = loadImage("run2.png");
  run3 = loadImage("run3.png");
  doRun = loadImage("run1.png");
  obstacles = new Obstacle[numObstacle]; // Create the array
  for (int i = 0; i <obstacles.length; i++) {
    obstacles[i] = new Obstacle(); // Create each object
  }
 
  
}

float charY = 120;
int x=39;
int a = 0;
boolean jumper;
int wide = 25;
int tall = 50; 
float animater;
int run;

int c;

void animate(){
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
    tall = 65;
    doRun = run1;
  }else if (run == 1){
    tall = 50;
    doRun = run2;
  }else if (run == 2){
    tall = 25;
    doRun = run3;
    
  }
}

void jump(){
    
    boolean doJump = keyPressed && keyCode == UP && charY>119;
    if (doJump){
    x = 1;
    a = 0; 
    }
  
  charY = (.25*(pow(x-20, 2)))+20;
  if (x<40){
  x++;
  }//else{print(charY);}
  if (charY >= 120){
    jumper = false;
  }else {
    jumper = true;
    run =2;
  }
}


int scorer;
void draw(){
  
  background(235, 235,235);
  /*if (scorer > 415 && scorer < 425){
    background(0,100,0);
  }
  else {
    background(235,235,235);
  }
  */
  //background(235,235,235); 
  if(true){
  line(0,150, 700, 150); 
  //rect( 50 , charY , wide , tall);
  image(doRun, 40 , charY, 50 ,50 );
  scorer = score /4;
  speed = (4*pow(1.00132263, scorer));
  fill(0,20,175);
  text(round(scorer), 600, 25);
  
 for (int i = 0; i < obstacles.length; i++) {
    
    obstacles[i].move();
    obstacles[i].drawObstacle();
    obstacles[i].detect();
    
    
  }
  animate();
  jump();
  scorechecker();
  }
}
float objectDistance;
int scorechecker(){
  score++;
  
  objectDistance = (720/round(speed));
  
  if (score % objectDistance == 0){
  obstacles[currentObstacle].start(random(700, 800), 125);
  currentObstacle++;
  
  }
  
  if (currentObstacle >= numObstacle){
    currentObstacle = 0;
  }
   return score;
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
      xPos-=speed;
    }
    if (xPos <- 50){
      on = false;
      xPos = -100;
    }
  }
  void drawObstacle(){
    if (on == true){
    fill(50, 100, random(50,100));
    rect (xPos-50, yPos, 50, 50);
    }
   
  }
  void detect(){
    if (xPos< 50+wide && xPos > 50){
      if(yPos > charY && yPos < charY+tall){
        println("crash" + x);
      }
    }
  }

}
