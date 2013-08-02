import processing.serial.*;

int blanco = color(255);
int rojo = color(255, 0, 0);
int verde = color(0, 255, 0);
int azul = color(0, 0, 255);

int colorControl=0;

DataFromArduino Ardu = new DataFromArduino();



void setup()
{
  size(600, 600);
  InitJoystickCOM(); /* Initializes communication with Joystick*/
  rectMode(CENTER);
  frameRate(60);
  //thread("captureData");
}

void draw()
{
  background(0);

  if (Ardu.getDataFromBuffer())
  {
    if (Ardu.getSWState()==0)
      if (colorControl++ == 3) colorControl = 0;
    switch(colorControl)
    {
    case 0: 
      fill(blanco);
      break;
    case 1: 
      fill(rojo);
      break;
    case 2: 
      fill(verde);
      break;
    case 3: 
      fill(azul);
      break;
    }
  }
  rect(Ardu.getX(), Ardu.getY(), 50, 50, 7);
}


