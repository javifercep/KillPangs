class Player {
  float x, vel;
  int lives;
  boolean alive;
  TimeControl deadtime;
  Player() {
    x=width/2.;
    vel=0;
    lives=3;
    deadtime = new TimeControl();
    alive=true;
  } 
  void resetplayer() {
    vel=0;
    lives=3;
    x=5;
    alive=true;
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
  }

  void drawplayer(float h) {
    rectMode(CENTER);
    if (deadtime.EventTime()) fill(247, 220, 199);
    else fill(255, 0, 0);
    rect(x, h-10, 10, 20);
  }
  void killplayer() {
    if (deadtime.EventTime()) {
      lives--;
      deadtime.startTime(2000);
      if (lives<=0) alive=false;
    }
  }
  boolean asktimedead() {
    return deadtime.EventTime();
  }
  boolean askalive() {
    return alive;
  }
  int numliv() {
    return lives;
  }
  void ballkillplayer(Ball[] b, int nb) {
    for (int i=0; i<nb; i++) {
      if (b[i].ballask()) {
        if (PVector.dist(b[i].getpos(), new PVector(x, 500-15))<bulletrad+b[i].getrad()+5) {
          killplayer();
        }
      }
    }
  }
}
