import controlP5.*;

import processing.serial.*;

int blanco = color(255);
int rojo = color(255, 0, 0);
int verde = color(0, 255, 0);
int azul = color(0, 0, 255);

int displayState=0;

int colorControl=0;

int numballs=30;

boolean thrcontrol=false;

DataFromArduino Ardu = new DataFromArduino();
Player one= new Player();
Bullet bala[]=new Bullet[5];
Ball fuad[]= new Ball[numballs];
DisplayStateMachine display = new DisplayStateMachine(1);



void setup()
{
  size(600, 600, OPENGL);
  frameRate(60);
  //setupMenus();
}

void draw()
{
  display.ShowDisplay();
}

