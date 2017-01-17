/* @pjs preload="run1.png","run2.png","run3.png"; */
Obstacle[] obstacles; // Declare the array
int numObstacle = 50;
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
    boolean doPress = mousePressed && charY>119;
    if (doJump || doPress){
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
  if(true){
  line(0,150, 700, 150); 
  //rect( 50 , charY , wide , tall);
  image(doRun, 40 , charY, 50 ,50 );
  
  
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
int randumb;
void scorechecker(){
  score++;
  
  scorer = (score/4);
  //speed = (4*pow(1.00132263, scorer));
  speed = 7;
  fill(0,20,175);
  text(round(scorer), 600, 25);
  
  if (score % 80 == 0){
  //float ranPos = random(700,800);
  float ranPos = 700;
  
  if (scorer < 500){
   randumb = int(random(0,3)); 
  }
  else if (scorer>= 500){
   randumb = int(random(0,4));
  }
  obstacles[currentObstacle].start(ranPos, 125, randumb);
  
  currentObstacle++;
  
  
  }
  
  if (currentObstacle >= numObstacle){
    currentObstacle = 0;
  }
   
   
}

class Obstacle{
  float xPos, yPos;
  int ranNum;
  
  boolean on = false;
  void start(float xpos, float ypos, int rannum){
    xPos = xpos;
    yPos = ypos;
    
    on = true;
    ranNum = rannum;
  }
  void move(){
    if (on == true){
      xPos-=speed;
    }
    if (xPos <- 100){
      on = false;
      xPos = -100;
    }
  }
  void drawObstacle(){
    if (on == true){
    fill(50, 100, random(50,100));
    
    if (ranNum == 2){
     rect (xPos-65, yPos, 50, 50);
     rect (xPos, yPos, 50, 50);
    }
    else if (ranNum == 3){
      rect (xPos-65, yPos, 50, 50);
     rect (xPos, yPos, 50, 50);
     rect(xPos+65, yPos, 50 ,50);
      
    }
    else{
      rect (xPos, yPos, 50, 50);
    }
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
