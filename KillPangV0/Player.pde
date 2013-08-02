class Player{
 float x,vel;
 Player(){
   x=width/2.;
   vel=0;
 } 
 
 void setvel(float v){
   vel=v;
 }
 float getpos(){
  return x;
 }
 void updateplayer(){
   x+=vel;
   if(x<0) x=0;
   if(x+10>width) x=width;
 }
 
 void drawplayer(float h){
  rect(x,h-20,10,20); 
 }
}
