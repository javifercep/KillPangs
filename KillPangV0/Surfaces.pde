class surfaces {
  Ball surfuads[];
  float posz, velz;
  boolean activate;
  int numsurballs;
  int radio;
  int numactivateballs;
  surfaces () {
    surfuads= new Ball[30];
    for (int i=0; i<30; i++) {
      surfuads[i]= new Ball();
    }
  } 

  void activesurface(int nsbs, int rad, float vz, float v) {
    if (activate==false) {
      activate=true;
      posz=zmax;
      velz=vz;
      numsurballs=nsbs;
      numactivateballs=nsbs;
      radio=rad;
      genballs(v);
    }
  }
  void genballs(float v) {
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].activate(random( width*radio/600., width - width*radio/600.), random( width*radio/600., height- width*radio/600.), v*(random(-2, 2)), v*(random(-2, 2)), random(-.1, .1), random(-.1, .1), width*radio/600.);
    }
  }

  void updatesurface() {
    if (activate) {
      posz+=velz;
      for (int i=0; i<numsurballs; i++) {
        surfuads[i].ballupdatesurface();
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

  void drawsurfacecenter(PGraphics cam, int g) {
    if (activate) {
      for (int i=0; i<numsurballs; i++) {
        surfuads[i].drawballcenter(posz, cam, g, i+1);
      }
    }
  }
  void removesurface() {
    activate=false;
    //activesurface(4, radio);
  }
  void removeball(){
    numactivateballs--;
    if(numactivateballs<=0) {
      removesurface();
      nivel.deadface(); ////////////CUIDADO QUE NO PETE, NO CREO PERO NUNCA SE SABE
    }
  }
  float getz() {
    return posz;
  }
  boolean surfaceask() {
    return activate;
  }
  
  void resetsurface(){
    for(int i=0; i<30; i++){
      surfuads[i].resetball();
    }
    activate=false;
    posz=zmax;
  }
}

