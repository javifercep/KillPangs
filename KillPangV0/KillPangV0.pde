import controlP5.*;

import processing.serial.*;

int blanco = color(255);
int rojo = color(255, 0, 0);
int verde = color(0, 255, 0);
int azul = color(0, 0, 255);

int displayState=0;

int colorControl=0;

int numballs=10;

boolean thrcontrol=false;

DataFromArduino Ardu = new DataFromArduino();
Player one= new Player();
Bullet bala[]=new Bullet[5];
Ball fuad[]= new Ball[numballs];



void setup()
{
  size(600, 600, OPENGL);
  frameRate(60);
  setupMenus();
  displayState=0;
}

void draw()
{
  switch(displayState)
  {
    case 0: ShowStartMenu();
    break;
    
    case 1: ShowGame();
    break;
  }
}

void InitGame()
{
  for (int i=0; i<5; i++) {
    bala[i]= new Bullet(10, 475);
  }
  for (int i=0; i<numballs; i++) {
    fuad[i]= new Ball(random(15, 500), random(15, 400), 2*(random(-2, 2)), 2*(random(-2, 2)));
    fuad[i].activate();
  }

  thread("ballshit");
  noStroke();
}

