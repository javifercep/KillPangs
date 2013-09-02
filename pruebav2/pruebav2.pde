import SimpleOpenNI.*;

import processing.serial.*;

float zmax;
float zmin;
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
  int displaysize=min(displayWidth, displayHeight);
  size(displaysize, displaysize, OPENGL);
  zmax=width*-2000/600.;
  zmin=200;
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
  cara[0].activesurface(4, 15);
  if (!kin.InitKinect())
    println("Faaaaail!");
}

void draw() {
  
  thrcontrol=true;
  //lefttex.camera(width/2.0+inv*dif+one.getposx(), height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0*width*-500/600., 0, 1, 0);
  //righttex.camera(width/2.0-inv*dif+one, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0*width*-500/600., 0, 1, 0);
  lefttex.camera(inv*dif+one.getposx(), one.getposy(), (height/2.0) / tan(PI*30.0 / 180.0), one.getposx(), one.getposy(), 0*width*-500/600., 0, 1, 0);
  righttex.camera(-inv*dif+one.getposx(), one.getposy(), (height/2.0) / tan(PI*30.0 / 180.0), one.getposx(), one.getposy(), 0*width*-500/600., 0, 1, 0);
  //one.setvelx(Ardu.getX()/50.);
  //one.setvely(Ardu.getY()/50.);
  if (Ardu.getSWTriggerState()==0) {
    one.shot(cara);
  }
  ///////////////////////////////
  drawall(lefttex);
  drawall(righttex);
  ////////////////////////////////////////
  one.updateshot(kin.getNeck());
  while (thrcontrol) {
  }
  for (int i=0; i<5;i++) {
    cara[i].updatesurface();
    if (cara[i].getz()>zmin) {
      cara[i].removesurface();
      one.loselive();
    }
  }
  if (cara[controlsur].getz()>zmax*3/4.) {
    controlsur++;
    controlsur%=5;
    cara[controlsur].activesurface(4, 15*controlsur);
  }
  shader(shader3D);
  rect(0, 0, width, height);
  resetShader();
  kin.update();
  kin.trackUserOne();
  //kin.showTrack();
  /*resetShader();
   noLights();
   fill(255);
   ellipse(width/2.0+mouseX/10.,height/2.0,30,30);
   ellipse(width/2.0-mouseX/10.,height/2.0,30,30);
   //image(lefttex,0,0, width, height);*/
  /*println(dif);
  println((height/2.0) / tan(PI*30.0 / 180.0));*/
}

void drawall(PGraphics cam) {
  cam.beginDraw();
  cam.background(0);
  cam.noStroke();
  cam.spotLight(247, 221, 164, width/2.0, 0, zmax/4., 0, 1, 0, PI, 2);
  cam.spotLight(247, 221, 164, width/2.0, 0, zmax*2/4., 0, 1, 0, PI, 2);
  cam.spotLight(247, 221, 164, width/2.0, 0, zmax*3/4., 0, 1, 0, PI, 2);
  cam.spotLight(247, 221, 164, width/2.0, 0, zmax, 0, 1, 0, PI, 2);
  cam.ambientLight(102, 102, 102);
  cam.fill(255);
  cuad1(cam);
  cuad2(cam);
  cuad3(cam);
  cuad4(cam);
  cam.fill(255);
  for (int i=0; i<5;i++) {
    cara[i].drawsurface(cam);
  }
  ellipse(width/2.0, height/2.0, 30, 30);
  cam.hint(DISABLE_DEPTH_TEST);
  cam.noLights();
  cam.fill(0, 145, 80);
  one.drawshot(cam);
  cam.hint(ENABLE_DEPTH_TEST);
  cam.lights();
  cam.endDraw();
}

void cuad1(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(0, 0, 2000);
  cam.vertex(0, 0, zmax);
  cam.vertex(0, width, zmax);
  cam.vertex(0, width, 2000);
  cam.endShape();
}

void cuad2(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(width, 0, 2000);
  cam.vertex(width, 0, zmax);
  cam.vertex(width, width, zmax);
  cam.vertex(width, width, 2000);
  cam.endShape();
}

void cuad3(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(0, 0, 2000);
  cam.vertex(0, 0, zmax);
  cam.vertex(width, 0, zmax);
  cam.vertex(width, 0, 2000);
  cam.endShape();
}

void cuad4(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(0, width, 2000);
  cam.vertex(0, width, zmax);
  cam.vertex(width, width, zmax);
  cam.vertex(width, width, 2000);
  cam.endShape();
}

