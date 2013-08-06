class DataFromArduino {
  int px, py, swon;
  boolean pushed;
  DataFromArduino() {
    px=0;
    py=0;
    swon=1;
    pushed=false;
  }
  void setX(int t) {
    px=t;
  }
  void setY(int t) {
    py=t;
  }
  void setSWState(int t) {
    swon=t;
  }
  int getX() {
    return px;
  }
  int getY() {
    return py;
  }
  int getSWState() {
    int temp=swon;
    if (swon==0) swon=1;
    return temp;
  }
  boolean getDataFromBuffer(){
    boolean temp;
    temp=pushed;
    if(pushed)pushed=false;
    return temp;
    
  }
  void setPushed(){
    pushed=true;
  }
}

void keyPressed() {
  if (keyCode==UP) {
    Ardu.setY(-1);
    Ardu.setPushed();
  }
  else if (keyCode==DOWN) {
    Ardu.setY(1);
    Ardu.setPushed();
  }

  if (keyCode==LEFT) {
    Ardu.setX(-1);
    Ardu.setPushed();
  }
  else if (keyCode==RIGHT) {
    Ardu.setX(1);
    Ardu.setPushed();
  }
}


void keyReleased() {
  if (keyCode==LEFT) {
    Ardu.setX(0);
    Ardu.setPushed();
  }
  else if (keyCode==RIGHT) {
    Ardu.setX(0);
    Ardu.setPushed();
  }
  if (keyCode==UP) {
    Ardu.setY(0);
    Ardu.setPushed();
  }
  else if (keyCode==DOWN) {
    Ardu.setY(0);
    Ardu.setPushed();
  }

  if (key==' ') {
    Ardu.setSWState(0);
    Ardu.setPushed();
  }
}

