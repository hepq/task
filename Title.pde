class TitleState extends State {
    Button startButton,rankButton;
    State nextState;
    int buttonX,buttonY,buttonGap;
    PImage rank;
    Curtain curtain;
    TitleState(){
      buttonX = 160; buttonY = 70; buttonGap = 30;
      startButton = new Button((width-buttonX)/2,400,buttonX,buttonY,colors[1],"START",32,3,colors[2]);
      
      startButton.SetPushEvent(new ButtonEvent(){
        @Override
        void Event(){
          startButton.pushEnable(false);
          curtain = new Curtain(colors[0],new CurtainEvent(){
            @Override
            void Event(){ nextState = new GameState();}
          },20f,0f);
        }
       });
      
      rankButton = new Button(555,5,40,40,colors[2],"",32,3,colors[2]);
      rankButton.SetPushEvent(new ButtonEvent(){
        @Override
        void Event(){
          rankButton.pushEnable(false);
          curtain = new Curtain(colors[0],new CurtainEvent(){
            @Override
            void Event(){ nextState = new RankState(); }
          },20f,0f);
        }
      });
      rank = loadImage("rank4.png");
      curtain = new Curtain(colors[0],new CurtainEvent(){ @Override void Event(){} },-20f,255f);
      nextState = this;
      RankingLoad();
    }

    void DrawState(){
      textSize(50);
      textAlign(CENTER,CENTER);
      fill(colors[2]);
      noFill();
      text("GameTitle",width * 0.5,height * 0.3);
      startButton.Display();
      rankButton.Display();      
      image(rank,559,9);
      curtain.Display();
    }
    
    State decideState(){
      return nextState;
    }
}
