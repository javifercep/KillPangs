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
    case 6:
      gameover();
      break;
    case 7:
      InitGameV2();
      break;
    case 8:
      ShowGameV2();
      break;
    case 9:
      showuser();
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

