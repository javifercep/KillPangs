#include <TimerThree.h>

volatile int swon=1, swgatillo=1;
volatile boolean espera,esperagatillo;
volatile int cont=0, contgatillo=0;;

void setup()
{
  Serial.begin(115200);
  analogReference(EXTERNAL);
  pinMode(3,INPUT_PULLUP);
  pinMode(2,INPUT_PULLUP);
  Timer3.initialize(20000);
  Timer3.attachInterrupt(enviadato);
  attachInterrupt(1, pulsador, FALLING);
  attachInterrupt(0, gatillo, FALLING);
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
  if(esperagatillo)
  {
    if(contgatillo==10)
    {
      esperagatillo=false;
      contgatillo=0;
    }
  }
}

void enviadato()
{
  if(espera)cont++;
  if(esperagatillo)contgatillo++;
  Serial.print(analogRead(A0));
  Serial.print(":");
  Serial.print(analogRead(A1));
  Serial.print(":");
  
  //Comment before play game
  Serial.print(analogRead(A2));
  Serial.print(":");
  
  if(swon==0)
  {
    Serial.print(swon);
    swon=1;
  }
  else
    Serial.print(swon);
    Serial.print(":");
  if(swgatillo==0)
  {
    Serial.print(swgatillo);
    swgatillo=1;
  }
  else
    Serial.print(swgatillo);
  Serial.print('f');
}

void pulsador(){
  if(!espera)
  {
    swon=0;
    espera=true;
  }
}

void gatillo(){
  if(!esperagatillo)
  {
    swgatillo=0;
    esperagatillo=true;
  }
}

