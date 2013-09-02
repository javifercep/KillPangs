class shoter {
  float posx, posy, velx=0, vely=0;
  int lives=3;
  shoter() {
    posx=250;
    posy=250;
  }
  void setvelx(float v) {
    velx=v;
  }
  void setvely(float v) {
    vely=v;
  }
  float getposx() {
    return posx;
  }

  float getposy() {
    return posy;
  }
  void updateshot() {
    posx+=velx;
    posy+=vely;
    if (posx>width) posx=width;
    if (posy>height) posy=height;
    if (posx<0) posx=0;
    if (posy<0) posy=0;
  }
  
   void updateshot(PVector vec) {
    PVector aux = new PVector(); 
    if(vec.x>600) aux.x = 600;
    else if(vec.x < -600) aux.x = -600;
    else aux.x = vec.x;
    if(vec.y>600) aux.y = 600;
    else if(vec.y < -600) aux.y = -600;
    else aux.y = vec.y;
    posx = map(aux.x,-600.,600.,0,width);
    posy = map(aux.y,-600.,600.,height,0);
    if (posx>width) posx=width;
    if (posy>height) posy=height;
    if (posx<0) posx=0;
    if (posy<0) posy=0;
  }
  
  void drawshot(PGraphics cam) {
    cam.ellipse(posx, posy, 10, 10);
  }
  void shot(surfaces face[]) {
    boolean onlyone=true;
    for (int i=0; i<5 && onlyone;i++) {
      if (face[i].surfaceask()) {
        for (int j=0; j<30 && onlyone; j++) {
          if (PVector.dist(face[i].surfuads[j].getpos(), new PVector(posx, posy))<face[i].surfuads[j].getrad()) {
            face[i].surfuads[j].removeball();
            onlyone=false;
          }
        }
      }
    }
  }
  void loselive() {
    lives--;
  }
}

