class shoter {
  float posx, posy, velx=0, vely=0;
  shoter() {
    posx=250;
    posy=250;
  }
  void setvelx(float v) {
    velx=v;
  }
  void setvely(float v) {
    vely=v;
  }
  void updateshot() {
    posx+=velx;
    posy+=vely;
    if(posx>600) posx=600;
    if(posy>600) posy=600;
    if(posx<0) posx=0;
    if(posy<0) posy=0;
  }
  void drawshot(PGraphics cam){
   cam.ellipse(posx,posy,10,10); 
  }
}

