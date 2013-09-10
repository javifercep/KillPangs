import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import SimpleOpenNI.*;

import processing.serial.*;
Minim minim;
AudioSample disparo;

float zmax;
float zmin;
PImage faudo;
boolean thrcontrol=false;
surfaces cara[];
BallShit3D ballshit;
DataFromArduino Ardu = new DataFromArduino();
shoter one= new shoter();
PShader shader3D;
PGraphics lefttex;
PGraphics righttex;
PGraphics center;
int inv=1;
int controlsur=0;
float dif=0;
int cal=1;
PImage mira;
float hallradx, hallrady;
void setup() {
  //int displaysize=min(displayWidth, displayHeight);
  size((int)(displayHeight*1.25), displayHeight, OPENGL);
  zmax=width*-2000/600.;
  zmin=200;
  hallradx=(width)/2.;
  hallrady=(height)/2.;
  cara=new surfaces[5];
  for (int i=0; i<5;i++) {
    cara[i]=new surfaces();
  }
  minim = new Minim(this);
  disparo = minim.loadSample("disparo.mp3", 2048);
  ballshit = new BallShit3D("ball");
  ballshit.start();
  mira = loadImage("mira.png");
  faudo = loadImage("faud.jpg");
  shader3D = loadShader("3d.glsl");
  lefttex = createGraphics(width, height, OPENGL);
  lefttex.noSmooth();
  righttex = createGraphics(width, height, OPENGL);
  righttex.noSmooth();
  center = createGraphics(width, height, OPENGL);
  center.noSmooth();
  shader3D.set("resolution", float(width), float(height));
  shader3D.set("LeftTex", lefttex);
  shader3D.set("RightTex", righttex);

  lefttex.noStroke();
  righttex.noStroke();
  center.noStroke();
  cara[0].activesurface(4, 15);
  if (!kin.InitKinect())
    println("Faaaaail!");
}




void draw() {
  println(frameRate);
  thrcontrol=true;
  lefttex.camera(inv*dif+one.getmanposx(), one.getmanposy(), (height/2.0) / tan(PI*30.0 / 180.0), one.getmanposx(), one.getmanposy(), width*-500/600., 0, 1, 0);
  righttex.camera(-inv*dif+one.getmanposx(), one.getmanposy(), (height/2.0) / tan(PI*30.0 / 180.0), one.getmanposx(), one.getmanposy(), width*-500/600., 0, 1, 0);
  center.camera(one.getmanposx(), one.getmanposy(), (height/2.0) / tan(PI*30.0 / 180.0), one.getmanposx(), one.getmanposy(), width*-500/600., 0, 1, 0);
  one.setvelx(Ardu.getX()/50.);
  one.setvely(Ardu.getY()/50.);
  if (Ardu.getSWTriggerState()==0) {
    one.shot(cara, center);
    //PVector mouse=kin.getHand();
    /*PVector mouse=one.getscreenpos();
     if (mouse.x>width || mouse.x<0 || mouse.y>width || mouse.y<0) {
     }
     else {
     //center.loadPixels();
     //color ct=center.pixels[(int)(mouse.x+mouse.y*width)];
     color ct= center.get((int)mouse.x,(int)mouse.y);
     if (ct!=color(0, 0, 0)) {
     cara[(int)green(ct)-1].surfuads[(int)blue(ct)-1].removeball();
     }
     }*/
  }
  ////////////////////////////////////////
  drawall(lefttex);
  drawall(righttex);
  drawallcenter(center);
  ////////////////////////////////////////
  //one.updateman();
  //one.updateshot();
  one.updateman(kin.getNeck());
  one.updateshot(kin.getHand());

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
  one.drawshot();
  kin.update();
  kin.trackUserOne();
  //kin.showTrack();
}

void drawall(PGraphics cam) {
  cam.beginDraw();
  cam.background(128);
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
  cam.endDraw();
}
void drawallcenter(PGraphics cam) {
  cam.beginDraw();
  cam.background(0);
  cam.noStroke();
  cam.fill(255);
  for (int i=0; i<5;i++) {
    cara[i].drawsurfacecenter(cam, i+1);
  }
  cam.endDraw();
}


void cuad1(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(width/2.-hallradx, height/2.-hallrady, 2000);
  cam.vertex(width/2.-hallradx, height/2.-hallrady, zmax);
  cam.vertex(width/2.-hallradx, height/2.+hallrady, zmax);
  cam.vertex(width/2.-hallradx, height/2.+hallrady, 2000);
  cam.endShape();
}

void cuad2(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(width/2.+hallradx, height/2.-hallrady, 2000);
  cam.vertex(width/2.+hallradx, height/2.-hallrady, zmax);
  cam.vertex(width/2.+hallradx, height/2.+hallrady, zmax);
  cam.vertex(width/2.+hallradx, height/2.+hallrady, 2000);
  cam.endShape();
}

void cuad3(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(width/2.-hallradx, height/2.-hallrady, 2000);
  cam.vertex(width/2.-hallradx, height/2.-hallrady, zmax);
  cam.vertex(width/2.+hallradx, height/2.-hallrady, zmax);
  cam.vertex(width/2.+hallradx, height/2.-hallrady, 2000);
  cam.endShape();
}

void cuad4(PGraphics cam) {
  cam.beginShape(QUADS);
  cam.vertex(width/2.-hallradx, height/2.+hallrady, 2000);
  cam.vertex(width/2.-hallradx, height/2.+hallrady, zmax);
  cam.vertex(width/2.+hallradx, height/2.+hallrady, zmax);
  cam.vertex(width/2.+hallradx, height/2.+hallrady, 2000);
  cam.endShape();
}



/*void mouseClicked() {
 
 
 if (cal==3) {
 kin.sety1(kin.getHandreal().y);
 cal++;
 }
 if (cal==2) {
 kin.setx1(kin.getHandreal().x);
 cal++;
 }
 if (cal==1) {
 kin.setx0y0(kin.getHandreal());
 cal++;
 }
 }*/
