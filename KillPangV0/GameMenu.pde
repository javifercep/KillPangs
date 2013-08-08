
PImage FondoMainMenu, FondoStartMenu;
String[] USBdisponible;

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

void ShowHighScoreMenu()
{
  textSize(38);
  smooth();
  fill(0);
  text("Trabajando en ello",150,150);
  Ardu.getDataFromBuffer();
  if(Ardu.getSWTriggerState()==0)
  {
    display.setControlDisplay(1);
    background(FondoMainMenu);
  }
}

void keyPressed()
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


