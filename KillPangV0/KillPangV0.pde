import processing.serial.*;


void setup()
{
  int displaysize=min(displayWidth, displayHeight);
  size(displaysize, displaysize, OPENGL);
  frameRate(60);
  setupMenus();  
}

void draw()
{
  display.ShowDisplay();
}

