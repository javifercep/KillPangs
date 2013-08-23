TimeControl timing = new TimeControl();

public class TimeControl {
  private long startTime;
  private long desiredTime;
  
  public TimeControl()
  {
    startTime=0;
    desiredTime=0;
  }
  
  public void InitTime()
  {
    startTime=0;
    desiredTime=0;
  }
  
  public void startTime(long time)
  {
    startTime = millis();
    desiredTime = time;
  }
  
  public void startTime()
  {
    startTime = millis();
  }
  
  public void setEventTime(long time)
  {
    desiredTime = time;
  }
  
  public long getTime()
  {
    return millis()-startTime;
  }
  
  public boolean EventTime()
  {
    return millis()-startTime > desiredTime;
  }
  
  public double getMul()
  {
    double temp =(double) (millis()-startTime);
    
    if(temp > 180000)
      temp = 1;
    else
     temp = temp/180000;
    
    return (double)(1+(1-temp));
  }
}
