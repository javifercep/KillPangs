
PImage fua;
int level = 0;

void ShowGame()
{
  image(fua, 0, 0);
  textSize(38);
  smooth();
  fill(color(240, 20, 20));
  text("Level" + level, 150, 150);
  thrcontrol=true;
  if (Ardu.getDataFromBuffer())
  {
    if (Ardu.getSWTriggerState()==0 && one.asktimedead()) {
      for (int i=0; i<5; i++) {
        if (bala[i].bulletavailable()) {
          bala[i].activate(one.getpos());
          break;
        }
      }
    }
  }
  for (int i=0; i<5; i++) {
    bala[i].drawbullet();
    bala[i].bulletupdate();
    bala[i].touchball(fuad, numballs);
    if (bala[i].gety()<=0) {
      bala[i].removebullet();
    }
  }
  one.setvel(Ardu.getX()/50.);
  one.updateplayer();
  one.drawplayer(500);
  one.ballkillplayer(fuad, numballs);
  fill(1, 67, 88);
  rectMode(CORNER);
  rect(0, 500, 600, 100);
  fill(255,0,0);
  text("Lives: "+one.numliv(),50,560);
  lights();

  for (int i=0; i<numballs; i++) {
    if (fuad[i].ballask()) {
      fuad[i].drawball(0);
      fuad[i].ballupdate();
    }
  }

  //end game or go to next level
  if (checkNumBalls(fuad, numballs)==numballs)
  {
    if (level >= maxLevel)
    {
      display.incControlDisplay();
      timing.stopTime();
      background(255);
      ballshit.quit();
    }
    else
    {
      nextLevel();
    }
  }
  if (one.askalive() == false) {
    display.setControlDisplay(6);
    timing.stopTime();
    background(255);
    ballshit.quit();
  }
}

void InitGame()
{
  level=0;
  numPoints.clearPuntuation();
  timing.startTime();
  nextLevel();
  ballshit = new BallShit("ball");
  ballshit.start();
  noStroke();
  for (int i=0; i<5;i++) {
    bala[i].removebullet();
  }
  one.resetplayer();
}
//next level increases number of balls and speed
void nextLevel()
{
  level++;
  int levelBalls = level;
  for (int i=0; i<levelBalls; i++) {
    fuad[i].activate(random(15, 500), random(15, 400), level*0.2*(random(-2, 2)), level*0.2*(random(-2, 2)), random(-.1, .1), random(-.1, .1), ballrad/level);
  }
  fua = loadImage("level" + (level%3+1) + ".jpg");
  fua.resize(width, height);
  display.setControlDisplay(3);
  for (int i=0; i<5;i++) {
    bala[i].removebullet();
  }
}

void gameover() {
  background(0);
  textSize(40);
  fill(255, 0, 0);
  text("GAME OVER", 200, 200);
  Ardu.getDataFromBuffer();
  if (Ardu.getSWTriggerState()==0)
  {
    display.setControlDisplay(4);
  }
}

