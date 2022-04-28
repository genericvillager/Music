int star = 10;

int stens = 0;
int mins = 0;
int mtens = 0;

float[] sx = new float[star];
float[] sy = new float[star];
float[] sSpeed = new float[star];
float[] sSize = new float[star];

float[] uiLinesX1 = {25, 25, 25, 25, 970, 950, 950, 970, 250, 625, 750, 750, 750, 960};
float[] uiLinesX2 = {5, 25, 25, 5, 5, 25, 25, 5, 125, 125, 215, 215, 5, 5};
float[] uiLinesY1 = {950, 975, 25, 25, 950, 975, 25, 25, 498, 498, 35, 90, 35, 35};
float[] uiLinesY2 = {25, 5, 5, 25, 25, 5, 5, 25, 4, 4, 5, 5, 55, 55};

PFont font;

boolean AsteroidsStart;
boolean transition2Enabled;

float transiton1 = 600;
float transiton2 = 0;

float time;
int rock = 16;

float[] rx = new float[rock];
float[] ry = new float[rock];
float[] rspeed = new float[rock];
float[] rSize = new float[rock];



void setup()
{
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
    rx[i] = random(0, 1010);
    ry[i] = random(0, height);
    rspeed[i] = random(2, 3);
    rSize[i] = random(25, 40);
  }
}

void draw()
{
  
    bGround();
    asteroids();
    spaceShip();
    UI();
    clock();
    transitions();
    
}


void bGround()
  {
    background(0, 6, 13);
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
  if (mins == 1 && stens == 1 && frameCount/60 == 7 || AsteroidsStart == true)
  {
    AsteroidsStart = true;
    for(int i = 0 ; i < rock; i ++)
    {
      ellipse(rx[i], ry[i], rSize[i], rSize[i]);
      rx[i] -= rspeed[i];
      if (rx[i] < -10)
      {
        rx[i] = 1010;
        ry[i] = random(0, height);
        rspeed[i] = random(2, 3);
        rSize[i] = random(25, 40);
      }
    }
  }
  
  if (mins == 1 && stens == 4 && frameCount/60 == 9)
  {
    AsteroidsStart = false;
  }
}






void spaceShip()
  {
   
  }

  void UI()
  {
    noStroke();
    fill(47, 170, 50);
    for (int i = 0; i < 14; i ++)
    {
  rect(uiLinesX1[i], uiLinesY1[i], uiLinesX2[i], uiLinesY2[i]);
    }
    
    fill(192, 324, 193, 123);
    rect (755, 40, 205, 50);
  
    stroke(47, 170, 50);
    noFill();
    strokeWeight(5);
    circle (500, 500, 60);
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
     
    if (mins == 2 && stens == 4 && frameCount/60 == 5){
    if (transiton2 < 255){
    transition2Enabled = true;
    transiton2 += 5;
       }
  }
   }
