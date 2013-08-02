import processing.serial.*;

int blanco = color(255);
int rojo = color(255, 0, 0);
int verde = color(0, 255, 0);
int azul = color(0, 0, 255);

Serial joystickCOM;
String inString = "";    // Incoming serial data
boolean stringReceived=false;
float posx, posy;
int swon;
StringList Buffer = new StringList();
int colorControl=0;


void setup()
{
  size(600, 600);
  println(Serial.list());
  String portName = Serial.list()[0];
  joystickCOM = new Serial(this, portName, 115200);
  rectMode(CENTER);
  frameRate(60);
  //thread("captureData");
}

void draw()
{
  background(0);

  //println(Buffer.size());
  if (Buffer.size()>0)
  {
    String[] coordenadas = split(Buffer.get(0), ':');
    posx=map(Float.parseFloat(coordenadas[0]), 0, 1023, 25, 575);
    posy=map(Float.parseFloat(coordenadas[1]), 0, 1023, 25, 575);
    swon=Integer.parseInt(coordenadas[2].substring(0, 1));
    Buffer.remove(0);
  }
  inString=null;

  if (swon==0)
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
  rect(posx, posy, 50, 50, 7);
}


void serialEvent(Serial joystickCOM) {
  if (joystickCOM.available()>1)
    inString = joystickCOM.readStringUntil('f');

  //println(inString);
  if (inString != null && inString.length()>=6)
  {
    Buffer.append(inString);
    inString=null;
  }
}

