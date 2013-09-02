Kinect kin = new Kinect(true);
SimpleOpenNI context = new SimpleOpenNI(this);

public class Kinect {
  private PVector neck;
  private PVector hand;
  private boolean right;


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
        drawTrack();
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
    fill(255,200, 150, 200);
    ellipse(neck.x/2., -neck.y/2., neck.z/4.0, neck.z / 4.0);
    fill(0,200, 150);
    ellipse(hand.x/2., -hand.y/2., hand.z/100.0, hand.z / 100.0);
    popMatrix();
  }
  
  PVector getNeck()
  {
    return neck;
  }
  
  PVector getHand()
  {
    return hand;
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

