import processing.serial.*;

int blanco = color(255);
int rojo = color(255, 0, 0);
int verde = color(0, 255, 0);
int azul = color(0, 0, 255);

int colorControl=0;

int numballs=30;

boolean thrcontrol=false;

Teclado Ardu = new Teclado();
Player one= new Player();
Bullet bala[]=new Bullet[5];
Ball fuad[]= new Ball[numballs];


void setup()
{
  size(600, 600, OPENGL);
  frameRate(60);
  for (int i=0; i<5; i++) {
    bala[i]= new Bullet(10, 475);
  }
  for (int i=0; i<numballs; i++) {
    fuad[i]= new Ball(random(15,500), random(15,400), 2*(random(-2, 2)), 2*(random(-2, 2)));
    fuad[i].activate();
    fuad[i].touch();
  }

  thread("ballshit");
  noStroke();
}

void draw()
{
  /*ambientLight(40,40,40);
   directionalLight(126, 126, 126, 0, 0, -1);*/
  
  lights();
  background(200);
  thrcontrol=true;
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
  fill(255, 67, 23);
  for (int i=0; i<5; i++) {
    bala[i].drawbullet();
    bala[i].bulletupdate();
    bala[i].touchball(fuad,numballs);
    if (bala[i].gety()<=0) {
      bala[i].removebullet();
    }
  }
  fill(111, 55, 222);
  one.setvel(Ardu.getX()*10.);
  one.updateplayer();
  one.drawplayer(500);
  fill(1, 67, 88);
  rectMode(CORNER);
  rect(00, 500, 600, 100);
  println(frameRate);
  fill(34, 64, 123);
  for (int i=0; i<numballs; i++) {
    if(fuad[i].ballask()){
      fuad[i].drawball();
      fuad[i].ballupdate();
    }
  }
}

