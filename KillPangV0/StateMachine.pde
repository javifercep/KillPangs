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
<<<<<<< HEAD
=======
      controlDisplay=3;
>>>>>>> origin/Portillo
      break;
    case 3: 
      ShowGame();
      break;
<<<<<<< HEAD
    case 4:
=======
       case 4:
>>>>>>> origin/Portillo
      InitHighScoreMenu();
      controlDisplay=5;
      break;
    case 5:
      ShowHighScoreMenu();
      break;
<<<<<<< HEAD
    case 6:
      LevelUp();
      break;
=======
>>>>>>> origin/Portillo
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
