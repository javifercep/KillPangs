void ShowGame()
{
  /*ambientLight(40,40,40);
   directionalLight(126, 126, 126, 0, 0, -1);*/

  lights();
  background(200);
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
      /* if (colorControl++ == 3) colorControl = 0;
       switch(colorControl)
       {
       case 0: 
       fill(blanco);
       break;
       case 1: 
       fill(rojo);
       break;
       case 2: 
       fill(verde);
       break;
       case 3: 
       fill(azul);
       break;
       }*/
>>>>>>> Added initial menu for choosing the COM port.
=======
>>>>>>> Chaos comes to us
    }
  }
  fill(255, 67, 23);
  for (int i=0; i<5; i++) {
    bala[i].drawbullet();
    bala[i].bulletupdate();
<<<<<<< HEAD
<<<<<<< HEAD
    bala[i].touchball(fuad, numballs);
=======
>>>>>>> Added initial menu for choosing the COM port.
=======
    bala[i].touchball(fuad, numballs);
>>>>>>> Chaos comes to us
    if (bala[i].gety()<=0) {
      bala[i].removebullet();
    }
  }
  fill(111, 55, 222);
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  one.setvel(Ardu.getX()*10.);
  one.updateplayer();
  one.drawplayer(500);
  fill(1, 67, 88);
  rectMode(CORNER);
  rect(00, 500, 600, 100);
  println(frameRate);
  fill(34, 64, 123);
  for (int i=0; i<numballs; i++) {
    if (fuad[i].ballask()) {
      fuad[i].drawball();
      fuad[i].ballupdate();
    }
  }
}

void InitGame()
{
  for (int i=0; i<5; i++) {
    bala[i]= new Bullet(10, 475);
  }
  for (int i=0; i<numballs; i++) {
    fuad[i]= new Ball(random(15, 500), random(15, 400), 2*(random(-2, 2)), 2*(random(-2, 2)));
    fuad[i].activate();
  }

  //thread("ballshit");
  println("Iniciando");
  ballshit = new BallShit("ball");
  ballshit.start();
  noStroke();
}

=======
  one.setvel(Ardu.getBinX()*10.);
=======
  one.setvel(Ardu.getX()*10.);
>>>>>>> Chaos comes to us
=======
  one.setvel(Ardu.getX()/50.);
>>>>>>> Game works!
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
  if(checkNumBalls(fuad, numballs)== numballs)
=======
  //end game or go to next level
  if(checkNumBalls(fuad, numballs)==numballs)
>>>>>>> Fotos intercaladas niveles intento-de
  {
    if(level >= maxLevel)
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

<<<<<<< HEAD
>>>>>>> Added initial menu for choosing the COM port.
=======
void InitGame()
{
  for (int i=0; i<5; i++) {
    bala[i]= new Bullet(10, 475);
  }
  for (int i=0; i<numballs; i++) {
<<<<<<< HEAD
<<<<<<< HEAD
    fuad[i]= new Ball();
    fuad[i].activate(random(15, 500), random(15, 400), 2*(random(-2, 2)), 2*(random(-2, 2)),random(-.1, .1),random(-.1, .1),ballrad);
=======
    fuad[i]= new Ball(random(15, 500), random(15, 400), level*2*(random(-2, 2)), level*2*(random(-2, 2)),random(-.1, .1),random(-.1, .1));
    fuad[i].activate();
>>>>>>> Primer commit! Niveles
=======
    fuad[i]= new Ball();
  }
<<<<<<< HEAD
  for (int i=0; i<levelBalls; i++) {
    fuad[i].activate(random(15, 500), random(15, 400), level*2*(random(-2, 2)), level*2*(random(-2, 2)),random(-.1, .1),random(-.1, .1),ballrad);
>>>>>>> Niveles funcionando
  }
=======
  nextLevel();
>>>>>>> Fotos intercaladas niveles intento-de

  thread("ballshit");
  noStroke();
}
<<<<<<< HEAD
<<<<<<< HEAD

<<<<<<< HEAD
>>>>>>> Chaos comes to us
=======
=======
>>>>>>> Niveles funcionando
=======
//next level increases number of balls and speed
>>>>>>> Fotos intercaladas niveles intento-de
void nextLevel()
{
  level++;
  int levelBalls = level*5;
  for (int i=0; i<levelBalls; i++) {
    fuad[i].activate(random(15, 500), random(15, 400), level*2*(random(-2, 2)), level*2*(random(-2, 2)),random(-.1, .1),random(-.1, .1),ballrad);
  }
  display.setControlDisplay(6);
}
<<<<<<< HEAD

>>>>>>> Primer commit! Niveles
=======
>>>>>>> Fotos intercaladas niveles intento-de
