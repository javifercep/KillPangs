class Teclado {
  int px, py, swon;
  Teclado() {
    px=0;
    py=0;
    swon=1;
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
}

void keyPressed() {
  if (keyCode==UP) {
    Ardu.setY(-1);
  }
  else if (keyCode==DOWN) {
    Ardu.setY(1);
  }

  if (keyCode==LEFT) {
    Ardu.setX(-1);
  }
  else if (keyCode==RIGHT) {
    Ardu.setX(1);
  }
}


void keyReleased() {
  if (keyCode==LEFT) {
    Ardu.setX(0);
  }
  else if (keyCode==RIGHT) {
    Ardu.setX(0);
  }
  if (keyCode==UP) {
    Ardu.setY(0);
  }
  else if (keyCode==DOWN) {
    Ardu.setY(0);
  }

  if (key==' ') {
    Ardu.setSWState(0);
  }
}

