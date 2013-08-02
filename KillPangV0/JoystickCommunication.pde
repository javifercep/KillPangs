void serialEvent(Serial joystickCOM) {
  if (joystickCOM.available()>1)
    inString = joystickCOM.readStringUntil('f');

  //println(inString);
  if (inString != null && inString.length()>=6)
  {
    Buffer.append(inString);
    inString=null;
  }
}
