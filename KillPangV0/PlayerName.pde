PlayerName namePlayer= new PlayerName();

public class PlayerName {
  private String name;
  private char chartoShow;
  private int charsIntroduced;
  private boolean nameWrited;
  private TimeControl time;
  
  public PlayerName()
  {
    name = "";
    chartoShow = 'A';
    charsIntroduced = 0;
    nameWrited = false;
    time = new TimeControl();
  }
  
  public void restart()
  {
    name = "";
    chartoShow = 'A';
    charsIntroduced = 0;
    nameWrited = false;
  }
  
  public void incChar()
  {
    chartoShow++;
    time.startTime(200);
    while(!time.EventTime());
  }
}
