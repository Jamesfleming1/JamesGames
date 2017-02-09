
void setup(){
  size(700, 600);
}
boolean scene = false;
Fish[] fishes;
int numFish = 15; // number of starting enemies;
int fishRemaining = numFish;
boolean havePlayed = false;
float sized = 20; // starting size of character 
void load(){
  
  fishes = new Fish[numFish];
  for (int i = 0; i<fishes.length; i++){
    color randomColor = color(random(255), random(255), random(255));
    fishes[i] = new Fish(random(width), random(75,height), random(10,numFish + 10), color(randomColor));
    
  }
}
void mousePressed(){
  if (!scene){
    if(fishRemaining == 0){
      numFish +=5;
    }
    load();
    scene = true;
    fishRemaining = numFish;
    havePlayed = true;
  }
}
class Fish {
  PVector position;
  PVector velocity;
  float r,m;
  color Outline;
  boolean on = true;
  Fish(float x, float y, float r_, color outline){
    Outline = outline;
    position = new PVector(x, y);
    r = r_;
    velocity = PVector.random2D();
    velocity.mult((20/r));
  }
  void move(){
    position.add(velocity);
  }
  void checkCollision(Fish user){
    PVector distance = PVector.sub(user.position, position); // distance between fish
    float distanceMag = distance.mag();
    if (on){
    if(distanceMag <= r + user.r){
      if (user.r > r){
      on = false;
      sized +=r/15;
      fishRemaining -=1;
      velocity = new PVector(0,0);
      
    }else{
      scene = false;
    }
    }
    }
  }
   
  void checkBoundaryCollision(){
    if(position.x>width-r){
      position.x = width-r; //width - r is the right side
      velocity.x*=-1; // reverse the x direction
    }
    else if (position.x < r){ // 0 + r is just r so this is the left side
    position.x = r;
    velocity.x*=-1; // reverse the x direction
    }
    else if (position.y > height-r){// bottom of the screen
      position.y = height-r;
      velocity.y *=-1; //reverse the y direction 
    }
    else if (position.y<r){
      position.y = r;
      velocity.y *=-1;
    }
    if (position.x == mouseX && position.y == mouseY){
      velocity.y*=-1;
      velocity.x*=-1;
    }
  }
  void display(){
    if(on){
    stroke(#ffffff);
    fill(Outline);
    ellipse(position.x, position.y, r*2, r*2);
  }
  }
} // closing bracket of class Fish


void draw(){
  background(0, 50, 75);
  textAlign(CENTER);
  if (scene){
  Fish james = new Fish(mouseX, mouseY, sized , color(0,0,255));
  
 
  if (fishRemaining == 0){
    scene = false;
  }
  
  for (Fish f : fishes){
    f.move();
    f.display();
    f.checkBoundaryCollision();
    f.checkCollision(james);
  }
  james.display();
  }else if (!scene){
    sized = 20;
    noStroke();
    fill(255,0,0);
    rect(0,0, width, 75);
    textSize(45);
    text("The Pond", width/2 , height/2 - 50);
    fill(#ffffff);
    textSize(35);
    if(fishRemaining == 0){
      text("Click to Rule The Pond Again", width/2, (height/2)+50);
      textSize(20);
      text("", width/2, (height/2) +80);
    }else if (fishRemaining < numFish || (fishRemaining == numFish && havePlayed == true)){
      textSize(20);
      text("Click in the Space Above Enter The Pond Again", width/2, (height/2)+50);
      textSize(20);
      text("You have been eaten", width/2, (height/2));
    }if (havePlayed == false){
      textSize(30);
      text("Click in the Space Above to Enter The Pond", width/2, (height/2));
      textSize(20);
      text("Use your mouse to navigate. Prey on the small and avoid the big. Rise to the top", 25, height/2 + 40, width-50, height/2 + 60);
      text("“I would say the smaller the pond, the more belligerent the fish.”  - Craig Brown", 25, (height/2) +120, width-50, (height/2)+150);
    }
    
  }
  
  
}
