void ShowGame()
{
  /*ambientLight(40,40,40);
   directionalLight(126, 126, 126, 0, 0, -1);*/

  lights();
  background(200);
  thrcontrol=true;
  if (Ardu.getDataFromBuffer())
  {
    if (Ardu.getSWState()==0) {
      for (int i=0; i<5; i++) {
        if (bala[i].bulletavailable()) {
          bala[i].activate(one.getpos());
          break;
        }
      }
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
    }
  }
  fill(255, 67, 23);
  for (int i=0; i<5; i++) {
    bala[i].drawbullet();
    bala[i].bulletupdate();
    if (bala[i].gety()<=0) {
      bala[i].removebullet();
    }
  }
  fill(111, 55, 222);
  one.setvel(Ardu.getBinX()*10.);
  one.updateplayer();
  one.drawplayer(500);
  fill(1, 67, 88);
  rect(00, 500, 600, 100);
  //println(frameRate);
  fill(34, 64, 123);
  for (int i=0; i<numballs; i++) {
    fuad[i].drawball();
    fuad[i].ballupdate();
  }
}

