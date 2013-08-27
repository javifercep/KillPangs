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
      velz=2;
      numsurballs=nsbs;
      genballs();
    }
  }

  void genballs() {
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].activate(random(15, 500), random(15, 500), 5*0.2*(random(-2, 2)), 5*0.2*(random(-2, 2)), random(-.1, .1), random(-.1, .1), 15);
    }
  }

  void updatesurface() {
    if (activate) {
      posz+=velz;
      for (int i=0; i<numsurballs; i++) {
        surfuads[i].ballupdate();
      }
      if(posz>zmin){
        removesurface();
        
      }
    }
  }
  void drawsurface() {
    if (activate) {
      for (int i=0; i<numsurballs; i++) {
        surfuads[i].drawball(posz);
      }
    }
  }
  void removesurface(){
    activate=false;
  }
}

