
PImage fua;
int level = 0;

void ShowGame()
{
  thrcontrol=true;
  image(fua, 0, 0);
  textSize(38);
  smooth();
  fill(color(240, 20, 20));
  text("Level" + level, 150, 150);
  if (Ardu.getDataFromBuffer())
  {
    if (Ardu.getSWTriggerState()==0 && one.asktimedead()) {
      for (int i=0; i<5; i++) {
        if (bala[i].bulletavailable()) {
          bala[i].activate(one.getpos());
          break;
        }
      }
    }
  }
  for (int i=0; i<5; i++) {
    bala[i].drawbullet();
    bala[i].bulletupdate();
    bala[i].touchball(fuad, numballs);
    if (bala[i].gety()<=0) {
      bala[i].removebullet();
    }
  }
  one.setvel(Ardu.getX()/50.);
  one.updateplayer();
  one.drawplayer( height*5/6.);
  one.ballkillplayer(fuad, numballs);
  fill(1, 67, 88);
  rectMode(CORNER);
  rect(0, height*5/6., width, height/6.);
  fill(255, 0, 0);
  text("Lives: "+one.numliv(), width*50/600., height*(5.6)/6.);
  lights();
  //end game or go to next level
  if (checkNumBalls(fuad, numballs)==numballs)
  {
    if (level >= maxLevel)
    {
      gamesound.close();
      display.incControlDisplay();
      timing.stopTime();
      background(255);
      ballshit.quit();
    }
    else
    {
      nextLevel();
    }
  }
  if (one.askalive() == false) {
    gamesound.pause();
    display.setControlDisplay(6);
    timing.stopTime();
    background(255);
    ballshit.quit();
  }
  
  for (int i=0; i<numballs; i++) {
    if (fuad[i].ballask()) {
      fuad[i].drawball();
      fuad[i].ballupdate();
    }
  }
}

void InitGame()
{
  level=0;
  numPoints.clearPuntuation();
  timing.startTime();
  for (int i=0; i<5;i++) {
    bala[i].removebullet();
  }
  for (int i=0; i<numballs; i++) {
   fuad[i].resetball();
  }
  one.resetplayer();
  nextLevel();
  ballshit = new BallShit("ball");
  ballshit.start();
  noStroke();
  gamesound.rewind();
  gamesound.play();
}
//next level increases number of balls and speed
void nextLevel()
{
  for (int i=0; i<5;i++) {
    bala[i].removebullet();
  }
  fua = fuas[((level%15))];
  //fua.resize(width, height);
  level++;
  int levelBalls = level;
  for (int i=0; i<levelBalls; i++) {
   fuad[i].activate(random(width*(ballrad/level)/600., width-width*(ballrad/level)/600.), random(width*(ballrad/level)/600., height*5/6.-width*(ballrad/level)/600.-height*30/600.), level*0.2*(random(-2, 2)), level*0.2*(random(-2, 2)), random(-.1, .1), random(-.1, .1), width*(ballrad/level)/600.);
  }
  display.setControlDisplay(3);
}

void InitGameV2(){
  for(int i=0; i<numsurfaces; i++){
    cara[i].resetsurface();
  }
  two.resetshoter();
  controlsur=0;
  ballshit3d = new BallShit3D("ball");
  ballshit3d.start();
  cara[0].activesurface(4, 15);
  display.setControlDisplay(8);
}

void ShowGameV2(){
  thrcontrol=true;
  lefttex.camera(dif+two.getmanposx(), two.getmanposy(), (height/2.0) / tan(PI*30.0 / 180.0), two.getmanposx(), two.getmanposy(), width*-500/600., 0, 1, 0);
  righttex.camera(-dif+two.getmanposx(), two.getmanposy(), (height/2.0) / tan(PI*30.0 / 180.0), two.getmanposx(), two.getmanposy(), width*-500/600., 0, 1, 0);
  center.camera(two.getmanposx(), two.getmanposy(), (height/2.0) / tan(PI*30.0 / 180.0), two.getmanposx(), two.getmanposy(), width*-500/600., 0, 1, 0);
  //two.setvelx(Ardu.getX()/50.);
  //two.setvely(Ardu.getY()/50.);
  if (Ardu.getSWTriggerState()==0) {
    two.shot(cara, center);
  }
  drawall(lefttex);
  drawall(righttex);
  drawallcenter(center);
  two.updateman(kin.getNeck());
  two.updateshot(kin.getHand());
  for (int i=0; i<5;i++) {
    cara[i].updatesurface();
    if (cara[i].getz()>zmin) {
      cara[i].removesurface();
      two.loselive();
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
  two.drawshot();
  kin.update();
  kin.trackUserOne();
  if(two.asklives()<=0){
    display.setControlDisplay(6);
    background(255);
    ballshit3d.quit();
    imageMode(CORNER);
  }
}

void gameover() {
  background(fotoover);
  textSize(40);
  fill(255, 0, 0);
  textSize((int)width*38/600.);
  text("GAME OVER", 200, 200);
  Ardu.getDataFromBuffer();
  if (Ardu.getSWState()==0)
  {
    display.setControlDisplay(4);
  }
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
