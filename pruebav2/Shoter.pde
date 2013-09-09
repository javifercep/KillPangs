class shoter {
  float manposx, manposy, shotposx, shotposy, velx=0, vely=0, screenposx=0, screenposy=0;
  int lives=3;
  PImage mira;
  shoter() {
    shotposx=250;
    shotposy=250;
    mira = loadImage("mira.png");
  }
  void setvelx(float v) {
    velx=v;
  }
  void setvely(float v) {
    vely=v;
  }
  float getmanposx() {
    return manposx;
  }

  float getmanposy() {
    return manposy;
  }

  float getshotposx() {
    return shotposx;
  }

  float getshotposy() {
    return shotposy;
  }

  PVector getscreenpos() {
    return new PVector((int)screenposx, (int)screenposy);
  }
  void updateman() {
    manposx+=velx;
    manposy+=vely;
    if (manposx>width) manposx=width;
    if (manposy>height) manposy=height;
    if (manposx<0) manposx=0;
    if (manposy<0) manposy=0;
  }
  void updateshot(PVector vec) {
    shotposx=manposx+vec.x-width/2.;
    shotposy=manposy+vec.y-height/2.;
    /*if (shotposx>width) shotposx=width;
     if (shotposy>height) shotposy=height;
     if (shotposx<0) shotposx=0;
     if (shotposy<0) shotposy=0;*/
  }
  void updateshot() {
    screenposx+=velx;
    screenposy+=vely;
    if (screenposx>width) screenposx=width;
    if (screenposy>height) screenposy=height;
    if (screenposx<0) screenposx=0;
    if (screenposy<0) screenposy=0;
    shotposx=manposx+screenposx-width/2.;
    shotposy=manposy+screenposy-height/2.;
  }

  void updateman(PVector vec) {
    PVector aux = new PVector(); 
    if (vec.x>600) aux.x = 600;
    else if (vec.x < -600) aux.x = -600;
    else aux.x = vec.x;
    if (vec.y>600) aux.y = 600;
    else if (vec.y < -600) aux.y = -600;
    else aux.y = vec.y;
    manposx = map(aux.x, -600., 600., 0, width);
    manposy = map(aux.y, -600., 600., height, 0);
    if (manposx>width) manposx=width;
    if (manposy>height) manposy=height;
    if (manposx<0) manposx=0;
    if (manposy<0) manposy=0;
  }

  void drawshot(PGraphics cam) {
    //imageMode(CENTER);
    //cam.image(mira,shotposx, shotposy, 30, 30);
    cam.ellipse(shotposx, shotposy, 10, 10);
  }
  void shot(surfaces face[]) {
    boolean onlyone=true;
    for (int i=0; i<5 && onlyone;i++) {
      if (face[i].surfaceask()) {
        for (int j=0; j<30 && onlyone; j++) {
          if (PVector.dist(face[i].surfuads[j].getpos(), new PVector(shotposx, shotposy))<face[i].surfuads[j].getrad()) {
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

