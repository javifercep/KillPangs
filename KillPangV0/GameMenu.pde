ListBox ListaUSB;
ControlP5 cp;
PImage FondoMainMenu;

void setupMenus()
{
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
    lbi.setColorBackground(color(100));
  }*/
  //ListaUSB.setVisible(true);

  FondoMainMenu=loadImage("fotofuad.jpg");
  FondoMainMenu.resize(width, height);
}

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
void ShowStartMenu()
{
  background(FondoMainMenu);
}

void ShowMainMenu()
{
}




