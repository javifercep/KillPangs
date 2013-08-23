class Bullet {
  float posx, iniy, posy, vel;
  boolean on;
  Bullet(float v, int y) {
    vel=v;
    iniy=y;
  }
  boolean bulletavailable() {
    return !on;
  }
  void activate(float x) {
    if (!on) {
      on=true; 
      posx=x;
      posy=iniy;
    }
  }
  void bulletupdate() {
    posy-=vel;
  }
  void drawbullet() {
    rectMode(CENTER);
    if (on) {
      fill(255);
      rect(posx, posy, bulletrad+bulletrad, bulletrad+bulletrad);
    }
  }

  void removebullet() {
    on=false; 
    posy=iniy;
  }

  float gety() {
    return posy;
  }
  float getx() {
    return posx;
  }
  void touchball(Ball[] b, int nb) {
    if (on) {
      for (int i=0; i<nb; i++) {
        if (b[i].ballask()) {
          if (PVector.dist(b[i].getpos(), new PVector(posx, posy))<bulletrad+b[i].getrad()) {
            removebullet();
            b[i].removeball();
          }
        }
      }
    }
  }
}

