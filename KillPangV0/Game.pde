
PImage fua;

void ShowGame()
{
  /*ambientLight(40,40,40);
   directionalLight(126, 126, 126, 0, 0, -1);*/

  lights();
  //  TODO Apply transparency without changing color
  image(fua, 0,0);
  textSize(38);
  smooth();
  fill(color(240, 20, 20));
  text("Level" + level, 150,150);
  thrcontrol=true;
  if (Ardu.getDataFromBuffer())
  {
    if (Ardu.getSWTriggerState()==0) {
      for (int i=0; i<5; i++) {
        if (bala[i].bulletavailable()) {
          bala[i].activate(one.getpos());
          break;
        }
      }
    }
  }
  fill(255, 67, 23);
  for (int i=0; i<5; i++) {
    bala[i].drawbullet();
    bala[i].bulletupdate();
    bala[i].touchball(fuad, numballs);
    if (bala[i].gety()<=0) {
      bala[i].removebullet();
    }
  }
  fill(111, 55, 222);
  one.setvel(Ardu.getX()/50.);
  one.updateplayer();
  one.drawplayer(500);
  fill(1, 67, 88);
  rectMode(CORNER);
  rect(00, 500, 600, 100);
  //println(frameRate);

  for (int i=0; i<numballs; i++) {
    if (fuad[i].ballask()) {
      fuad[i].drawball();
      fuad[i].ballupdate();
    }
  }
<<<<<<< HEAD

  if (checkNumBalls(fuad, numballs)==numballs)
  {
    if (level >= maxLevel)
=======
  
  //end game or go to next level
  if(checkNumBalls(fuad, numballs)==numballs)
  {
    if(level >= maxLevel)
>>>>>>> origin/MrMartin
    {
      display.incControlDisplay();
      background(255);
      ballshit.quit();
    }
    else
    {
      nextLevel();
    }
  }
}

void InitGame()
{
  for (int i=0; i<5; i++) {
    bala[i]= new Bullet(10, 475);
  }
  for (int i=0; i<numballs; i++) {
    fuad[i]= new Ball();
<<<<<<< HEAD
    fuad[i].activate(random(15, 500), random(15, 400), 2*(random(-2, 2)), 2*(random(-2, 2)), random(-.1, .1), random(-.1, .1), ballrad);
=======
>>>>>>> origin/MrMartin
  }
  nextLevel();

  //thread("ballshit");
  println("Iniciando");
  ballshit = new BallShit("ball");
  ballshit.start();
  noStroke();
}
//next level increases number of balls and speed
void nextLevel()
{
  level++;
  int levelBalls = level*5;
  for (int i=0; i<levelBalls; i++) {
<<<<<<< HEAD
    fuad[i].activate(random(15, 500), random(15, 400), level*2*(random(-2, 2)), level*2*(random(-2, 2)), random(-.1, .1), random(-.1, .1), ballrad);
  }
  display.setControlDisplay(3);
}

=======
    fuad[i].activate(random(15, 500), random(15, 400), level*2*(random(-2, 2)), level*2*(random(-2, 2)),random(-.1, .1),random(-.1, .1),ballrad);
  }
  fua = loadImage("level" + level + ".jpg");
  fua.resize(width, height);
  display.setControlDisplay(3);
}
>>>>>>> origin/MrMartin
