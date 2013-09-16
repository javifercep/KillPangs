class levelv2 {
  int level;
  int numballs;
  int radio;
  float vel;
  float velz;
  int numfaces;
  int deadfaces;
  long timesep;
  int numfaceshow;
  TimeControl nextface;
  levelv2() {
    nextface= new TimeControl();
  }
  void resetlevelv2() {
    level=0; 
    deadfaces=0;
    numballs=0;
    numfaces=0;
    timesep=5000;
    numfaceshow=0;
    velz=1;
  }
  void nextlevelv2() {
    level++;
    numballs++;
    radio=(int)(ballrad/(level/1.5));
    if(level%3==1) numfaces++;
    deadfaces=0;
    vel=level*0.2;
    velz*=1.2;
    numfaceshow=0;
    //timesep=(long)(8*radio/ (velz*frameRate)) *1000;
    timesep=4000;
    nextface.startTime(0);
  }
  void deadface() {
    deadfaces++;
    if(deadfaces==numfaces){
      nextlevelv2();
    }
  }
  boolean updatelevel() {
    if (numfaceshow==numfaces) {
      println(numfaceshow);
      println(numfaces);
      println("false1");
      return false;
    } else {
      if (nextface.EventTime()) {
        nextface.startTime(timesep);
        numfaceshow++;
        println("true1");
        return true;
      }
      else {
        println("false2");
        return false;
      }
    }
  }
  int asklevelv2(){
    return level;
  }
}

