import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int star = 10;

int stens = 0;
int mins = 0;
int mtens = 0;

float[] sx = new float[star];
float[] sy = new float[star];
float[] sSpeed = new float[star];
float[] sSize = new float[star];

float[] uiLinesX1 = {25, 25, 25, 25, 970, 950, 950, 970, 750, 750, 750, 960, 345, 650, 345, 345};
float[] uiLinesX2 = {5, 25, 25, 5, 5, 25, 25, 5, 215, 215, 5, 5, 5, 5, 305, 305};
float[] uiLinesY1 = {950, 975, 25, 25, 950, 970, 25, 25, 35, 90, 35, 35, 895, 895, 895, 950};
float[] uiLinesY2 = {25, 5, 5, 25, 25, 5, 5, 25, 5, 5, 55, 55, 60, 60, 5, 5};

PFont font;

boolean AsteroidsStart;
boolean AsteroidsEnd;
boolean transition2Enabled;
boolean endScreen;
boolean engineStart;
boolean groundMoving;
boolean CubeStart;

float move = 0;


float transiton1 = 600;
float transiton2 = 0;

float lLine = 0;
float lerpedLine = 0;
float sum = 0;

float time;
int rock = 25;

float[] rx = new float[rock];
float[] ry = new float[rock];
float[] rspeed = new float[rock];
float[] rSize = new float[rock];
float [] rFill = new float[rock];

float x = 0;
float x2 = 2;

Minim minim;
AudioPlayer ap;
AudioBuffer ab;

float halfH;
float colorInc;
float lerpedAverage = 0;
float[] lerpedBuffer = new float[1024];
float angle = 0;

int cube = 25;

float[] cx = new float[cube];
float[] cy = new float[cube];
float[] cspeed = new float[cube];
float[] cSize = new float[cube];
float[] cubeColour= new float[cube];
float[] cubeColourChanger = new float[cube];


void setup()
{
  rectMode(CORNER);
  frameRate(60);
  size(1000, 1000);
  font = loadFont("OCRAExtended-48.vlw");
  textFont(font);
  for(int i = 0 ; i < star ; i ++)
  {
    sx[i] = random(0, width);
    sy[i] = random(0, height);
    sSpeed[i] = random(0.05, 0.2);
    sSize[i] = random(sSpeed[i]*10, sSpeed[i]*10);
  }

  for(int i = 0 ; i < rock ; i ++)
  {
    rx[i] = random(-40, -990);
    ry[i] = random(0, height);
    rspeed[i] = random(2, 3);
    rSize[i] = random(25, 40);
    rFill[i] = random(100, 180);
  }
  
  for(int i = 0 ; i < cube ; i ++)
  {
    cx[i] = random(-40, -990);
    cy[i] = random(0, height);
    cspeed[i] = random(2, 3);
    cSize[i] = random(30, 150);
    cubeColour[i] = random(0, 255);
    cubeColourChanger[i] = 0;
  }
  
  minim = new Minim(this);
  ap = minim.loadFile("MusicVisualiserAudio.mp3",1000);
  ap.play();
  ab = ap.mix;
  
   halfH = height/2;
   colorInc= 255/(float)ab.size();

  
   int [] arr = {10, 15, 7, 9, 12, 17};
   float sum = 0;
   for(int i = 0; i< arr.length; i++)
   {
     sum += arr[i];
   }
   float average = sum / (float)arr.length;
}
  


void draw()
{
  
    bGround();
    planets();
    asteroids();
    spaceShip();
    cubefloat();
    UI();
    clock();
    transitions();
    
}


void bGround()
  {
    rectMode(CORNER);
    background(0, 6, 13);
    strokeWeight(2);
    push();
    translate(0, 870); 
  
  for(int i = 0; i < ab.size(); i++)
  {
    sum += abs(ab.get(i));
    lLine= (height/3.3) + ab.get(i)*250;
    lerpedLine = lerp(lerpedLine, lLine, 0.005f);
    stroke(255);
    line(i, lerpedLine - height/4, i, lerpedLine - height/4);
  }
  pop();
  
    noStroke();
  fill(0, 6, 13);
  rect(0, 850, 350, 150); 
  rect(650, 850, 350, 150);
  rect(0, 0, 1000, 900);
  rect(0, 950, 1000, 1000);
  
      stroke(255);
    fill(255);
    strokeWeight(1);
    
  
    for(int i = 0 ; i < star ; i ++)
    {
      ellipse(sx[i], sy[i], sSize[i], sSize[i]);
      sx[i] -= sSpeed[i];
      if (sx[i] < -10)
      {
        sx[i] = width;
        sy[i] = random(0, height);
        sSpeed[i] = random(0.05, 0.25);
        sSize[i] = random(sSpeed[i]*20, sSpeed[i]*40);
      }
    }
  }
  
  
void asteroids()
{
  
  noStroke();
  
  if (mins == 1 && stens == 1 && frameCount/60 == 6 || AsteroidsStart == true)
  {
    AsteroidsStart = true;

  }
  
  if (AsteroidsStart == true)
  {
    for(int i = 0 ; i < rock; i ++)
    {
      fill(rFill[i]);
      ellipse(rx[i], ry[i], rSize[i], rSize[i]);
      rx[i] -= rspeed[i];
      if (rx[i] < -100)
      {
        rx[i] = random(1100, 2100);
        ry[i] = random(0, height);
        rspeed[i] = random(4*stens, 5*stens);
        rSize[i] = random(50, 75);
        
      }
    }
  }
  
  
  if (mins == 1 && stens == 4 && frameCount/60 == 6)
  {
    AsteroidsStart = false;
    AsteroidsEnd = true;
  }
  
  if (AsteroidsEnd == true)
  {
    for (int i = 0 ; i < rock; i ++)
    {
      ellipse(rx[i], ry[i], rSize[i], rSize[i]);
      rx[i] -= rspeed[i];
      if (rx[i] < -3100)
      {
        rx[i] = random(100, 200);
        ry[i] = random(0, height);
        rspeed[i] = random(4*stens, 5*stens);
        rSize[i] = random(50, 75);
      }
    }
  }
  
  if (mins == 1 && stens == 4 && frameCount/60 == 8)
  {
    AsteroidsEnd = false;
  }
}



void spaceShip()
  {
    push();
   translate((lerpedLine/4)-150, 0);
   noStroke();
    if (mins >= 0 && stens >= 0 && frameCount/60 >= 4.3){
      engineStart = true;
    }
      
      if (engineStart == true){
    fill(255, 70, 20);
    triangle(370, 480, 370, 520, 300 + random(-15, 15), 500 + random(-5, 5));
    fill(255, 130, 20);
    triangle(370, 470, 370, 490, 310 + random(-15, 15), 480 + random(-5, 5)); 
    triangle(370, 530, 370, 510, 310 + random(-15, 15), 520 + random(-5, 5));
    triangle(370, 510, 370, 490, 350 + random(-15, 15), 500 + random(-5, 5));
      }
    
    fill(125);
    circle(599, 500, 50);
    fill(235);
    stroke(235);
    rect (375, 460, 150, 80); 
    triangle (525, 460, 600, 475, 525, 520);
    triangle (525, 540, 600, 525, 525, 480);
    circle(595, 500, 50);
    circle(555, 500, 50);
    triangle (500, 460, 440, 420, 440, 460);
    triangle (440, 420, 440, 460, 400, 375);
    triangle (375, 460, 375, 380, 400, 375);
    triangle (375, 460, 400, 375, 450, 460);
    triangle (500, 540, 440, 580, 440, 540);
    triangle (440, 580, 440, 540, 400, 625);
    triangle (375, 540, 375, 620, 400, 625);
    triangle (375, 540, 400, 625, 450, 540);
    noStroke();
    fill(75);
    rect(355, 465, 20, 70);
    fill(125);
    triangle(375, 460, 500, 460, 490, 453);
    triangle(375, 540, 500, 540, 490, 547);
    triangle (365, 500, 395, 495, 400, 500);
    triangle (365, 500, 395, 505, 400, 500);
    fill(100, 155, 255);
    rect(600, 490, 10, 20);
    triangle (600, 490, 610, 490, 595, 480);
    triangle (600, 510, 610, 510, 595, 520);
   pop();
  }

  void UI()
  {
    noStroke();
    fill(47, 170, 50);
    for (int i = 0; i < 16; i ++)
    {
  rect(uiLinesX1[i], uiLinesY1[i], uiLinesX2[i], uiLinesY2[i]);
    }
 
    fill(192, 324, 193, 123);
    rect (755, 40, 205, 50);
    rect (350, 900, 300, 50);
  
    stroke(47, 170, 50);
    noFill();
  }

   void clock() {
     textSize(69);
     fill(255);
     
     if (transiton1 > 2){
       frameCount = 0;
     }
     
     if (transiton1 < 2){
     
     if (frameCount > 599) {
       frameCount -= 599;
     }
     
     if (frameCount > 598) {
       stens +=1;
       if (stens > 5) {
       stens -= 6;
       mins += 1;
       }
       if (mins > 9) {
         mins -= 10;
         mtens += 1;
       }
     }
     }
     text(":", 845, 87);
     text(frameCount/60, 905, 87); //secs
     text(stens, 870, 87); //stens
     text(mins, 815, 87); //mins
     text(mtens, 780, 87); //mtens
   }
   
   void planets()
   {
     if(frameCount/60 > 4.3){
       groundMoving = true;
     }
     
     if (groundMoving == true){
       move -= 3;
     }

    noStroke();
    
    //Earth
    fill(50,60,200);
    circle(1000-(2*x),height/2,2700-(1.6*x));
    fill(50, 150, 20);
    strokeWeight(2);
    stroke(50, 150, 20);
    push();
    translate(move, 0);
    triangle(700, 0, 500, 1000, 800, 300);
    triangle(500, 0, 500, 1000, 700, 0);
    rect(0, 0, 500, 1000);
    pop();
    noStroke();
    fill(50,60,200, 50);
    circle(1000-(2*x),height/2,2850-(1.65*x));
    strokeWeight(1);

    //Mars
    fill(255,0,0); 
    circle(3200-(x*2),height/2,190);

    //Jupiter
    fill(255,178,102);
    circle(4500-(x*2),height/2,1300);

    //Saturn
    fill(255,229,204);
    circle(6300-(x*2),height/2,900);

    //Uranus
    fill(204,229,255);
    circle(7700-(x*2), height/2, 450);

    //Neptune
    fill(0,102,204);
    circle(8700-(x*2), height/2, 400);
    
    //Pluto :)
    fill(255,229,204);
    circle(9450-(x*2), height/2, 50);
    fill(255,255,255);
    stroke(1);
    x = x+1;
     
   }
   
   void transitions()
   {
     fill (0, 0, 0, transiton1);
     if (transition2Enabled == true){
     fill (0, 0, 0, transiton2);
     }
     noStroke();
     rect (0, 0, 1000, 1000);
     if (frameCount/60 < 7){
     if (transiton1 > 1){
     transiton1 -= 5;
       }
  }
    if (mins == 2 && stens == 4 && frameCount/60 == 6){
      endScreen = true;
    if (transiton2 < 255){
    transition2Enabled = true;
    transiton2 += 5;
       }
  }
  if (endScreen == true){
     fill(255);
     text("Thanks for watching!", width/2 - 400, height/2);
     }
   }
   
   
   void cubefloat(){
     rectMode(CENTER);
    if (mins == 1 && stens == 4 && frameCount/60 == 8 || CubeStart == true)
  {
    CubeStart = true;
  }
  
  if( CubeStart == true) {
   
    for(int i = 0 ; i < cube; i ++)
    {
    if ((cubeColour[i] + cubeColourChanger[i]) > 255)
  {
    cubeColourChanger[i] = -cubeColour[i];

  } 
        pushMatrix();
      sum +=abs(ab.get(i));
      lerpedBuffer[i] = lerp(lerpedBuffer[i], ab.get(i), 0.5f);
      noFill();
      colorMode (HSB);
      if(lerpedLine/303 > 1){
      stroke(155, 255, 255);
      }
      else{
        stroke(cubeColour[i] + cubeColourChanger[i], 255, 255);
      }

      stroke(cubeColour[i] + cubeColourChanger[i], 255, 255);
      rect(cx[i], cy[i], 50* cSize[i] * lerpedBuffer[i] , 50* cSize[i] * lerpedBuffer[i]);
      
      cx[i] -= rspeed[i];
      if (cx[i] < -100)
      {
        cx[i] = random(1100, 4100);
        cy[i] = random(0, height);
        cspeed[i] = random(2*stens, 3*stens);
        cSize[i] = random(70, 100);
      }
      angle += 0.1;
      popMatrix(); 
      cubeColourChanger[i] += (lerpedLine/330);
      

   }
  }
  
    if (mins == 2 && stens == 3 && frameCount/60 == 3)
  {
    CubeStart = false;
  }
        rectMode(CORNER);
      colorMode (RGB);
}
