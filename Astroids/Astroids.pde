int rock = 1;

float[] rx = new float[rock];
float[] ry = new float[rock];
float[] rspeed = new float[rock];
float[] rSize = new float[rock];

void setup()
{
  size(1000,1000);
  background(108);

  for(int i = 0 ; i < rock; i ++)
  {
    rx[i] = random(0, 1010);
    ry[i] = random(0, height);
    rspeed[i] = random(2, 3);
    rSize[i] = random(65, 85);
  }
}

void draw()
{
  background(108);
  stroke(255);
  noFill();

  for(int i = 0 ; i < rock; i ++)
  {
    ellipse(rx[i], ry[i], rSize[i], rSize[i]);
    rx[i] -= rspeed[i];
    if (rx[i] < -10)
    {
      rx[i] = width;
      ry[i] = random(0, height);
      rspeed[i] = random(2, 3);
      rSize[i] = random(65, 85);
    }
  }
}
