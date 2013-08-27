static final float zmax=-2000;
static final float zmin=200;
PImage faudo;
boolean thrcontrol=false;
surfaces cara;
BallShit ballshit;

void setup(){
  size(600,600,OPENGL);
  cara=new surfaces();
  cara.activesurface(4);
  ballshit = new BallShit("ball");
  ballshit.start();
}

void draw(){
  thrcontrol=true;
  while(thrcontrol){}
  background(0);
  spotLight(51, 102, 126, 300, 0, -500, 0, 1, 0, PI, 2);
  spotLight(51, 102, 126, 300, 0, -1000, 0, 1, 0, PI, 2);
  spotLight(51, 102, 126, 300, 0, -1500, 0, 1, 0, PI, 2);
  spotLight(51, 102, 126, 300, 0, -2000, 0, 1, 0, PI, 2);
  ambientLight(102, 102, 102);
  //stroke(0);
  //strokeWeight(4);
  fill(255);
  cuad1();
  cuad2();
  cuad3();
  cuad4();
  cara.drawsurface();
  cara.updatesurface();
}

void cuad1(){
  beginShape(QUADS);
  vertex(0,0,0);
  vertex(0,0,-2000);
  vertex(0,600,-2000);
  vertex(0,600,0);
  endShape();
}

void cuad2(){
  beginShape(QUADS);
  vertex(600,0,0);
  vertex(600,0,-2000);
  vertex(600,600,-2000);
  vertex(600,600,0);
  endShape();
}

void cuad3(){
  beginShape(QUADS);
  vertex(0,0,0);
  vertex(0,0,-2000);
  vertex(600,0,-2000);
  vertex(600,0,0);
  endShape();
}

void cuad4(){
  beginShape(QUADS);
  vertex(0,600,0);
  vertex(0,600,-2000);
  vertex(600,600,-2000);
  vertex(600,600,0);
  endShape();
}
