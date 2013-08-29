import processing.serial.*;

static final float zmax=-2000;
static final float zmin=200;
PImage faudo;
boolean thrcontrol=false;
surfaces cara[];
BallShit ballshit;
DataFromArduino Ardu = new DataFromArduino();
shoter one= new shoter();
PShader shader3D;
PGraphics lefttex;
PGraphics righttex;
int inv=1;
int controlsur=0;
float dif=0;
void setup() {
  size(600, 600, OPENGL);
  cara=new surfaces[5];
  for (int i=0; i<5;i++) {
    cara[i]=new surfaces();
  }

  ballshit = new BallShit("ball");
  ballshit.start();
  shader3D = loadShader("3d.glsl");
  lefttex = createGraphics(width, height, OPENGL);
  lefttex.noSmooth();
  righttex = createGraphics(width, height, OPENGL);
  righttex.noSmooth();
  shader3D.set("resolution", float(width), float(height));
  shader3D.set("LeftTex", lefttex);
  shader3D.set("RightTex", righttex);

  lefttex.noStroke();
  righttex.noStroke();
  cara[0].activesurface(4,15);
 
}

void draw() {
  thrcontrol=true;
  lefttex.camera(width/2.0+inv*14, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, -1000, 0, 1, 0);
  righttex.camera(width/2.0-inv*14, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, -1000, 0, 1, 0);

  one.setvelx(Ardu.getX()/50.);
  one.setvely(Ardu.getY()/50.);
  one.updateshot();
  ///////////////////////////////
  drawall(lefttex);
  drawall(righttex);
  ////////////////////////////////////////
  while (thrcontrol) {
  }
  for (int i=0; i<5;i++) {
    cara[i].updatesurface();
  }
  if (cara[controlsur].getz()>-1500) {
    controlsur++;
    controlsur%=5;
    cara[controlsur].activesurface(4,15);
  }
  shader(shader3D);
  rect(0, 0, width, height);
  /*resetShader();
  noLights();
  fill(255);
  ellipse(width/2.0+mouseX/10.,height/2.0,30,30);
  ellipse(width/2.0-mouseX/10.,height/2.0,30,30);
  //image(lefttex,0,0, width, height);*/
   println(dif);
}

void drawall(PGraphics cam) {
  cam.beginDraw();
  cam.background(0);
  cam.noStroke();
  cam.spotLight(255, 233, 0, 300, 0, -500, 0, 1, 0, PI, 2);
  cam.spotLight(255, 233, 0, 300, 0, -1000, 0, 1, 0, PI, 2);
  cam.spotLight(255, 233, 0, 300, 0, -1500, 0, 1, 0, PI, 2);
  cam.spotLight(255, 233, 0, 300, 0, -2000, 0, 1, 0, PI, 2);
  cam.ambientLight(102, 102, 102);
  cam.fill(255);
  cuad1(cam);
  cuad2(cam);
  cuad3(cam);
  cuad4(cam);
  cam.noLights();
  cam.fill(0, 255, 0);
  //one.drawshot(cam);
  cam.lights();
  cam.fill(255);
  for (int i=0; i<5;i++) {
    cara[i].drawsurface(cam);
  }
  ellipse(width/2.0,height/2.0,30,30);
  cam.endDraw();
}

void cuad1(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(0, 0, 200);
  cam.vertex(0, 0, -2000);
  cam.vertex(0, 600, -2000);
  cam.vertex(0, 600, 200);
  cam.endShape();
}

void cuad2(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(600, 0, 200);
  cam.vertex(600, 0, -2000);
  cam.vertex(600, 600, -2000);
  cam.vertex(600, 600, 200);
  cam.endShape();
}

void cuad3(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(0, 0, 200);
  cam.vertex(0, 0, -2000);
  cam.vertex(600, 0, -2000);
  cam.vertex(600, 0, 200);
  cam.endShape();
}

void cuad4(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(0, 600, 200);
  cam.vertex(0, 600, -2000);
  cam.vertex(600, 600, -2000);
  cam.vertex(600, 600, 200);
  cam.endShape();
}

