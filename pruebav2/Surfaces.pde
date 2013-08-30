class surfaces {
  Ball surfuads[];
  float posz, velz;
  boolean activate;
  int numsurballs;
  int radio;
  surfaces () {
    surfuads= new Ball[30];
    for (int i=0; i<30; i++) {
      surfuads[i]= new Ball();
    }
  } 

  void activesurface(int nsbs, int rad) {
    if (activate==false) {
      activate=true;
      posz=zmax;
      velz=2;
      numsurballs=nsbs;
      radio=rad;
      genballs();
    }
  }

  void genballs() {
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].activate(random(15, 500), random(15, 500), 5*0.2*(random(-2, 2)), 5*0.2*(random(-2, 2)), random(-.1, .1), random(-.1, .1), radio);
    }
  }

  void updatesurface() {
    if (activate) {
      posz+=velz;
      for (int i=0; i<numsurballs; i++) {
        surfuads[i].ballupdate();
      }
    }
  }
  void drawsurface(PGraphics cam) {
    if (activate) {
      for (int i=0; i<numsurballs; i++) {
        surfuads[i].drawball(posz, cam);
      }
    }
  }
  void removesurface() {
    activate=false;
    activesurface(4, radio);
  }
  float getz() {
    return posz;
  }
  boolean surfaceask() {
    return activate;
  }
}

