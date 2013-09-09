import processing.serial.*;


void setup()
{
  //int displaysize=min(displayWidth, displayHeight);(displayHeight*4/3)
  size((int)(displayHeight*1.25), displayHeight, OPENGL);
  frameRate(60);
  setupMenus();
  display.setControlDisplay(1);  
}

void draw()
{
  display.ShowDisplay();
}

