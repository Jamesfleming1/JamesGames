// THIS HAS BEEN COMMENTED FOR A DEMONSTRATION TO THE MARIN ACADEMY PROGRAMMING CLASS
/* @pjs preload="cloud0.png", "cloud1.png", run1.png","run2.png","run3.png", "backpack.png"; */ //preloading images for website
Obstacle[] obstacles; // Declare the array for the obstacles / backpacks
int numObstacle = 30;
float speed;
int currentObstacle = 0; 
int score = 0; 
PImage run1,run2, run3, doRun, backpack, cloud,cloud1; //declaring images 


void setup(){ //this code gets run once at the beginning of execution
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


void load(){ // this function is called each time the player loses and then restarts the game 
  score = 0; // start/reset the score
  obstacles = new Obstacle[numObstacle]; // Create/reset the array. This array holds a bunch of objects of the class Obstacle
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
  if (a==0){ // counting up to 10
    b=1;
  }else if (a == 10){ // counting down to 10 
    b=-1;
  }
  a+=b;
  if (jumper == false){ // if the character is not jumping 
  if (a>5){ // if our previous counter is greater than five
    run = 0; // display one image
  }else if (a<5){ // if our countrer is less than five
    run = 1; // display my other image
  }
  }
  if (run == 0){
    doRun = run1; //assign image 1 
  }else if (run == 1){
    doRun = run2; // assign image 2 
  }else if (run == 2){ // if the character is jumping
    doRun = run3; //assign image three which is the one of the character mid air
    
  }
}
boolean havePlayed; // bool for whether the game has been played yet or not
void mousePressed(){ // run this function when the mouse is pressed
  if (scene == false){ //start the game if on starting screen 
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
void jump(){ // run this function to make the character jump up!
    boolean doJump = keyPressed && keyCode == UP && charY>119; // doJump is true when the up character is pressed and the character is not currently jumping 
    if (doJump){ // this will restart the parabolic arc that the character follows while jumping
    x = 1; 
    a = 0; 
    }
  charY = (.25*(pow(x-20, 2)))+20; // the y position of the character is assigned to a parabolic arc 
  if (x<40){ // the x value of the parabolic arc moving across. Go to desmos and graph my parabolic arc and follow it from x = 0 to x = 39 to see what is happening
  x++;
  }
  if (charY >= 120){ // if the character is mid air
    jumper = false; // dont let the character jump again
  }else { // if the character is on the ground 
    jumper = true; // let the character jump again 
    run =2; // make the character have the jumping image
  }
}

boolean scene = false; // if this is false the homescreen will be displayed, if true then the game will play
int scorer;

void draw(){ // MAIN loop
  textAlign(CENTER);
  if(scene){ //displaying the actual game 
  background(235, 235,235); // background color covered by image
  image(cloud, c, 0);// background image
  c1-=2;
  if (c1==-698){ // scroll the two background images 
    c1 = 698;
  }
  if (c==-698){
    c = 698;
  }
  c-=2;
  image(cloud1, c1, 0); // other background image
  image(doRun, 35 , charY, 50 ,50 );// displaying the character
 for (int i = 0; i < obstacles.length; i++) { //running the functions for each object 
    obstacles[i].move();
    obstacles[i].drawObstacle();
    obstacles[i].detect();
  }
  animate(); // calling our other functions
  jump();
  scorechecker();
 
  }else if (scene == false){ // displaying the homescreen
    background(0,50,75);
    textSize(30);
    color red = color(255,0,0);
    color white = color(255,255,255);
    fill(255,255,255);
    if (havePlayed){ //displaying the homescreen after the game
    fill(red);
    text("Marin Academy Runner", width/2, (height/2)-40);
    fill(white);
    text("Click to Try Harder Next Semester", width/2, (height/2));
    text("Your Score Was: " + round(scorer),width/2, (height/2)+40);
    textSize(20);
    text("You are probably disappointed by that grade...",width/2, (height/2)+65);
    }
    else{ // displaying the homescreen the first time
      fill(red);
      text("Marin Academy Runner", width/2, (height/2)-30);
      fill(white);
      text("Click to Begin", width/2, (height/2)+10);
    }
  } // closing bracket for homescreen 
}//closing bracket for mainloop
float objectDistance;
int randumb;
void scorechecker(){ // this function calculates and displays the score and any numbers based on the score
  score++; // this is the number of frame elapsed
  scorer = (score/5); // this is the actual score that gets displayed which is the number of frames elapsed divided by 5
  speed = 6;
  fill(0,20,175);
  textSize(15);
  text(round(scorer), 600, 25);
  if (score % 70 == 0){ // each time the players has survived 70 frames or aprox 1.16 seconds
  float ranPos = 700; 
  
  if (scorer < 420){
   randumb = int(random(0,3)); // each time a new obstacle is displayed it will either be 1 backpack or 2 backpacks
  
  }
  else if (scorer>= 420){  // this is useless until we want 3 obstacles to be appearing which has not been implemented yet 
   randumb = int(random(0,3));
  }
  obstacles[currentObstacle].start(ranPos, 125, randumb); // create a new obstacle!
  currentObstacle++; // move to the next obstacle position in the array
  }
  if (currentObstacle >= numObstacle){
    currentObstacle = 0; // if we have gone through the whole obstacle array, go back to the beginning
  } 
}

class Obstacle{ // this is object oriented programming, don't worry about this too much for now
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
  void detect(){ // Function of Obstacle detecting 
    boolean one = charX+wide>xPos && charX+wide<xPos+50+wide && charY+tall >yPos;
    boolean two = charX+wide>xPos && charX<xPos+120 && charY+tall >yPos;
    boolean three = charX+wide>xPos && charX<xPos+170 && charY+tall >yPos;
    if (ranNum ==2){if (two){scene = false;}} // if there are two obstacles detect for 2
    if (ranNum == 3){if (three){scene = false;}} // if there are 3 obstacles detect for 3
    else{if (one){scene = false;} }// if there is 1 obstacles detect for 1 
  } // closing bracket of Obstacle.detect 

} //Closing bracket of Class Obstacle
