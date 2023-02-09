interface CurtainEvent{
  void Event();
}

class Curtain{
  color c;
  CurtainEvent event;
  float alpha,speed;
  boolean isFirst = true;
  Curtain(color c,CurtainEvent event,float speed,float alpha){
    this.c = c;
    this.event = event;
    this.alpha = alpha;
    this.speed = speed;
  }
  
  void Display(){
    noStroke();
    fill(red(c),green(c),blue(c),alpha);
    rect(0,0,width,height);
    if(alpha < 255 && speed > 0 || alpha > 0 && speed < 0) alpha += speed;
    else if(isFirst){ event.Event(); isFirst = false; }
  }
}
