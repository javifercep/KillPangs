class Ball {
  float posx, posy, velx, vely;
  boolean activate;
  Ball(float x, float y, float vx, float vy) {
    posx=x;
    posy=y;
    velx=vx;
    vely=vy;
  }
  boolean ballavailable() {
    return !activate;
  }
  void activate() {
    if (!activate) {
      activate=true;
    }
  }

  void ballupdate() {
    posy-=vely;
    posx-=velx;
    if (posx-15<0 || posx+15>width) velx*=-1;
    if (posy-15<0 || posy+15>500) vely*=-1;
  }

  void drawball() {
    if (activate) {
      pushMatrix();
      translate(posx, posy);
      sphere(15);
      popMatrix();
    }
  }
}

