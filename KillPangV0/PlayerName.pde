PlayerName namePlayer= new PlayerName();

public class PlayerName {
  private char[] name;
  private char chartoShow;
  private int charsIntroduced;
  private boolean nameWrited;
  private TimeControl time;

  public PlayerName()
  {
    chartoShow = 'A';
    name = new char[3];
    name[0] = chartoShow;
    charsIntroduced = 0;
    nameWrited = false;
    time = new TimeControl();
  }

  public void restart()
  {
    chartoShow = 'A';
    name[0] = chartoShow;
    name[1]= ' ';
    name[2] = ' ';
    charsIntroduced = 0;
    nameWrited = false;
  }

  public void incChar()
  {
    chartoShow++;
    if (chartoShow > 'Z')
      chartoShow = 'A';
    name[charsIntroduced] = chartoShow ;
  }

  public void decChar()
  {
    chartoShow--;
    if (chartoShow < 'A')
      chartoShow = 'Z';
    name[charsIntroduced] = chartoShow;
  }

  public void showName(int x, int y)
  {
    textSize(48);
    String player = new String(name);
    fill(255);
    rect(width*(x-10)/600., height*(y-40)/600., width*150/600., height*50/600.);
    fill(255, 0, 0);
    text(player, width*x/600., height*y/600.);
  }

  public void writingName()
  {
    showName(200, 300);

    if (!nameWrited)
    {
      if (Ardu.getDataFromBuffer())
      {
        int joystick = Ardu.getBinY();
        switch(joystick)
        {
        case 1:
          incChar();
          break;

        case -1:
          decChar();
          break;

        default:
          break;
        }
        if (Ardu.getSWTriggerState()==0)
        {
          charsIntroduced++;
          if (charsIntroduced<3)
            name[charsIntroduced] = chartoShow;
          time.startTime(300);
          //while (!time.EventTime ());
        }
        /*while (Ardu.getBinY () != 0)
        {
          Ardu.getDataFromBuffer();
        }*/
      }
      if (charsIntroduced == 3)
      {
        nameWrited = true;
        //display.incControlDisplay();
      }
    }
  }

  public String getName()
  {
    String player = new String (name);
    return player;
  }

  public boolean getnameWrited()
  {
    return nameWrited;
  }
}

