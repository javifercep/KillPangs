import processing.serial.*;


void setup()
{
  int displaysize=min(displayWidth, displayHeight);
  size(displaysize, displaysize, OPENGL);
  frameRate(60);
  setupMenus();
  display.setControlDisplay(0);  
}

void draw()
{
  display.ShowDisplay();
}

