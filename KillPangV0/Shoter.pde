class shoter {
  float manposx, manposy, shotposx, shotposy, velx=0, vely=0, screenposx=0, screenposy=0, srx=0, sry=0;
  int lives=3;
  TimeControl reload;
  shoter() {
    shotposx=250;
    shotposy=250;
    reload= new TimeControl();
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
  void updateman() {//with velocity
    manposx+=velx;
    manposy+=vely;
    if (manposx>width/2.+hallradx) manposx=width/2.+hallradx;
    if (manposy>height/2.+hallrady) manposy=height/2.+hallrady;
    if (manposx<width/2.-hallradx) manposx=width/2.-hallradx;
    if (manposy<height/2.-hallrady) manposy=height/2.-hallrady;
  }
  void updateshot(PVector vec) {//with vector of position
    shotposx=manposx+vec.x-width/2.;
    shotposy=manposy+vec.y-height/2.;

    /*if (shotposx>width) shotposx=width;
     if (shotposy>height) shotposy=height;
     if (shotposx<0) shotposx=0;
     if (shotposy<0) shotposy=0;*/
    screenposx=vec.x;
    screenposy=vec.y;
  }
  void updateshot() {//with velocity
    screenposx+=velx;
    screenposy+=vely;
    if (screenposx>width) screenposx=width;
    if (screenposy>height) screenposy=height;
    if (screenposx<0) screenposx=0;
    if (screenposy<0) screenposy=0;
    shotposx=manposx+screenposx-width/2.;
    shotposy=manposy+screenposy-height/2.;
  }

  void updateman(PVector vec) {//with vector of position
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
    cam.imageMode(CENTER);
    cam.image(mira, shotposx, shotposy, 100, 100);
    //cam.ellipse(shotposx, shotposy, 10, 10);
  }
  void drawshot() {
    if(!reload.EventTime())tint(255,0,0);
    else tint(0,0,0);
    imageMode(CENTER);
    image(mira, screenposx, screenposy, 100, 100);
    //cam.ellipse(shotposx, shotposy, 10, 10);
    noTint();
  }
  void shot(surfaces face[], PGraphics center) {
    if (reload.EventTime()) {
      disparo.trigger();
      PVector mouse=getscreenpos();
      if (mouse.x>width || mouse.x<0 || mouse.y>width || mouse.y<0) {
      }
      else {
        center.loadPixels();
        //color ct=center.pixels[(int)(mouse.x+mouse.y*width)];
        color ct= center.get((int)mouse.x, (int)mouse.y);
        if (ct!=color(0, 0, 0)) {
          face[(int)green(ct)-1].surfuads[(int)blue(ct)-1].removeball();
          face[(int)green(ct)-1].removeball();
        }
      }
      reload.startTime(1000);
    }
  }
  void shot(surfaces face[]) {//deprecated
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
  int asklives(){
   return lives; 
  }
  void resetshoter(){
   lives=3; 
  }
}

