import processing.serial.*;


void setup()
{
  size(600, 600, OPENGL);
  frameRate(60);
  setupMenus();
}

void draw()
{
  display.ShowDisplay();
}

