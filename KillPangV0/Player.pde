class Player {
  float x, vel;
  Player() {
    x=width/2.;
    vel=0;
  } 
  void setvel(float v) {
    vel=v;
  }
  float getpos() {
    return x;
  }
  void updateplayer() {
    x+=vel;
    if (x<5) x=5;
    if (x+5>width) x=width-5;
    //println(x);
  }

  void drawplayer(float h) {
    rectMode(CENTER);
    fill(247, 220, 199);
    rect(x, h-10, 10, 20);
  }
}

