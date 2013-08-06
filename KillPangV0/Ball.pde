class Ball {
  float posx, posy, velx, vely;
  boolean activate;
  color ballcolor=color(0);
  Ball(float x, float y, float vx, float vy) {
    posx=x;
    posy=y;
    velx=vx;
    vely=vy;
    activate=false;
  }
  boolean ballavailable() {
    return !activate;
  }
  boolean ballask() {
    return activate;
  }
  void activate() {
    if (!activate) {
      activate=true;
    }
  }

  void ballupdate() {
    posy-=vely;
    posx-=velx;
    if (posx-15<0 && velx>0) velx*=-1;
    if (posx+15>width && velx<0) velx*=-1;
    if (posy-15<0 && vely>0) vely*=-1;
    if (posy+15>500 && vely<0) vely*=-1;
  }

  void drawball() {
    if (activate) {
      fill(ballcolor);
      pushMatrix();
      translate(posx, posy);
      sphere(15);
      popMatrix();
    }
  }

  PVector getpos() {
    return new PVector(posx, posy);
  }

  PVector getvel() {
    return new PVector(velx, vely);
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
  }
}


void ballshit() {
  while (true) {
    if (thrcontrol) {
      for (int n=numballs-1; n>=0; n--) {
<<<<<<< HEAD
        for (int m=0; m<n; m++) {
          //println(m);
          if (PVector.dist(fuad[n].getpos(), fuad[m].getpos())<30) {
            colision(fuad[n], fuad[m]);
            /*fuad[n].touch();
             fuad[m].touch();*/
=======

        if (fuad[n].ballask()) {
          for (int m=0; m<n; m++) {
            if (fuad[m].ballask()) {
              if (PVector.dist(fuad[n].nextpos(), fuad[m].nextpos())<30) {
                colision(fuad[n], fuad[m]);
                /*fuad[n].touch();
                 fuad[m].touch();*/
              }
            }
>>>>>>> origin/Sr.Cepeda
          }
        }
      }
      thrcontrol=false;
    }
  }
}


void colision(Ball one, Ball two) {
  // get distances between the balls components
  float r=15;
  PVector velone=one.getvel();
  PVector veltwo=two.getvel();
  float m1=40, m2=40;
  PVector bVect = PVector.sub(one.getpos(), two.getpos());

  // calculate magnitude of the vector separating the balls
  float bVectMag = bVect.mag();

  if (bVectMag < r + r) {
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

