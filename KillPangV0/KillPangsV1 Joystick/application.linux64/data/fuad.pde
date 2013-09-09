import ddf.minim.*;

PImage img;
PImage faud;
PShape[] fuad;
float y=0, x=0;
float[][] aleatorio;
float[][] posiciones;
Minim minim;
AudioPlayer kick;
int counter;

void setup() {
  counter = 0;
  size(515, 515, OPENGL); 
  fuad = new PShape[16];
  noStroke();

  faud = loadImage("faud.jpg");
  for (int i=0; i<16;i++) {
    fuad[i]=createShape(SPHERE, 45);
    fuad[i].setTexture(faud);
  }

  aleatorio = new float[2][16];
  for (int i=0;i<2;i++) {
    for (int j=0; j<16;j++) {
      aleatorio[i][j] = 0;
    }
  }
  posiciones = new float[2][16];
  for (int i=0;i<2;i++) {
    for (int j=0; j<16;j++) {
      posiciones[i][j] = 0;
    }
  }
  
  minim = new Minim(this);
  kick = minim.loadFile("gasolina.mp3",2048);
  kick.play();
  
  img = loadImage("fondo.jpeg");
  image(img,0,0,width,height);
  
  sphereDetail(20);
}

void draw() {
  if (counter == 1) {
    loadPixels();
    for(int i = 0; i <width*height; i++) {
      color c = pixels[i];
      color c2 = color((red(c)+random(0,3))%255,(green(c)+random(0,3))%255,(blue(c)+random(0,3))%255);
      pixels[i] = c2;
    }
     updatePixels();
    counter = 0;
  }
  translate(60, 60, 0);
  for (int i=0;i<4;i++) {
    pushMatrix();
    for (int j=0; j<4;j++) {
      pushMatrix();
      shape(fuad[4*i+j]);
      popMatrix();
      translate(0, 130, 0);
    } 
    popMatrix();
    translate(130, 0, 0);
  }
  println(frameRate);
  ++counter;
}

void stop()
{
  kick.close();
  minim.stop();
  super.stop();
}
