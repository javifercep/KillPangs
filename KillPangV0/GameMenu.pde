import ddf.minim.*;

PImage img;
PImage faudo;
PImage fuas[];
PImage fotoover;
PShape[] faud;
float y=0, x=0;
float[][] aleatorio;
float[][] posiciones;
Minim minim;
AudioPlayer kick;
AudioPlayer gamesound;
float counter;
float sumador;
PImage FondoMainMenu, FondoStartMenu;
String[] USBdisponible;
PShader shaderfondo;
PGraphics graphfondo;

String ranking[][];

void InitConfigurations()
{
  /*Here you can load all images and throw all the threads that you want*/
  minim = new Minim(this);
  kick = minim.loadFile("gasolina.mp3", 1024);
  gamesound=minim.loadFile("sexy.mp3",1024);
  disparo = minim.loadSample("disparo.mp3", 2048);
  shaderfondo = loadShader("fondo.glsl");
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
  mira = loadImage("mira.png");
  fotoover=loadImage("fuadover.jpg");
  fotoover.resize(width, height);
  img = loadImage("fondo.jpeg");
  img.resize(width, height);
  bulletrad = height*2.5/600.;
  faudo = loadImage("faud.jpg");
  fuas=new PImage[15];
  zmax=width*-2000/600.;
  zmin=200;
  hallradx= (width)/2.;
  hallrady=(height)/2.;
  two= new shoter();
  for (int i=0; i<numsurfaces;i++) {
    cara[i]=new surfaces();
  }
  for(int i=0; i<15; i++){
    fuas[i] = loadImage("level" + (i+1) + ".jpg");
    fuas[i].resize(width, height);
  }
  for (int i=0; i<5; i++) {
    bala[i]= new Bullet(height*10/600.,  height*5/6.-15);
  }
  for (int i=0; i<numballs; i++) {
    fuad[i]= new Ball();
  }
  if (!kin.InitKinect())
    println("Faaaaail!");
}
void setupMenus()
{

  USBdisponible = joystickCOM.list();
  FondoStartMenu=loadImage("fotofuad.jpg");
  FondoStartMenu.resize(width, height);
  background(FondoStartMenu);
  FondoMainMenu=loadImage("fuad.png");
  FondoMainMenu.resize(width, height);
  InitConfigurations();
}

void ShowStartMenu()
{
  textSize((int)width*38/600.);
  smooth();
  fill(color(240, 80, 50));
  text("Select an Option: ", width*150/600., height*150/600.);
  for (int i=0; i<USBdisponible.length; i++)
  {
    fill(color(240, 80, 50));
    text("Option "+Integer.toString(i+1)+": "+ USBdisponible[i], width*150/600., height*(250+100*i)/600.);
  }
}

int choosegame=0;
void ShowMainMenu()
{
  textSize((int)width*38/600.);
  smooth();
  fill(color(240, 20, 20));
  text("KILL F.. PANG!!", width*150/600., height*150/600.);
  text("PULSE START", width*150/600., height*400/600.);
  namePlayer.writingName();
  if(namePlayer.getnameWrited()){
    /*if(!(trygame==0)){
      rectMode(CENTER);
      rect(150+50*trygame,520, 100,40);
    }*/
    if(Ardu.getX()>0) choosegame=1;
    else if(Ardu.getX()<0) choosegame=-1;
    if(Ardu.getSWTriggerState()==0){
      if(choosegame==-1) display.setControlDisplay(2);
      if(choosegame==1)display.setControlDisplay(7);
    }
  }
  noStroke();
  if(choosegame==-1) fill(color(240, 20, 20));
  else fill(color(0, 0, 0));
  text("Game V1", width*170/600., height*500/600.);
  if(choosegame==1) fill(color(240, 20, 20));
  else fill(color(0, 0, 0));
  text("Game V2", width*330/600., height*500/600.);
}

void addranking(String name, int point, int ngame) {
  BufferedReader reader;
  String line;
  PrintWriter output;
  int shownum=0;
  boolean stop=true;
  if(ngame==-1)reader = createReader("data/Ranking.txt");
  else if(ngame==1) reader = createReader("data/RankingV2.txt");
  else reader = createReader("");
  output = createWriter("data/temporal");
  while (stop) {
    try {
      line = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line==null) stop=false;
    else {
      String inf[]= split(line, ' ');
      if (Integer.parseInt(inf[1])<point) {
        output.println(name + " " + point);
        if (shownum<10) {
          ranking[shownum][0]=name;
          ranking[shownum][1]=point+"";
          shownum++;
        }
        point=-1;
      }
      output.println(inf[0] + " " + inf[1]);
      if (shownum<10) {
        ranking[shownum][0]=inf[0];
        ranking[shownum][1]=inf[1];
        shownum++;
      }
    }
  }
  if (point>0) {
    output.println(name + " " + point);
    if (shownum<10) {
      ranking[shownum][0]=name;
      ranking[shownum][1]=point+"";
      shownum++;
    }
  }
  output.flush();
  output.close();
  String ranktemp[] = loadStrings("data/temporal");
  if(ngame==-1)saveStrings("data/Ranking.txt", ranktemp);
  if(ngame==1) saveStrings("data/RankingV2.txt", ranktemp);
  File file = sketchFile("data/temporal");
  file.delete();
}

void InitHighScoreMenu()
{
  sumador = -20;
  counter = 0;
  noStroke();
  fill(255);
  faud = new PShape[8];

  for (int i=0; i<8;i++) {
    faud[i]=createShape(SPHERE, height*45/600.);
    faud[i].setTexture(faudo);
  }

  aleatorio = new float[2][8];
  for (int i=0;i<2;i++) {
    for (int j=0; j<8;j++) {
      aleatorio[i][j] = random(-3.14, 3.14);
    }
  }
  posiciones = new float[2][8];
  for (int i=0;i<2;i++) {
    for (int j=0; j<8;j++) {
      posiciones[i][j] = random(-3.14, 3.14);
    }
  }
  kick.rewind();
  kick.play();

  fill(255);
  sphereDetail(20);
  graphfondo = createGraphics(width, height, OPENGL);
  graphfondo.noSmooth();
  graphfondo.beginDraw();
  graphfondo.image(img, 0, 0, width, height);
  graphfondo.endDraw();
  shaderfondo.set("resolution", float(graphfondo.width), float(graphfondo.height)); 
  shaderfondo.set("mask", graphfondo);  
  background(255);
  ranking=new String[10][2];
  addranking(namePlayer.getName(), (int)(numPoints.getPuntuation()*timing.getMul()),choosegame);
  choosegame=0;
}
void ShowHighScoreMenu()
{
  graphfondo.beginDraw();
  graphfondo.shader(shaderfondo);
  graphfondo.rect(0, 0, graphfondo.width, graphfondo.height);
  graphfondo.endDraw();
  image(graphfondo, 0, 0, width, height);
  stroke(0);
  textSize((int)width*38/600.);
  text("Ranking", width*200/600., height*100/600., 0);
  for (int i=0; i<ranking.length; i++) {
    text(ranking[i][0]+' '+ranking[i][1], width*200/600., height*(160+i*40)/600., 0);
  }
  translate( width*100/600., height*70/600., 0);
  for (int i=0;i<2;i++) {
    pushMatrix();
    for (int j=0; j<4;j++) {
      pushMatrix();
      rotateX(posiciones[0][4*i+j]+=(aleatorio[0][4*i+j])/50);
      rotateY(posiciones[1][4*i+j]+=(aleatorio[1][4*i+j])/50);
      shape(faud[4*i+j]);
      popMatrix();
      translate(0, height*150/600., 0);
    } 
    popMatrix();
    translate(width*400/600., 0, 0);
  }

  Ardu.getDataFromBuffer();
  if (Ardu.getSWState()==0)
  {
    kick.pause();
    background(FondoMainMenu);
    namePlayer.restart();
    display.setControlDisplay(1);
    Ardu.resetAll();
  }
}
void keyTyped()
{
  if (key=='1')
  { 
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>0)
      {
        InitJoystickCOM(USBdisponible[0]);
      }
    }
  }
  if (key=='2')
  {
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>1)
      {
        InitJoystickCOM(USBdisponible[1]);
      }
    }
  }
  if (key=='3')
  {
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>2)
      {
        InitJoystickCOM(USBdisponible[2]);
      }
    }
  }
  if (key=='4')
  {
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>3)
      {
        InitJoystickCOM(USBdisponible[3]);
      }
    }
  }
  if (key=='5')
  {
    if (display.getControlDisplay()==0)
    {
      if (USBdisponible.length>4)
      {
        InitJoystickCOM(USBdisponible[4]);
      }
    }
  }
}

