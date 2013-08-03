class Ball {
  float posx, posy, velx, vely;
  boolean activate;
  color ballcolor=color(0);
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
      fill(ballcolor);
      pushMatrix();
      translate(posx, posy);
      sphere(15);
      popMatrix();
    }
  }

  PVector getpos() {
    return new PVector(posx, posy);
  }

  void touch() {
    ballcolor=color(random(255), random(255), random(255));
  }
}


void ballshit() {
  while (true) {
    if (thrcontrol) {
      for (int n=numballs-1; n>=0; n--) {
        for (int m=0; m<n; m++) {
          if (PVector.dist(fuad[n].getpos(), fuad[m].getpos())<30) {
            fuad[n].touch();
            fuad[m].touch();
          }
        }
      }
      thrcontrol=false;
    }
  }
}

