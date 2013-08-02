Serial joystickCOM;
String dataReceived = ""; // Incoming serial data

public void InitJoystickCOM()
{
  println(Serial.list());
  String portName = Serial.list()[0];
  joystickCOM = new Serial(this, portName, 115200);
}

void serialEvent(Serial joystickCOM) {
  if (joystickCOM.available()>1)
    dataReceived = joystickCOM.readStringUntil('f');

  //println(inString);
  if (dataReceived != null && dataReceived.length()>=6)
  {
    Ardu.addtoBuffer(dataReceived);
    dataReceived=null;
  }
}

public class DataFromArduino {
  private StringList Buffer;
  private float posx, posy;
  private int swon;

  public DataFromArduino ()
  {
    Buffer = new StringList();
  }

  public boolean getDataFromBuffer() {
    /*Check if there are available data and get data and update
     the buffer. Return TRUE if data has been adquired, and FALSE
     otherwise*/

    if (Buffer.size()>0)
    {
      String[] coordenadas = split(Buffer.get(0), ':');
      posx=map(Float.parseFloat(coordenadas[0]), 0, 1023, 25, 575);
      posy=map(Float.parseFloat(coordenadas[1]), 0, 1023, 25, 575);
      swon=Integer.parseInt(coordenadas[2].substring(0, 1));
      Buffer.remove(0);
      return true;
    }
    else
      return false;
  }
  
  /*IMPORTANT: Use this functions immediatly after getDataFromBuffer function*/
  public float getX()
  {
   return posx; 
  }
  
  public float getY()
  {
    return posy;
  }
  
  public int getSWState()
  {
    return swon;
  }
  
  public void addtoBuffer(String data)
  {
    Buffer.append(data);
  }
  
  public int dataAvailable()
  {
    return Buffer.size();
  }
}
