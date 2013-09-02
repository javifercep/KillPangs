class surfaces {
  Ball surfuads[];
  float posz, velz;
  boolean activate;
  int numsurballs;
  surfaces () {
    surfuads= new Ball[30];
    for (int i=0; i<30; i++) {
      surfuads[i]= new Ball();
    }
  } 

  void activesurface(int nsbs) {
    if (activate==false) {
      activate=true;
      posz=zmax;
      numsurballs=nsbs;
      genballs();
    }
  }

  void genballs() {
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].activate(random(15, 500), random(15, 500), level*0.2*(random(-2, 2)), level*0.2*(random(-2, 2)), random(-.1, .1), random(-.1, .1), 15);
    }
  }

  void updatesurface() {
    posz+=velz;
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].ballupdate();
    }
  }
  void drawsurface() {
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].drawball(posz);
    }
  }
}

