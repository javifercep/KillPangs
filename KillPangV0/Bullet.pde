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
    if (on) {
      rect(posx, posy, 5, 5);
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
}

