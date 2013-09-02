Serial joystickCOM;
String dataReceived = ""; // Incoming serial data
boolean conected=false;

public void InitJoystickCOM(String portName)
{
  if (conected)
  {
    println("Desconectando...");
    joystickCOM.clear();
    joystickCOM.stop();
  }
  println("Conectando al puerto "+portName);
  println("CONECTADO");
  conected=true;
  //ListaUSB.hide();
  //ListaUSB.setVisible(true);
  display.setControlDisplay(1);
  background(FondoMainMenu);
}


class DataFromArduino {
  int px, py, swon, swtrigger, pby, pbx;
  boolean pushed;
  DataFromArduino() {
    px=0;
    py=0;
    pbx=0;
    pby=0;
    swon=1;
    swtrigger = 1;
    pushed=false;
  }
  void setX(int t) {
    px=t;
  }
  void setY(int t) {
    py=t;
  }
  void setBinY(int t) {
    pby=t;
  }
  void setBinX(int t) {
     pbx=t;
  }
  void setSWState(int t) {
    swon=t;
  }
  void setSWTriggerState(int t) {
    swtrigger=t;
  }
  int getX() {
    return px;
  }
  int getY() {
    return py;
  }
  int getBinY() {
    return pby;
  }
  int getBinX() {
    return pbx;
  }
  int getSWState() {
    int temp=swon;
    if (swon==0) swon=1;
    return temp;
  }
  int getSWTriggerState() {
    int temp=swtrigger;
    if (swtrigger==0) swtrigger=1;
    return temp;
  }
  boolean getDataFromBuffer() {
    boolean temp;
    temp=pushed;
    if (pushed)pushed=false;
    return temp;
  }
  void setPushed() {
    pushed=true;
  }
}

void keyPressed() {
  if (keyCode==UP) {
    Ardu.setY(-1023);
    Ardu.setBinY(-1);
    Ardu.setPushed();
  }
  else if (keyCode==DOWN) {
    Ardu.setY(1023);
    Ardu.setBinY(1);
    Ardu.setPushed();
  }

  if (keyCode==LEFT) {
    Ardu.setX(-1023);
    Ardu.setBinX(-1);
    Ardu.setPushed();
  }
  else if (keyCode==RIGHT) {
    Ardu.setX(1023);
    Ardu.setBinX(1);
    Ardu.setPushed();
  }
}


void keyReleased() {
  if (keyCode==LEFT) {
    Ardu.setX(0);
    Ardu.setBinX(0);
    Ardu.setPushed();
  }
  else if (keyCode==RIGHT) {
    Ardu.setX(0);
    Ardu.setBinX(0);
    Ardu.setPushed();
  }
  if (keyCode==UP) {
    Ardu.setY(0);
    Ardu.setBinY(0);
    Ardu.setPushed();
  }
  else if (keyCode==DOWN) {
    Ardu.setY(0);
    Ardu.setBinY(0);
    Ardu.setPushed();
  }

  if (key==' ') {
    Ardu.setSWState(0);
    Ardu.setPushed();
  }

  if (key=='z') {
    Ardu.setSWTriggerState(0);
    Ardu.setPushed();
  }
}

