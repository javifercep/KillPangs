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
  private int swon, posBX, posBY;

  public DataFromArduino ()
  {
    Buffer = new StringList();
  }

  public boolean getDataFromBuffer() {
    /*Check if there are available data, get data and update
     the buffer. Converts analog data to binary data. Return 
     TRUE if data has been adquired, and FALSE otherwise*/

    if (Buffer.size()>0)
    {
      String[] coordenadas = split(Buffer.get(0), ':');
      posx=map(Float.parseFloat(coordenadas[0]), 0, 1023, 25, 575);
      if (posx < 200)      posBX = -1;
      else if (posx >800)  posBX =  1;
      else                posBX =  0;
      posy=map(Float.parseFloat(coordenadas[1]), 0, 1023, 25, 575);
      if (posy < 200)      posBY = -1;
      else if (posy >800)  posBY =  1;
      else                posBY =  0;
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
    /* Return a value between 0 and 1023*/
    return posx;
  }

  public float getY()
  {
    /* Return a value between 0 and 1023*/
    return posy;
  }

  public float getBinX()
  {
    /* Return -1, 0 or 1*/
    return posBX;
  }

  public float getBinY()
  {
    /* Return -1, 0 or 1*/
    return posBY;
  }

  public int getSWState()
  {
    /* Return push Button State */
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

