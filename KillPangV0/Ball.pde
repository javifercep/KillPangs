class Ball {
  float posx, posy, velx, vely, rotx=0 ,roty=0, velrx, velry, rad;
  boolean activate;
  color ballcolor=color(0);
  PShape obj;
  Ball() {
    
    activate=false;
    faudo = loadImage("faud.jpg");
    /*noStroke();
    fill(255);
    obj=createShape(SPHERE, 15);
    obj.setTexture(faudo);*/
    
  }
  boolean  ballavailable() {
    return !activate;
  }
  boolean ballask() {
    return activate;
  }
  void activate(float x, float y, float vx, float vy,float wx,float wy,float r) {
    if (!activate) {
      activate=true;
      posx=x;
    posy=y;
    velx=vx;
    vely=vy;
    velrx=wx;
    velry=wy;
    rad=r;
    //faudo = loadImage("faud.jpg");
    noStroke();
    fill(255);
    obj=createShape(SPHERE, r);
    obj.setTexture(faudo);
    }
  }

  void ballupdate() {
    posy-=vely;
    posx-=velx;
    if (posx-rad<0 && velx>0) velx*=-1;
    if (posx+rad>width && velx<0) velx*=-1;
    if (posy-rad<0 && vely>0) vely*=-1;
    if (posy+rad>height-100 && vely<0) vely*=-1;
  }

  void drawball(float z) {
    if (activate) {

      pushMatrix();
      translate(posx, posy,z);
      rotateX(rotx+=velrx);
      rotateY(roty+=velry);
      shape(obj);
      popMatrix();
    }
  }
  
  void drawball() {
    if (activate) {

      pushMatrix();
      translate(posx, posy,0);
      rotateX(rotx+=velrx);
      rotateY(roty+=velry);
      shape(obj);
      popMatrix();
    }
  }

  PVector getpos() {
    return new PVector(posx, posy);
  }

  PVector getvel() {
    return new PVector(velx, vely);
  }
  
  float getrad() {
    return rad;
  }

  void setpos(PVector p) {
    posx=p.x;
    posy=p.y;
  }

  void setvel(PVector v) {
    velx=v.x;
    vely=v.y;
  }

  void touch() {
    ballcolor=color(random(255), random(255), random(255));
  }
  PVector nextpos() {
    return new PVector(posx-velx, posy-vely);
  }

  void removeball() {
    activate=false;
    numPoints.addPuntuation(ballExploted*numLives);
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
  void start () {
    // Set running equal to true
    running = true;
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }

  // We must implement run, this gets triggered by start()
  void run () {
    while (running) {
      if (thrcontrol) {
        for (int n=numballs-1; n>=0; n--) {

          if (fuad[n].ballask()) {
            for (int m=0; m<n; m++) {
              if (fuad[m].ballask()) {
                if (PVector.dist(fuad[n].nextpos(), fuad[m].nextpos())<2*ballrad) {
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
  void quit() { 
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    //interrupt();
  }
}


void colision(Ball one, Ball two) {
  // get distances between the balls components
  float r1=one.getrad(),r2=two.getrad();
  PVector velone=one.getvel();
  PVector veltwo=two.getvel();
  float m1=pow(3,r1), m2=pow(3,r2);
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

int checkNumBalls(Ball[] b, int nb)
{
  int count=0;
  for (int i=0; i< nb;i++)
    if (b[i].ballavailable())count++;
  return count;
}

