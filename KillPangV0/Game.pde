
PImage fua;
int level = 0;

void ShowGame()
{
  thrcontrol=true;
  image(fua, 0, 0);
  textSize(38);
  smooth();
  fill(color(240, 20, 20));
  text("Level" + level, 150, 150);
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
  one.drawplayer( height*5/6.);
  one.ballkillplayer(fuad, numballs);
  fill(1, 67, 88);
  rectMode(CORNER);
  rect(0, height*5/6., width, height/6.);
  fill(255, 0, 0);
  text("Lives: "+one.numliv(), width*50/600., height*(5.6)/6.);
  lights();
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
  
  for (int i=0; i<numballs; i++) {
    if (fuad[i].ballask()) {
      fuad[i].drawball();
      fuad[i].ballupdate();
    }
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
  for (int i=0; i<5;i++) {
    bala[i].removebullet();
  }
  level++;
  int levelBalls = level;
  for (int i=0; i<levelBalls; i++) {
   fuad[i].activate(random(width*(ballrad/level)/600., width-width*(ballrad/level)/600.), random(width*(ballrad/level)/600., height*5/6.-width*(ballrad/level)/600.-height*30/600.), level*0.2*(random(-2, 2)), level*0.2*(random(-2, 2)), random(-.1, .1), random(-.1, .1), width*(ballrad/level)/600.);
  }
  fua = loadImage("level" + (level%3+1) + ".jpg");
  fua.resize(width, height);
  display.setControlDisplay(3);
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

