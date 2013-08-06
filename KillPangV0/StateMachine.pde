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
      InitGame();
      controlDisplay=2;
      break;
    case 2: 
      ShowGame();
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
}

