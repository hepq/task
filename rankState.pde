class RankState extends State {
    State nextState;
    PImage back;
    Curtain curtain;
    Button backButton;
    RankTable rankTable;
    RankState(){
      nextState = this;
      curtain = new Curtain(colors[0],new CurtainEvent(){ @Override void Event(){} },-20f,255f);
      backButton = new Button(555,5,40,40,colors[2],"",32,3,colors[2]);
      backButton.SetPushEvent(new ButtonEvent(){
        @Override        
        void Event(){
          backButton.pushEnable(false);
          curtain = new Curtain(colors[0],new CurtainEvent(){
            @Override
            void Event(){ nextState = new TitleState(); }
          },20f,0f);
        }
      });
      back = loadImage("return2.png");
      rankTable = new RankTable(210,220,50);
    }

    void DrawState(){
      rankTable.Display();
      textSize(50);
      textAlign(CENTER,CENTER);
      fill(colors[2]);
      noFill();
      text("Ranking",width * 0.5,height * 0.17);          
      backButton.Display();
      image(back,559,9);     
      curtain.Display();
    }
    
    State decideState(){
      return nextState;
    }
}
