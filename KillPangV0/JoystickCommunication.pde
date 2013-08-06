Serial joystickCOM;
String dataReceived = ""; // Incoming serial data
boolean conected=false;

public void InitJoystickCOM(String portName)
{
  if (conected)
  {
    println("Desconectando...");
    joystickCOM.clear();
    joystickCOM.stop();
  }
  println("Conectando al puerto "+portName);
  joystickCOM = new Serial(this, portName, 115200);
  println("CONECTADO");
  conected=true;
  ListaUSB.hide();
  //ListaUSB.setVisible(true);
  display.setControlDisplay(1);
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
      if (posx <100.0)      posBX = -1;
      else if (posx >500.0)  posBX =  1;
      else                posBX =  0;
      println(posBX);
      posy=map(Float.parseFloat(coordenadas[1]), 0, 1023, 25, 575);
      if (posy < 100.0)      posBY = -1;
      else if (posy >500.0)  posBY =  1;
      else                posBY =  0;
      println(posBY);
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

  public int getBinX()
  {
    /* Return -1, 0 or 1*/
    return posBX;
  }

  public int getBinY()
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

