class RankTable{
  float x,y,dis,scroll,scrollSpeed,upA,downA,bottom;
  String[] s;
  Button up,down;
  PImage image_u,image_d;
  RankTable(float x,float y,float dis){
    this.x = x; this.y = y; this.dis = dis; this.scroll = 0; this.scrollSpeed = 5; this.upA = 255; this.downA = 0; this.bottom = (ranking.length - 6) * dis * -1;
    s = new String[ranking.length];
    up = new Button(x+70,y-65,50,30,colors[1],"",20,3,colors[2]);
    down = new Button(x+70,y+304,50,30,colors[1],"",20,3,colors[2]);
    up.SetLongPushEvent(new ButtonEvent(){
      @Override
      void Event(){
        scroll += scroll < 0 ? scrollSpeed : 0;
        
      }
    });
    down.SetLongPushEvent(new ButtonEvent(){
      @Override
      void Event(){
        scroll -= scroll > bottom ? scrollSpeed : 0;
      }
    });
    for(int i = 0; i < ranking.length; i++) s[i] = str(round(ranking[i] * 10f)/10f);
    image_u = loadImage("up.png");
    image_d = loadImage("down.png");
  }
  void Display(){
    for(int i = 0; i < ranking.length; i++){
      textAlign(LEFT,TOP);
      float gap = 0;
      if(i == 0){ textSize(45); fill(colors[3]); gap = -30;}
      else if(i == 1){ textSize(40); fill(colors[2]); gap = -15;}
      else if(i == 2){ textSize(35); fill(colors[2]); gap = -6;}
      else { textSize(30); fill(colors[2]); }
      text(ToOrdinal(i+1),x,y + i * dis + gap + scroll);
      text(s[i],x + 100,y + i * dis + gap + scroll);
    }
    fill(colors[0]);
    rect(x,y-30,200,-200);
    rect(x,y+300,200,200);
    up.Display();
    down.Display();
    image(image_u,x+86,y-58);
    image(image_d,x+86,y+312);
    
    fill(red(colors[0]),green(colors[0]),blue(colors[0]),upA);
    rect(x+70,y-65,50,30);
    fill(red(colors[0]),green(colors[0]),blue(colors[0]),downA);
    rect(x+70,y+304,50,30);
    
    if(scroll >= -50) upA = map(scroll + 50,0,50,0,255);
    else upA = 0;
    if(scroll <= bottom + 50) downA = map(-1 * scroll + bottom + 50,0,50,0,255);
    else downA = 0;
  }
}
