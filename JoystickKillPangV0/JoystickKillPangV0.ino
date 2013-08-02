#include <TimerThree.h>

volatile int swon=1;
volatile boolean espera;
volatile int cont=0;

void setup()
{
  Serial.begin(115200);
  pinMode(3,INPUT_PULLUP);
  Timer3.initialize(20000);
  Timer3.attachInterrupt(enviadato);
  attachInterrupt(1, pulsador, FALLING);
}

void loop()
{
  if(espera)
  {
    if(cont==10)
    {
      espera=false;
      cont=0;
    }
  }
}

void enviadato()
{
  if(espera)cont++;
  Serial.print(analogRead(A0));
  Serial.print(":");
  Serial.print(analogRead(A1));
  Serial.print(":");
  if(swon==0)
  {
    Serial.println(swon);
    swon=1;
  }
  else
    Serial.print(swon);
  Serial.print('f');
}

void pulsador(){
  if(!espera)
  {
    swon=0;
    espera=true;
  }
}


