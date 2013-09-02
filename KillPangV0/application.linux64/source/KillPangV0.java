import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class KillPangV0 extends PApplet {




public void setup()
{
  int displaysize=min(displayWidth, displayHeight);
  size(displaysize, displaysize, OPENGL);
  frameRate(60);
  setupMenus();
  display.setControlDisplay(1);  
}

public void draw()
{
  display.ShowDisplay();
}

class Ball {
  float posx, posy, velx, vely, rotx=0 ,roty=0, velrx, velry, rad;
  boolean activate;
  int ballcolor=color(0);
  PShape obj;
  Ball() {
    activate=false;
  }
  public boolean  ballavailable() {
    return !activate;
  }
  public boolean ballask() {
    return activate;
  }
  public void activate(float x, float y, float vx, float vy,float wx,float wy,float r) {
    if (!activate) {
      activate=true;
      posx=x;
    posy=y;
    velx=vx;
    vely=vy;
    velrx=wx;
    velry=wy;
    rad=r;
    noStroke();
    fill(255);
    obj=createShape(SPHERE, r);
    obj.setTexture(faudo);
    }
  }

  public void ballupdate() {
    posy-=vely;
    posx-=velx;
    if (posx-rad<0 && velx>0) velx*=-1;
    if (posx+rad>width && velx<0) velx*=-1;
    if (posy-rad<0 && vely>0) vely*=-1;
    if (posy+rad>height-height/6.f && vely<0) vely*=-1;
  }

  public void drawball(float z) {
    if (activate) {

      pushMatrix();
      translate(posx, posy,z);
      rotateX(rotx+=velrx);
      rotateY(roty+=velry);
      shape(obj);
      popMatrix();
    }
  }
  
  public void drawball() {
    if (activate) {

      pushMatrix();
      translate(posx, posy,0);
      rotateX(rotx+=velrx);
      rotateY(roty+=velry);
      shape(obj);
      popMatrix();
    }
  }

  public PVector getpos() {
    return new PVector(posx, posy);
  }

  public PVector getvel() {
    return new PVector(velx, vely);
  }
  
  public float getrad() {
    return rad;
  }

  public void setpos(PVector p) {
    posx=p.x;
    posy=p.y;
  }

  public void setvel(PVector v) {
    velx=v.x;
    vely=v.y;
  }

  public void touch() {
    ballcolor=color(random(255), random(255), random(255));
  }
  public PVector nextpos() {
    return new PVector(posx-velx, posy-vely);
  }

  public void removeball() {
    activate=false;
    numPoints.addPuntuation(ballExploted*numLives);
  }
  public void resetball(){
    activate=false;
  }
}


class BallShit extends Thread {

  boolean running;           // Is the thread running?  Yes or no?
  String id;                 // Thread name
  int count;                 // counter


  // Constructor, create the thread
  // It is not running by default
  BallShit (String s) {
    running = false;
    id = s;
    count = 0;
  }

  // Overriding "start()"
  public void start () {
    // Set running equal to true
    running = true;
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }

  // We must implement run, this gets triggered by start()
  public void run () {
    while (running) {
      if (thrcontrol) {
        for (int n=numballs-1; n>=0; n--) {

          if (fuad[n].ballask()) {
            for (int m=0; m<n; m++) {
              if (fuad[m].ballask()) {
                if (PVector.dist(fuad[n].nextpos(), fuad[m].nextpos())<2*fuad[n].getrad()) {
                  colision(fuad[n], fuad[m]);
                  /*fuad[n].touch();
                   fuad[m].touch();*/
                }
              }
            }
          }
        }
        thrcontrol=false;
       
      }
    }
  }

  // Our method that quits the thread
  public void quit() { 
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    //interrupt();
  }
}


public void colision(Ball one, Ball two) {
  // get distances between the balls components
  float r1=one.getrad(),r2=two.getrad();
  PVector velone=one.getvel();
  PVector veltwo=two.getvel();
  float m1=pow(3,r1/10.f), m2=pow(3,r2/10.f);
  PVector bVect = PVector.sub(one.getpos(), two.getpos());

  // calculate magnitude of the vector separating the balls
  float bVectMag = bVect.mag();

  if (bVectMag < r1 + r2) {
    // get angle of bVect
    float theta  = bVect.heading();
    // precalculate trig values
    float sine = sin(theta);
    float cosine = cos(theta);

    /* bTemp will hold rotated ball positions. You 
     just need to worry about bTemp[1] position*/
    PVector[] bTemp = {
      new PVector(), new PVector()
      };
      /* this ball's position is relative to the other
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * bVect.x + sine * bVect.y;
    bTemp[1].y  = cosine * bVect.y - sine * bVect.x;

    // rotate Temporary velocities
    PVector[] vTemp = {
      new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velone.x + sine * velone.y;
    vTemp[0].y  = cosine * velone.y - sine * velone.x;
    vTemp[1].x  = cosine * veltwo.x + sine * veltwo.y;
    vTemp[1].y  = cosine * veltwo.y - sine * veltwo.x;

    /* Now that velocities are rotated, you can use 1D
     conservation of momentum equations to calculate 
     the final velocity along the x-axis. */
    PVector[] vFinal = {  
      new PVector(), new PVector()
      };
      // final rotated velocity for b[0]
      vFinal[0].x = ((m1 - m2) * vTemp[0].x + 2 * m2 * vTemp[1].x) / (m1 + m2);
    vFinal[0].y = vTemp[0].y;

    // final rotated velocity for b[0]
    vFinal[1].x = ((m2 - m1) * vTemp[1].x + 2 * m1 * vTemp[0].x) / (m1 + m2);
    vFinal[1].y = vTemp[1].y;

    // hack to avoid clumping
    bTemp[0].x += vFinal[0].x;
    bTemp[1].x += vFinal[1].x;

    /* Rotate ball positions and velocities back
     Reverse signs in trig expressions to rotate 
     in the opposite direction */
    // rotate balls
    PVector[] bFinal = { 
      new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
    bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
    bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
    bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

    // update velocities
    velone.x = cosine * vFinal[0].x - sine * vFinal[0].y;
    velone.y = cosine * vFinal[0].y + sine * vFinal[0].x;
    veltwo.x = cosine * vFinal[1].x - sine * vFinal[1].y;
    veltwo.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    one.setvel(velone);
    two.setvel(veltwo);
  }
}

public int checkNumBalls(Ball[] b, int nb)
{
  int count=0;
  for (int i=0; i< nb;i++)
    if (b[i].ballavailable())count++;
  return count;
}

class Bullet {
  float posx, iniy, posy, vel;
  boolean on;
  Bullet(float v, float y) {
    vel=v;
    iniy=y;
  }
  public boolean bulletavailable() {
    return !on;
  }
  public void activate(float x) {
    if (!on) {
      on=true; 
      posx=x;
      posy=iniy;
    }
  }
  public void bulletupdate() {
    posy-=vel;
  }
  public void drawbullet() {
    rectMode(CENTER);
    if (on) {
      fill(255);
      rect(posx, posy, bulletrad+bulletrad, bulletrad+bulletrad);
    }
  }

  public void removebullet() {
    on=false; 
    posy=iniy;
  }

  public float gety() {
    return posy;
  }
  public float getx() {
    return posx;
  }
  public void touchball(Ball[] b, int nb) {
    if (on) {
      for (int i=0; i<nb; i++) {
        if (b[i].ballask()) {
          if (PVector.dist(b[i].getpos(), new PVector(posx, posy))<bulletrad+b[i].getrad()) {
            removebullet();
            b[i].removeball();
          }
        }
      }
    }
  }
}


static final int numballs = 30;
static final int ballrad = 150;
static final int maxLevel = 30;
float bulletrad;
static final float zmax=1000;
static final float zmin=0;
static final int ballExploted = 10;
static final long timedivisor = 60000;

long finaltime=0;

int numLives = 3;

volatile boolean thrcontrol=false;
DataFromArduino Ardu = new DataFromArduino();
Player one= new Player();
Bullet bala[]=new Bullet[5];
Ball fuad[]= new Ball[numballs];
DisplayStateMachine display = new DisplayStateMachine(0);
BallShit ballshit;

PImage fua;
int level = 0;

public void ShowGame()
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
  one.setvel(Ardu.getX()/50.f);
  one.updateplayer();
  one.drawplayer( height*5/6.f);
  one.ballkillplayer(fuad, numballs);
  fill(1, 67, 88);
  rectMode(CORNER);
  rect(0, height*5/6.f, width, height/6.f);
  fill(255, 0, 0);
  text("Lives: "+one.numliv(), width*50/600.f, height*(5.6f)/6.f);
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

public void InitGame()
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
public void nextLevel()
{
  for (int i=0; i<5;i++) {
    bala[i].removebullet();
  }
  fua = fuas[((level%15))];
  //fua.resize(width, height);
  level++;
  int levelBalls = level;
  for (int i=0; i<levelBalls; i++) {
   fuad[i].activate(random(width*(ballrad/level)/600.f, width-width*(ballrad/level)/600.f), random(width*(ballrad/level)/600.f, height*5/6.f-width*(ballrad/level)/600.f-height*30/600.f), level*0.2f*(random(-2, 2)), level*0.2f*(random(-2, 2)), random(-.1f, .1f), random(-.1f, .1f), width*(ballrad/level)/600.f);
  }
  display.setControlDisplay(3);
}

public void gameover() {
  background(fotoover);
  textSize(40);
  fill(255, 0, 0);
  textSize((int)width*38/600.f);
  text("GAME OVER", 200, 200);
  Ardu.getDataFromBuffer();
  if (Ardu.getSWState()==0)
  {
    display.setControlDisplay(4);
  }
}



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

public void InitConfigurations()
{
  /*Here you can load all images and throw all the threads that you want*/
  minim = new Minim(this);
  kick = minim.loadFile("gasolina.mp3", 1024);
  gamesound=minim.loadFile("sexy.mp3",1024);
  shaderfondo = loadShader("fondo.glsl");
  fotoover=loadImage("fuadover.jpg");
  fotoover.resize(width, height);
  img = loadImage("fondo.jpeg");
  img.resize(width, height);
  bulletrad = height*2.5f/600.f;
  faudo = loadImage("faud.jpg");
  fuas=new PImage[15];
  for(int i=0; i<15; i++){
    fuas[i] = loadImage("level" + (i+1) + ".jpg");
    fuas[i].resize(width, height);
  }
  for (int i=0; i<5; i++) {
    bala[i]= new Bullet(height*10/600.f,  height*5/6.f-15);
  }
  for (int i=0; i<numballs; i++) {
    fuad[i]= new Ball();
  }
}
public void setupMenus()
{

  USBdisponible = joystickCOM.list();
  FondoStartMenu=loadImage("fotofuad.jpg");
  FondoStartMenu.resize(width, height);
  background(FondoStartMenu);
  FondoMainMenu=loadImage("fuad.png");
  FondoMainMenu.resize(width, height);
  InitConfigurations();
}

public void ShowStartMenu()
{
  textSize((int)width*38/600.f);
  smooth();
  fill(color(240, 80, 50));
  text("Select an Option: ", width*150/600.f, height*150/600.f);
  for (int i=0; i<USBdisponible.length; i++)
  {
    fill(color(240, 80, 50));
    text("Option "+Integer.toString(i+1)+": "+ USBdisponible[i], width*150/600.f, height*(250+100*i)/600.f);
  }
}


public void ShowMainMenu()
{
  textSize((int)width*38/600.f);
  smooth();
  fill(color(240, 20, 20));
  text("KILL F.. PANG!!", width*150/600.f, height*150/600.f);
  text("PULSE START", width*150/600.f, height*400/600.f);
  namePlayer.writingName();
}

public void addranking(String name, int point) {
  BufferedReader reader;
  String line;
  PrintWriter output;
  int shownum=0;
  boolean stop=true;
  reader = createReader("data/Ranking.txt");
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
  saveStrings("data/Ranking.txt", ranktemp);
  File file = sketchFile("data/temporal");
  file.delete();
}

public void InitHighScoreMenu()
{
  sumador = -20;
  counter = 0;
  noStroke();
  fill(255);
  faud = new PShape[8];

  for (int i=0; i<8;i++) {
    faud[i]=createShape(SPHERE, height*45/600.f);
    faud[i].setTexture(faudo);
  }

  aleatorio = new float[2][8];
  for (int i=0;i<2;i++) {
    for (int j=0; j<8;j++) {
      aleatorio[i][j] = random(-3.14f, 3.14f);
    }
  }
  posiciones = new float[2][8];
  for (int i=0;i<2;i++) {
    for (int j=0; j<8;j++) {
      posiciones[i][j] = random(-3.14f, 3.14f);
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
  shaderfondo.set("resolution", PApplet.parseFloat(graphfondo.width), PApplet.parseFloat(graphfondo.height)); 
  shaderfondo.set("mask", graphfondo);  
  background(255);
  ranking=new String[10][2];
  addranking(namePlayer.getName(), (int)(numPoints.getPuntuation()*timing.getMul()));
}
public void ShowHighScoreMenu()
{
  graphfondo.beginDraw();
  graphfondo.shader(shaderfondo);
  graphfondo.rect(0, 0, graphfondo.width, graphfondo.height);
  graphfondo.endDraw();
  image(graphfondo, 0, 0, width, height);
  stroke(0);
  textSize((int)width*38/600.f);
  text("Ranking", width*200/600.f, height*100/600.f, 0);
  for (int i=0; i<ranking.length; i++) {
    text(ranking[i][0]+' '+ranking[i][1], width*200/600.f, height*(160+i*40)/600.f, 0);
  }
  translate( width*100/600.f, height*70/600.f, 0);
  for (int i=0;i<2;i++) {
    pushMatrix();
    for (int j=0; j<4;j++) {
      pushMatrix();
      rotateX(posiciones[0][4*i+j]+=(aleatorio[0][4*i+j])/50);
      rotateY(posiciones[1][4*i+j]+=(aleatorio[1][4*i+j])/50);
      shape(faud[4*i+j]);
      popMatrix();
      translate(0, height*150/600.f, 0);
    } 
    popMatrix();
    translate(width*400/600.f, 0, 0);
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
public void keyTyped()
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

class Player {
  float x, vel;
  int lives;
  boolean alive;
  TimeControl deadtime;
  Player() {
    x=width/2.f;
    vel=0;
    lives=3;
    deadtime = new TimeControl();
    alive=true;
  } 
  public void resetplayer() {
    vel=0;
    lives=3;
    x=5;
    alive=true;
  }
  public void setvel(float v) {
    vel=v;
  }
  public float getpos() {
    return x;
  }
  public void updateplayer() {
    x+=vel;
    if (x<5) x=5;
    if (x+5>width) x=width-5;
  }

  public void drawplayer(float h) {
    rectMode(CENTER);
    if (deadtime.EventTime()) fill(247, 220, 199);
    else fill(255, 0, 0);
    rect(x, h-width*10/600.f, width*10/600.f,height*20/600.f);
  }
  public void killplayer() {
    if (deadtime.EventTime()) {
      lives--;
      deadtime.startTime(2000);
      if (lives<=0) alive=false;
    }
  }
  public boolean asktimedead() {
    return deadtime.EventTime();
  }
  public boolean askalive() {
    return alive;
  }
  public int numliv() {
    return lives;
  }
  public void ballkillplayer(Ball[] b, int nb) {
    for (int i=0; i<nb; i++) {
      if (b[i].ballask()) {
        if (PVector.dist(b[i].getpos(), new PVector(x,  height*5/6.f-15))<bulletrad+b[i].getrad()+width*10/600.f/2.f) {
          killplayer();
        }
      }
    }
  }
}
PlayerName namePlayer= new PlayerName();

public class PlayerName {
  private char[] name;
  private char chartoShow;
  private int charsIntroduced;
  private boolean nameWrited;
  private TimeControl time;

  public PlayerName()
  {
    chartoShow = 'A';
    name = new char[3];
    name[0] = chartoShow;
    charsIntroduced = 0;
    nameWrited = false;
    time = new TimeControl();
  }

  public void restart()
  {
    chartoShow = 'A';
    name[0] = chartoShow;
    name[1]= ' ';
    name[2] = ' ';
    charsIntroduced = 0;
    nameWrited = false;
  }

  public void incChar()
  {
    chartoShow++;
    if (chartoShow > 'Z')
      chartoShow = 'A';
    name[charsIntroduced] = chartoShow ;
  }

  public void decChar()
  {
    chartoShow--;
    if (chartoShow < 'A')
      chartoShow = 'Z';
    name[charsIntroduced] = chartoShow;
  }

  public void showName(int x, int y)
  {
    textSize(48);
    String player = new String(name);
    fill(255);
    rect(width*(x-10)/600.f, height*(y-40)/600.f, width*150/600.f, height*50/600.f);
    fill(255, 0, 0);
    text(player, width*x/600.f, height*y/600.f);
  }

  public void writingName()
  {
    showName(200, 300);

    if (!nameWrited)
    {
      if (Ardu.getDataFromBuffer())
      {
        int joystick = Ardu.getBinY();
        switch(joystick)
        {
        case 1:
          incChar();
          break;

        case -1:
          decChar();
          break;

        default:
          break;
        }
        if (Ardu.getSWTriggerState()==0)
        {
          charsIntroduced++;
          if (charsIntroduced<3)
            name[charsIntroduced] = chartoShow;
          time.startTime(300);
          while (!time.EventTime ());
        }
        /*while (Ardu.getBinY () != 0)
        {
          Ardu.getDataFromBuffer();
        }*/
      }
      if (charsIntroduced == 3)
      {
        nameWrited = true;
        display.incControlDisplay();
      }
    }
  }

  public String getName()
  {
    String player = new String (name);
    return player;
  }

  public boolean getnameWrited()
  {
    return nameWrited;
  }
}

Puntuation numPoints = new Puntuation();

public class Puntuation {
  private int points;

    public Puntuation()
  {
    points = 0;
  }

  public void clearPuntuation()
  {
    points = 0;
  }

  public void addPuntuation(int add)
  {
    points += add;
  }

  public int getPuntuation()
  {
    return points;
  }
}

public class DisplayStateMachine {
  private int controlDisplay;

  public DisplayStateMachine (int InitState)
  {
    controlDisplay = InitState;
  }

  public void ShowDisplay()
  {
    switch(controlDisplay)
    {
    case 0: 
      ShowStartMenu();
      break;
    case 1:
      ShowMainMenu();
      break;

    case 2: 
      InitGame();
      break;
    case 3: 
      ShowGame();
      break;
    case 4:
      InitHighScoreMenu();
      controlDisplay=5;
      break;
    case 5:
      ShowHighScoreMenu();
      break;
    case 6:
      gameover();
      break;
    }
  }

  public void setControlDisplay(int disp)
  {
    controlDisplay=disp;
  }

  public int getControlDisplay()
  {
    return controlDisplay;
  }

  public void incControlDisplay()
  {
    controlDisplay++;
  }
  public void decControlDisplay()
  {
    controlDisplay--;
  }
}

class surfaces {
  Ball surfuads[];
  float posz, velz;
  boolean activate;
  int numsurballs;
  surfaces () {
    surfuads= new Ball[30];
    for (int i=0; i<30; i++) {
      surfuads[i]= new Ball();
    }
  } 

  public void activesurface(int nsbs) {
    if (activate==false) {
      activate=true;
      posz=zmax;
      numsurballs=nsbs;
      genballs();
    }
  }

  public void genballs() {
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].activate(random(15, 500), random(15, 500), level*0.2f*(random(-2, 2)), level*0.2f*(random(-2, 2)), random(-.1f, .1f), random(-.1f, .1f), 15);
    }
  }

  public void updatesurface() {
    posz+=velz;
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].ballupdate();
    }
  }
  public void drawsurface() {
    for (int i=0; i<numsurballs; i++) {
      surfuads[i].drawball(posz);
    }
  }
}

Serial joystickCOM;
String dataReceived = ""; // Incoming serial data
boolean conected=false;

public void InitJoystickCOM(String portName)
{
  if (conected)
  {
    println("Desconectando...");
    joystickCOM.clear();
    joystickCOM.stop();
  }
  println("Conectando al puerto "+portName);
  println("CONECTADO");
  conected=true;
  //ListaUSB.hide();
  //ListaUSB.setVisible(true);
  display.setControlDisplay(1);
  background(FondoMainMenu);
}


class DataFromArduino {
  int px, py, swon, swtrigger, pby, pbx;
  boolean pushed;
  DataFromArduino() {
    px=0;
    py=0;
    pbx=0;
    pby=0;
    swon=1;
    swtrigger = 1;
    pushed=false;
  }
  public void setX(int t) {
    px=t;
  }
  public void setY(int t) {
    py=t;
  }
  public void setBinY(int t) {
    pby=t;
  }
  public void setBinX(int t) {
     pbx=t;
  }
  public void setSWState(int t) {
    swon=t;
  }
  public void setSWTriggerState(int t) {
    swtrigger=t;
  }
  public int getX() {
    return px;
  }
  public int getY() {
    return py;
  }
  public int getBinY() {
    return pby;
  }
  public int getBinX() {
    return pbx;
  }
  public int getSWState() {
    int temp=swon;
    if (swon==0) swon=1;
    return temp;
  }
  public int getSWTriggerState() {
    int temp=swtrigger;
    if (swtrigger==0) swtrigger=1;
    return temp;
  }
  public boolean getDataFromBuffer() {
    boolean temp;
    temp=pushed;
    if (pushed)pushed=false;
    return temp;
  }
  public void setPushed() {
    pushed=true;
  }
  
  public void resetAll()
  {
    px=0;
    py=0;
    pbx=0;
    pby=0;
    swon=1;
    swtrigger = 1;
    pushed=false;
  }
}

public void keyPressed() {
  if (keyCode==UP) {
    Ardu.setY(-1023);
    Ardu.setBinY(-1);
    Ardu.setPushed();
  }
  else if (keyCode==DOWN) {
    Ardu.setY(1023);
    Ardu.setBinY(1);
    Ardu.setPushed();
  }

  if (keyCode==LEFT) {
    Ardu.setX(-1023);
    Ardu.setBinX(-1);
    Ardu.setPushed();
  }
  else if (keyCode==RIGHT) {
    Ardu.setX(1023);
    Ardu.setBinX(1);
    Ardu.setPushed();
  }
}


public void keyReleased() {
  if (keyCode==LEFT) {
    Ardu.setX(0);
    Ardu.setBinX(0);
    Ardu.setPushed();
  }
  else if (keyCode==RIGHT) {
    Ardu.setX(0);
    Ardu.setBinX(0);
    Ardu.setPushed();
  }
  if (keyCode==UP) {
    Ardu.setY(0);
    Ardu.setBinY(0);
    Ardu.setPushed();
  }
  else if (keyCode==DOWN) {
    Ardu.setY(0);
    Ardu.setBinY(0);
    Ardu.setPushed();
  }

  if (key==' ') {
    Ardu.setSWState(0);
    Ardu.setPushed();
  }

  if (key=='z') {
    Ardu.setSWTriggerState(0);
    Ardu.setPushed();
  }
}

TimeControl timing = new TimeControl();

public class TimeControl {
  private long startTime;
  private long desiredTime;
  private long countedtime;
  
  public TimeControl()
  {
    startTime=0;
    desiredTime=0;
    countedtime=0;
  }
  
  public void InitTime()
  {
    startTime=0;
    desiredTime=0;
    countedtime=0;
  }
  
  public void startTime(long time)
  {
    startTime = millis();
    desiredTime = time;
    countedtime=0;
  }
  
  public void startTime()
  {
    startTime = millis();
  }
  
  public void stopTime()
  {
   countedtime = millis() - startTime; 
  }
  
  public void setEventTime(long time)
  {
    desiredTime = time;
  }
  
  public long getTime()
  {
    return millis()-startTime;
  }
  
  public boolean EventTime()
  {
    return millis()-startTime > desiredTime;
  }
  
  public double getMul()
  {
    double temp = (double)countedtime;
    
    if(temp > 180000)
      temp = 1;
    else
     temp = temp/180000;
    
    return (double)(1+(1-temp));
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "KillPangV0" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
