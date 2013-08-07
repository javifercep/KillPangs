
PImage FondoMainMenu;
String[] USBdisponible;

void setupMenus()
{
<<<<<<< HEAD
  cp = new ControlP5(this);
  ListaUSB = cp.addListBox("usb")
    .setPosition(170, 50)
      .setSize(180, 120)
        .setItemHeight(20)
          .setBarHeight(30)
            .setColorBackground(color(50, 200, 20))
              .setColorActive(color(220, 200, 20));
  ListaUSB.captionLabel().toUpperCase(true);
  ListaUSB.captionLabel().set("COM");
  ListaUSB.captionLabel().setColor(color(0));
  ListaUSB.captionLabel().style().marginTop = 3;
  ListaUSB.valueLabel().style().marginTop = 0;
  ListaUSB.actAsPulldownMenu(true);

  /*String[] USBdisponible = joystickCOM.list();

  for (int i=0; i<USBdisponible.length;i++)
  {
    ListBoxItem lbi=ListaUSB.addItem(USBdisponible[i], i);
<<<<<<< HEAD
    lbi.setColorBackground(color(100));
  }*/
=======
    lbi.setColorBackground(color(100,0,20));
  }
>>>>>>> Game works!
  //ListaUSB.setVisible(true);

=======
  USBdisponible = joystickCOM.list();
>>>>>>> Colours are beautiful! :D
  FondoMainMenu=loadImage("fotofuad.jpg");
  FondoMainMenu.resize(width, height);
  background(FondoMainMenu);
}

<<<<<<< HEAD
public void controlEvent(ControlEvent theEvent) {

  if (theEvent.isGroup())
  {
    if (theEvent.name().equals("usb"))
    {
      int valorCOM=(int)theEvent.group().value();
      String[][] Puerto=ListaUSB.getListBoxItems();
      //InitJoystickCOM(Puerto[valorCOM][0]);
    }
  }
}
=======
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
>>>>>>> Colours are beautiful! :D
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


