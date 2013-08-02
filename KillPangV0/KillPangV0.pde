import processing.serial.*;

int blanco = color(255);
int rojo = color(255, 0, 0);
int verde = color(0, 255, 0);
int azul = color(0, 0, 255);

int colorControl=0;

Teclado Ardu = new Teclado();
Player one= new Player();
Bullet bala[]=new Bullet[5];


void setup()
{
  size(600, 600);
  frameRate(60);
  for (int i=0; i<5; i++) {
    bala[i]= new Bullet(10, 475);
  }
}

void draw()
{
  background(0);
  if (Ardu.getSWState()==0) {
    for (int i=0; i<5; i++) {
      if (bala[i].bulletavailable()) {
        bala[i].activate(one.getpos());
        break;
      }
    }
    if (colorControl++ == 3) colorControl = 0;
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
    }
  }
  for (int i=0; i<5; i++) {
    bala[i].drawbullet();
    bala[i].bulletupdate();
    if (bala[i].gety()<=0) {
      bala[i].removebullet();
    }
  }
  one.setvel(Ardu.getX()*10.);
  one.updateplayer();
  one.drawplayer(500);
  rect(00, 500, 600, 100);
  println(frameRate);
}

