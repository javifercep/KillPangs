Kinect kin = new Kinect(true);
SimpleOpenNI context = new SimpleOpenNI(this);

public class Kinect {
  private PVector neck;
  private PVector hand;
  private boolean right;
  float x0=1, y0=2, x1=3, y1=4;

  public Kinect(boolean userhand)
  {
    neck = new PVector();
    hand = new PVector();
    right = userhand;
  }

  public boolean InitKinect()
  {
    boolean temp = true;
    if (context.isInit() == false)
    {
      println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
      temp=false;
    }
    else
    {
      // enable depthMap generation 
      context.enableDepth();

      // enable skeleton generation for all joints
      context.enableUser();
    }
    return temp;
  }
  public void userImage(){ //Kinect
  int[] userList = context.getUsers();
    if (userList.length>0) image(context.userImage(),0,0,width,height); 
  }
  public void update()
  {
    context.update();
  }

  public void trackUserOne()
  {
    int[] userList = context.getUsers();
    if (userList.length>0)
    {
      if (context.isTrackingSkeleton(userList[0]))
      {
        context.getJointPositionSkeleton(userList[0], SimpleOpenNI.SKEL_NECK, neck);
        context.getJointPositionSkeleton(userList[0], SimpleOpenNI.SKEL_RIGHT_HAND, hand);
        //drawTrack();
      }
    }
  }

  public void showTrack()
  {
    //print("Vector hand: ");
    //println (hand);
    print("Vector neck: ");
    println (neck);
  }

  public void drawTrack()
  {
    pushMatrix();
    translate(width/2., height/2.);
    fill(255, 200, 150, 200);
    ellipse(neck.x/2., -neck.y/2., neck.z/4.0, neck.z / 4.0);
    fill(0, 200, 150);
    PVector m=getHand();
    ellipse(m.x, m.y, hand.z/100.0, hand.z / 100.0);
    popMatrix();
  }

  PVector getNeck()
  {
    return neck;
  }

  PVector getHand()
  {
    /*PVector ret=new PVector();
     ret.x=(int)(width*(hand.x-x0)/(x1-x0));
     ret.y=(int)(width*(hand.y-y0)/(y1-y0));
     println(x0+"  "+x1+"  "+y0+"  "+y1);
     return ret;*/
    PVector cent=PVector.sub(hand, neck);
    cent.y*=-1;
    cent.add(new PVector(width/2., height/2.));

    return new PVector((int)cent.x, (int)cent.y);
  }
  PVector getHandreal()
  {
    return hand;
  }
  void setx0y0(PVector v) {
    x0=v.x;
    y0=v.y;
  }
  void setx1(float v) {
    x1=v;
  }
  void sety1(float v) {
    y1=v;
  }
}

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

