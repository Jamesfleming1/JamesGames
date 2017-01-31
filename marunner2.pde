//
/* @pjs preload="cloud0.png", "cloud1.png", run1.png","run2.png","run3.png", "backpack.png"; */ //preloading images for website
Obstacle[] obstacles; // Declare the array for the obstacles / backpacks
int numObstacle = 30; 
float speed;
int currentObstacle = 0; 
int score = 0; 
PImage run1,run2, run3, doRun, backpack, cloud,cloud1; //declaring images 


void setup(){
  size(700, 200); // size of screen + framerate
  frameRate(60);
  run1 = loadImage("run1.png"); // loading images
  run2 = loadImage("run2.png");
  run3 = loadImage("run3.png");
  backpack = loadImage("backpack.png");
  doRun = loadImage("run1.png");
  cloud = loadImage("cloud0.png");
  cloud1 = loadImage("cloud1.png");
  }


void load(){
  score = 0; // start/reset the score
  obstacles = new Obstacle[numObstacle]; // Create/reset the array
  for (int i = 0; i <obstacles.length; i++) {
    obstacles[i] = new Obstacle(); // Create/recreate each object in the array
} 
} //closing bracket for load()
float charY = 120; //starting y pos and x pos of character
int charX = 50; // this remains constant
int x=39; //counter for parabolic arc movement 
int a = 0; //counter for oscillating character running
boolean jumper; //boolean for seeing if character is jumping or not 
int wide = 20; // width of character
int tall = 50; // height of character/
int b = 1; 
int run;
int c;
int c1 = 700;
void animate(){ // animating the character aka switching between images
  if (a==0){
    b=1;
  }else if (a == 10){
    b=-1;
  }
  a+=b;
  if (jumper == false){
  if (a>5){
    run = 0;
  }else if (a<5){
    run = 1;
  }
  }
  if (run == 0){
    doRun = run1; //assign image 1 
  }else if (run == 1){
    doRun = run2; // assign image 2 
  }else if (run == 2){
    doRun = run3; //assign image three
    
  }
}
boolean havePlayed;
void mousePressed(){
  if (scene == false){ //start the game if on starting screen and if mouse pressed
    scene = true;
    havePlayed = true;
    load(); 
  }
  if (scene){ // or jump if the game is already running
  if (charY>119){
    x = 1;
    a =0;
  }
  }
  
} //closing brack for mousePressed()
void jump(){
    boolean doJump = keyPressed && keyCode == UP && charY>119;
    if (doJump){
    x = 1;
    a = 0; 
    }
  charY = (.25*(pow(x-20, 2)))+20;
  if (x<40){
  x++;
  }
  if (charY >= 120){
    jumper = false;
  }else {
    jumper = true;
    run =2;
  }
}

boolean scene = false;
int scorer;

void draw(){ // MAIN loop
  textAlign(CENTER);
  if(scene){ //displaying the actual game 
  background(235, 235,235);
  image(cloud, c, 0);// background color
  c1-=2;
  if (c1==-698){
    c1 = 698;
  }
  if (c==-698){
    c = 698;
  }
  c-=2;
  image(cloud1, c1, 0);
  line(0,150, 700, 150);  // a line on the background
  //rect(charX, charY, wide, tall);
  image(doRun, 35 , charY, 50 ,50 );// displaying the character
  
 for (int i = 0; i < obstacles.length; i++) { //running the modules for each object 
    obstacles[i].move();
    obstacles[i].drawObstacle();
    obstacles[i].detect();
  }
  animate();
  jump();
  scorechecker();
 
  }else if (scene == false){
    background(0,50,75);
    textSize(30);
    color red = color(255,0,0);
    color white = color(255,255,255);
    fill(255,255,255);
    if (havePlayed){ //displaying the homescreen the first time
    fill(red);
    text("Marin Academy Runner", width/2, (height/2)-40);
    fill(white);
    text("Click to Try Harder Next Semester", width/2, (height/2));
    text("Your Score Was: " + round(scorer),width/2, (height/2)+40);
    textSize(20);
    text("You are probably disapointed by that grade...",width/2, (height/2)+65);
    }
    else{ // displaying the homescreen the second time
      fill(red);
      text("Marin Academy Runner", width/2, (height/2)-30);
      fill(white);
      text("Click to Begin", width/2, (height/2)+10);
    }
  } // closing bracket for homescreen 
}//closing bracket for mainloop
float objectDistance;
int randumb;
void scorechecker(){
  score++;
  scorer = (score/5);
  speed = 6;
  fill(0,20,175);
  textSize(15);
  text(round(scorer), 600, 25);
  if (score % 70 == 0){
  float ranPos = 700;
  
  if (scorer < 420){
   randumb = int(random(0,3)); 
   //randumb = 3;
  }
  else if (scorer>= 420){
   randumb = int(random(0,3));
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
  } // closing bracket for Obstacle.start
  void move(){ // moving the obstacle
    if (on){ // if displaying obstacles
      xPos-=speed; // move the obstacle left across the screen. Moves "speed" pixels every frame
    }
    if (xPos <- 200){ // stop displaying the obstacles once the object is far enough off the screen
      on = false;
      xPos = -200;
    }
  } // closing bracket for Obstacle.move
  void drawObstacle(){ // displaying the obstacles 
    if (on == true){ //if obstacle is in dislay mode 
    fill(50, 100, 150); // color of obstacles 
    if (ranNum == 2){ // for 2 obstacles create 2 squares
     //rect (xPos+ 70 , yPos, 50, 50);
     //rect (xPos, yPos, 50, 50);
     image(backpack, xPos-5, yPos-5,60,60);
     image(backpack , xPos+ 65, yPos-5,60,60);
    }
    if (ranNum == 3){ // for 3 obstacles create 3 squares
     //rect (xPos+60, yPos, 50, 50);
     //rect (xPos, yPos, 50, 50);
     //rect(xPos+120, yPos, 50 ,50);
     image(backpack, xPos-5, yPos-5,60,60);
     image(backpack, xPos+55, yPos-5,60,60);
     image(backpack, xPos+115, yPos-5,60,60);
    }
    else{ // for 1 obstacle create 1 square
      //rect (xPos, yPos, 50, 50);
      image(backpack, xPos-5, yPos-5,60,60);
    }
    } // closing for display mode
  } // closing bracket for Obstacle.drawObstacle
  void detect(){ // Module of Obstacle detecting 
    boolean one = charX+wide>xPos && charX+wide<xPos+50+wide && charY+tall >yPos;
    boolean two = charX+wide>xPos && charX<xPos+120 && charY+tall >yPos;
    boolean three = charX+wide>xPos && charX<xPos+170 && charY+tall >yPos;
    if (ranNum ==2){if (two){scene = false;}} // if there are two obstacles detect for 2
    if (ranNum == 3){if (three){scene = false;}} // if there are 3 obstacles detect for 3
    else{if (one){scene = false;} }// if there is 1 obstacles detect for 1 
  } // closing bracket of Obstacle.detect 

} //Closing bracket of Class Obstacle
