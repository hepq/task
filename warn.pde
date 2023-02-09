class Warn{
  float x,y,l,sW,sH,sY,cY,t,eL,eT,wT,sT,root3;
  boolean isStartDelete;
  Warn(float x,float y){
     this.x = x;
     this.y = y;
     l = 110; sW = 14; sH = 40; sY = 40; sY = -15; cY = 12; t = 0; eL = 180; eT = 20; sT = millis(); wT = 500; root3 = sqrt(3);
     isStartDelete = false;
  }
  void Display(){
    if(t<=50 && !isStartDelete) this.t += 5;
    if(eL >= 110) eL-=10;
    if(millis() - sT >= wT) isStartDelete = true;
    if(isStartDelete) this.t -= 10;
    eT -= 2;
    DoDraw();
    Effect();
  }
  void Effect(){
    stroke(200,0,0,eT);
    strokeWeight(5);
    noFill();
    tri(eL);
  }  
  void DoDraw(){
    fill(200,0,0,t);
    noStroke();
    tri(l);
    fill(0,t-20);
    rect(x-sW/2,y-sH/2+sY,sW,sH,5);
    ellipse(x,y+sH/2+sY+cY,sW,sW);
  }  
  void tri(float t_l){
    beginShape();
    vertex(x-t_l/2,y+root3/6*t_l);
    vertex(x,y-root3/3*t_l);
    vertex(x+t_l/2,y+root3/6*t_l);
    endShape(CLOSE);
  }
}
