PImage primary, nextButton, prevButton;

int nextX = 789;
int nextY = 526;

int state = 0;

//variables used for the constrain ball code
float mx;
float my;
float easing = 0.05;
int radius = 24;
int edge = 100;
int inner = edge + radius;

//variables used for the weird line effect code
float thold = 5;
float spifac = 1.05;
int outnum;
float drag = 0.01;
int big = 500;
ball bodies[] = new ball[big];
float mX;
float mY;

void setup(){

  size(987, 702);
  primary = loadImage("Assets/primary_ATL.png");
  nextButton = loadImage("Assets/next_button.png");
  prevButton = loadImage("Assets/prev_button.png");
  
  noStroke(); 
  ellipseMode(RADIUS);
  rectMode(CORNERS);
  
  fill(255, 255, 255);
  stroke(255, 255, 255, 5);
  background(0, 0, 0);   
  smooth();
  for(int i = 0; i < big; i++) {
    bodies[i] = new ball();
  }

  
}

void draw(){
  //Use println() statements as a way to debug your code
  //print(state);
  //also use print statements to debug. the difference is println will create a new line at the end
  //so multiple print statements could be used to put multiple stamenets on the same line and println could be used to start a new one
  
  //print("dataset1: ");
  //print(mouseX);
  //println();
  
  //background(255);
  int display = 0;
  display = mouseMath(mouseX, mouseY);
  println(display);
  
  //in state 0, display the map and buttons
  if(state == 0)
  {
    state0();
  }
  //in state 1, do the bouncing ball effect 
  else if(state == 1)
  {
    state1();
  }
  //in state 2, do that weird color line effect that looked cool
  else if(state == 2){
    state2();
  }
  
}

void mouseClicked(){
  //if the state is 0 and the mouse is clicked inside the next button, go to state 1
  if(state == 0){
      if(nextClicked() == 1)
        state = 1;
  }
  //if the state is 1 and the mouse is clicked, go to state 2
  else if(state == 1){
    background(0);
    state = 2;
  }
  //if the state is 2 and the mouse is clicked, go back to state 0
  else if(state == 2)
    state = 0;
  
}

int nextClicked(){
  if(mouseX > nextX && mouseX < nextX + nextButton.width && mouseY > nextY && mouseY < nextY + nextButton.height)
    return 1;
  else
    return 0;
}

int mouseMath(int x, int y){
  int temp = 0;
  if(state == 0)
    temp = x * y;
  else
    temp = x * y / state;
  
  return temp;
}

/*void keyPressed(){
  if( key == 'a')
  {
  }
  
  
}*/


void state0(){
    background(0);
    image(primary, 322, 106);
    image(prevButton, 374, 526);
    image(nextButton, nextX, nextY);
    //state = 1;
}

void state1(){
     //do cool things here 
     background(51);
    
    if (abs(mouseX - mx) > 0.1) {
      mx = mx + (mouseX - mx) * easing;
    }
    if (abs(mouseY - my) > 0.1) {
      my = my + (mouseY- my) * easing;
    }
    
    mx = constrain(mx, inner, width - inner);
    my = constrain(my, inner, height - inner);
    fill(76);
    rect(edge, edge, width-edge, height-edge);
    fill(255);  
    ellipse(mx, my, radius, radius);
}

void state2(){
     //background(0);
    fill(mouseX, 50, 76);
    if(keyPressed) {
      saveFrame("Focus " + outnum);
      outnum++;
    }
    if(mousePressed) {
      background(0, 0, 0);
      
      mX += 0.3 * (mouseX - mX);
      mY += 0.3 * (mouseY - mY);
    }
     mX += 0.3 * (mouseX - mX);
      mY += 0.3 * (mouseY - mY);
    for(int i = 0; i < big; i++) {
      bodies[i].render();
    } 
  
}

//we'll go over this on Tuesday, but putting class here like this creates a custom object
//so instead of String or PImage, now this code can use ball and the methods they define in there
//almost like a mini code set inside of the main code
class ball {
  float X;
  float Y;
  float Xv;
  float Yv;
  float pX;
  float pY;
  float w;
  ball() {
    X = random(width);
    Y = random(height);
    w = random(1 / thold, thold);
  }
  void render() {
    if(!mousePressed) {
      Xv /= spifac;
      Yv /= spifac;
    }
    Xv += drag * (mX - X) * w;
    Yv += drag * (mY - Y) * w;
    X += Xv;
    Y += Yv;
    line(X, Y, pX, pY);
    pX = X;
    pY = Y;
  }
}
