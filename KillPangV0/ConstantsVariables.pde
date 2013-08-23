
static final int numballs = 30;
static final int ballrad = 150;
static final int maxLevel = 10;
static final float bulletrad = 2.5;

boolean thrcontrol=false;
DataFromArduino Ardu = new DataFromArduino();
Player one= new Player();
Bullet bala[]=new Bullet[5];
Ball fuad[]= new Ball[numballs];
DisplayStateMachine display = new DisplayStateMachine(0);
BallShit ballshit;
