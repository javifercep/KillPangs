
PImage FondoMainMenu;
String[] USBdisponible;

void setupMenus()
{
  USBdisponible = joystickCOM.list();
  FondoMainMenu=loadImage("fotofuad.jpg");
  FondoMainMenu.resize(width, height);
  background(FondoMainMenu);
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


