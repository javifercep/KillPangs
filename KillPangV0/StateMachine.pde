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
      ShowMainMenu();
      break;

    case 2: 
      InitGame();
      controlDisplay=3;
      break;
    case 3: 
      ShowGame();
      break;
    case 4:
      InitHighScoreMenu();
      controlDisplay=5;
      break;
    case 5:
      ShowHighScoreMenu();
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
  public void decControlDisplay()
  {
    controlDisplay--;
  }
}

