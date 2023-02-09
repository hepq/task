class Enemy{
  float x,y,w,h,angle,speed;
  int state;
  Enemy(int state){
    this.state = state;
  }
  
  void Initialize(){
    int pX = (int)random(1,width);
    int pY = (int)random(1,height);
    int size = (int)random(15,100);
    float pAngle = radians(random(0,360));    
    int valueX = cos(pAngle) > 0 ? width: 0;
    int valueY = sin(pAngle) > 0 ? 0 : height;
    float k = min(abs((valueX - pX) /cos(pAngle)),abs((valueY - pY) /sin(pAngle)));
    pX += cos(pAngle) * k;
    pY -= sin(pAngle) * k;
    if(pX >= width - 1) pX += size / 2;
    if(pX <= 1) pX -= size / 2;
    if(pY >= width - 1) pY += size / 2;
    if(pY <= 1) pY -= size / 2;
    this.speed = random(2,4);
    this.x = pX;
    this.y = pY;
    this.angle = pAngle + radians(180);
    this.w = size;
    this.h = size;
    this.state = 0;
  }
  
  void Forward(){
    this.x += this.speed * cos(this.angle);
    this.y -= this.speed * sin(this.angle);
  }
  
  void Delete(){
    if(this.x >= width + 100 || this.x <= -100 || this.y >= height + 100 || this.y <= -100){
        this.Initialize();
    }  
  }
  
  void DrawMe(){
    noFill();
    strokeWeight(5);
    stroke(colors[2]);
    ellipse(this.x,this.y,this.w,this.h);
  }
}
  
class BigEnemy{
  float x,y,w,h,xMove,yMove,movePower,newTime,waitTime,gap;
  BigEnemy(float x,float y,float xMove,float yMove,float gap){
    this.x = x; this.y = y; this.xMove = xMove; this.yMove = yMove; movePower = 8; this.newTime = millis(); waitTime = 500; w = width; h = height; this.gap = gap;
  }
  
  void Display(){
    if(millis() - newTime < waitTime) return;
    Move();
    DrawMe();
  }
  
  void Move(){
    this.x += xMove * movePower / 2;
    this.y += yMove * movePower / 2;
    movePower -= 0.1f;
  }
  
  void DrawMe(){
    noFill();
    strokeWeight(8);
    stroke(colors[2]);
    rect(x,y,w + gap,h + gap);
  }
}
  
class Player{
  class DeadEffect{
    float x,y,size,sizeLimit,alpha;
    DeadEffect(float x,float y){
      this.x = x; this.y = y; size = 0; sizeLimit = 20; alpha = 200;
    }
    
    void Display(){
      stroke(red(colors[3]),green(colors[3]),blue(colors[3]),alpha);
      noFill();
      strokeWeight(5);
      ellipse(this.x,this.y,size,size);
      size += 10;
      alpha -= 20;
    }
  }
  
  class Shadow{
    float x,y,alpha,size;
    boolean draw;
    Shadow(float x,float y,float size,float alpha){
      this.x = x; this.y = y; this.size = size; this.alpha = alpha; draw = true;
    }
    
    void noDraw(){ draw = false; }
    
    void Display(){
      if(!draw) return;
      noStroke();
      fill(red(colors[3]),green(colors[3]),blue(colors[3]),alpha);
      ellipse(x,y,size,size);
      alpha-=30;
      if(alpha <= 0) draw = false;
    }
  }
  
  float x,y,w,h,speed;
  int alpha;
  boolean isDead,isFirstDead;
  DeadEffect effect;
  int shadowNumber,whereShadow;
  Shadow[] shadows;
  
  Player(float x,float y,float w,float h,float speed){
    this.x = x; this.y = y; this.w = w; this.h = h; this.speed = speed; alpha = 255; isDead = false; isFirstDead = true; shadowNumber = 20; whereShadow = 0; shadows = new Shadow[shadowNumber];
    //for(int i = 0; i < shadowNumber; i++){ shadows[i] = new Shadow(-50,-50,0,0); shadows[i].noDraw();}
  }
  
  void Display(){
    DrawMe();
   // DrawShadow();
    if(!isDead){
      Move();            
    }else{    
      if(isFirstDead){ effect = new DeadEffect(this.x,this.y); isFirstDead = false; }
      alpha -= 50;
      effect.Display();
    }
  }
  
  void DrawShadow(){
    for(int i = 0; i < shadowNumber; i++) shadows[i].Display();
    if(isDead) return;
    shadows[whereShadow] = new Shadow(this.x,this.y,this.w,50);
    whereShadow = (whereShadow + 1) % shadowNumber;    
  }
  
  void Move(){
    this.x -= (this.x - mouseX) / this.speed;
    this.y -= (this.y - mouseY) / this.speed;
  }
  
  void DrawMe(){
    fill(red(colors[3]),green(colors[3]),blue(colors[3]),alpha);
    noStroke();
    ellipse(this.x,this.y,this.w,this.h);
  }
  
  boolean Check(float x,float y,float r){
    float dis = pow(this.x - x,2) + pow(this.y - y,2);
    if(dis < pow(r + this.w / 2,2)) isDead = true;
    return isDead;
  }
  
  boolean CheckRect(float x,float y,float w,float h){
    if(this.y + this.w / 2 > y && this.y - this.w / 2 < y+h && this.x + this.w / 2 > x && this.x - this.w / 2 < x+w) isDead = true;
    return isDead;
  }
}
