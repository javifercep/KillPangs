import ddf.minim.*;

PImage img;
PImage faudo;
PShape[] faud;
float y=0, x=0;
float[][] aleatorio;
float[][] posiciones;
Minim minim;
AudioPlayer kick;
float counter;
float sumador;
PImage FondoMainMenu, FondoStartMenu;
String[] USBdisponible;
PShader shaderfondo;
PGraphics graphfondo;
void setupMenus()
{

  USBdisponible = joystickCOM.list();
  FondoStartMenu=loadImage("fotofuad.jpg");
  FondoStartMenu.resize(width, height);
  background(FondoStartMenu);
  FondoMainMenu=loadImage("fuad.png");
  FondoMainMenu.resize(width, height);
}

/*public void controlEvent(ControlEvent theEvent) {
 
 if (theEvent.isGroup())
 {
 if (theEvent.name().equals("usb"))
 {
 int valorCOM=(int)theEvent.group().value();
 String[][] Puerto=ListaUSB.getListBoxItems();
 InitJoystickCOM(Puerto[valorCOM][0]);
 }
 }
 }*/
void ShowStartMenu()
{
  textSize(38);
  smooth();
  fill(color(240, 80, 50));
  text("Select an Option: ", 150, 150);
  for (int i=0; i<USBdisponible.length; i++)
  {
    fill(color(240, 80, 50));
    text("Option "+Integer.toString(i+1)+": "+ USBdisponible[i], 150, 250+100*i);
  }
  //background(FondoMainMenu);

}


void ShowMainMenu()
{
  textSize(38);
  smooth();
  fill(color(240, 20, 20));
  text("KILL F.. PANG!!",150,150);
  text("PULSE START", 150, 400);
  Ardu.getDataFromBuffer();
  if(Ardu.getSWTriggerState()==0)
  {

    display.incControlDisplay();
  }
}

void InitHighScoreMenu()
{
  sumador = -20;
  counter = 0;
  noStroke();
  fill(255);
  faud = new PShape[8];

  faudo = loadImage("faud.jpg");
  for (int i=0; i<8;i++) {
    faud[i]=createShape(SPHERE, 45);
    faud[i].setTexture(faudo);
  }

  aleatorio = new float[2][8];
  for (int i=0;i<2;i++) {
    for (int j=0; j<8;j++) {
      aleatorio[i][j] = random(-3.14, 3.14);
    }
  }
  posiciones = new float[2][8];
  for (int i=0;i<2;i++) {
    for (int j=0; j<8;j++) {
      posiciones[i][j] = random(-3.14, 3.14);

    }
  }
  
  minim = new Minim(this);
  kick = minim.loadFile("gasolina.mp3",1024);
  kick.play();
  
  img = loadImage("fondo.jpeg");
  img.resize(width,height);
  fill(255);
  sphereDetail(20);
  shaderfondo = loadShader("fondo.glsl");
  graphfondo = createGraphics(width,height,OPENGL);
  graphfondo.noSmooth();
  graphfondo.beginDraw();
  graphfondo.image(img,0,0,width,height);
  graphfondo.endDraw();
  shaderfondo.set("resolution", float(graphfondo.width), float(graphfondo.height)); 
  shaderfondo.set("mask",graphfondo);  
  background(255);
  
}
void ShowHighScoreMenu()
{
  graphfondo.beginDraw();
  graphfondo.shader(shaderfondo);
  graphfondo.rect(0, 0, graphfondo.width, graphfondo.height);
  graphfondo.endDraw();
  image(graphfondo,0,0,width,height);
  translate(100,70, 0);
  for (int i=0;i<2;i++) {
    pushMatrix();
    for (int j=0; j<4;j++) {
      pushMatrix();
      rotateX(posiciones[0][4*i+j]+=(aleatorio[0][4*i+j])/50);
      rotateY(posiciones[1][4*i+j]+=(aleatorio[1][4*i+j])/50);
      shape(faud[4*i+j]);
      popMatrix();
      translate(0, 150, 0);
    } 
    popMatrix();
    translate(400, 0, 0);
  }
   Ardu.getDataFromBuffer();
  if(Ardu.getSWTriggerState()==0)
  {
    display.incControlDisplay();
  }
}

void keyTyped()
{
  if (key=='1')
  { 
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>0)
      {
        InitJoystickCOM(USBdisponible[0]);
      }
    }
  }
  if (key=='2')
  {
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>1)
      {
        InitJoystickCOM(USBdisponible[1]);
      }
    }
  }
  if (key=='3')
  {
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>2)
      {
        InitJoystickCOM(USBdisponible[2]);
      }
    }
  }
  if (key=='4')
  {
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>3)
      {
        InitJoystickCOM(USBdisponible[3]);
      }
    }
  }
  if (key=='5')
  {
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>4)
      {
        InitJoystickCOM(USBdisponible[4]);
      }
    }
  }
}

void stop()
{
  kick.close();
  minim.stop();
  super.stop();
}

