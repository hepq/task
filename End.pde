class EndState extends State {
  Button titleButton;
  State nextState;
  Curtain curtain;
  int buttonX,buttonY,num;
  EndState(){
    buttonX = 140;
    buttonY = 70;

    titleButton = new Button((width-buttonX)/2,400,buttonX,buttonY,colors[1],"TITLE",32,3,colors[2]);
    titleButton.SetPushEvent(new ButtonEvent(){
      @Override
      void Event(){
        titleButton.pushEnable(false);
        curtain = new Curtain(colors[0],new CurtainEvent(){
          @Override
          void Event(){ nextState = new TitleState(); }
        },20f,0f);
      }
    });
    
    nextState = this;
    curtain = new Curtain(colors[0],new CurtainEvent(){
      @Override
      void Event(){}
    },-10f,255f);
    num = CheckRank();
    saveStrings("data/ranking.csv",str(ranking));
  }
    
  void DrawState(){
    textSize(50);
    textAlign(CENTER,CENTER);
    fill(colors[2]);
    text("GameOver",width * 0.5,height * 0.3);
    textSize(30);    
    textAlign(LEFT,CENTER);
    if(num == 1) fill(colors[3]);
    text(ToOrdinal(num),width * 0.42,height * 0.45);
    fill(colors[2]);
    text("Time : " + score + " ",width * 0.42,height * 0.55);
    
    noFill();
    strokeWeight(3);
    stroke(colors[1]);
    line(width*0.38,height*0.44,width*0.38,height*0.575);
    line(width*0.39,height*0.44,width*0.39,height*0.575);
    titleButton.Display();
    curtain.Display();
  }
  
  State decideState(){
    return nextState;
  }
  
  int CheckRank(){    
    for(int i = 0; i < ranking.length; i++){
      if(score >= ranking[i]){
        ranking = splice(ranking,score,i);
        return i+1;
      }
    }
    ranking = splice(ranking,score,ranking.length);
    return ranking.length;
  }
}
