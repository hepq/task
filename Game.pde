class GameState extends State {
  float startTimeEnemy,GameStartTime,timeEnemy,disEnemy,subtractTime,timeBig,startTimeBig,disBig,curtainA;
  int enemyNumber,whereEnemy,warnNumber,patternBig,whereBigEnemy,bigNumber;
  boolean isFirstDead;
  Enemy[] enemys;
  Player player;
  Warn[] warns;
  BigEnemy[] bigEnemys;
  State nextState;
  Curtain curtain;
  CurtainEvent event;
  
  GameState(){
    player = new Player(width/2,height + 50,40,40,8);
    nextState = this;
    curtainA = 0;
    startTimeEnemy = millis();
    GameStartTime = millis();
    enemyNumber = 50;
    warnNumber = 3;
    whereEnemy = 0;
    whereBigEnemy = 0;
    bigNumber = 3;
    disEnemy = 1200;
    subtractTime = 20;
    startTimeBig = millis();
    disBig = 3500;
    patternBig = (int)random(0,4);
    enemys = new Enemy[enemyNumber];
    bigEnemys = new BigEnemy[bigNumber];
    warns = new Warn[3];
    for(int i = 0; i < enemyNumber; i++){
      enemys[i] = new Enemy(0);
      enemys[i].Initialize();
    }
    for(int i = 0; i < warnNumber; i++) warns[i] = new Warn(0,-150);
    for(int i = 0; i < bigNumber; i++) bigEnemys[i] = new BigEnemy(-1000,0,0,0,10);
    event = new CurtainEvent(){
      @Override
      void Event(){
        nextState = new EndState();
      }
    };
    isFirstDead = true;
  }
  
  void DrawState(){
    timeEnemy = millis() - startTimeEnemy;
    timeBig = millis() - startTimeBig;
    player.Display();
    DrawEnemy();
    DrawBig();    
    DrawTime();
    DrawCurtain();
  }
    
  void DrawEnemy(){
    if(timeEnemy >= disEnemy && enemys[whereEnemy].state != 1){
      enemys[whereEnemy].state = 1;
      whereEnemy = (whereEnemy + 1) % enemyNumber;
      disEnemy -= disEnemy <= 300 ? 0 : subtractTime;      
      subtractTime -= subtractTime <= 5 ? 0 : 0.2f;
      startTimeEnemy = millis();
      println(disEnemy);
      if(subtractTime <= 5) println("get");
    }    
    for(int i = 0; i < enemyNumber; i++){
      Enemy now = enemys[i];
      if(now.state == 1){
        now.Forward();
        now.DrawMe();
        now.Delete();
      }
    }
  }
  
  void DrawBig(){
    float gap = 10;
    float speed = 2;
    float subtractTimeBig = 100;
    
    for(int i = 0; i < warnNumber; i++) warns[i].Display();
    for(int i = 0; i < bigNumber; i++) bigEnemys[i].Display();
    if(timeBig < disBig) return;
    disBig -= disBig <= 1300 ? 0 : subtractTimeBig;
    patternBig += (int)random(1,4);
    patternBig %= 4;    
    switch(patternBig){
      case 0:
        for(int i = 0; i < warnNumber; i++) warns[i] = new Warn(150 * i + 150,130);
        bigEnemys[whereBigEnemy] = new BigEnemy(gap / -2,-1 * height - gap / 2,0,speed,gap);
        break;
      case 1:
        for(int i = 0; i < warnNumber; i++) warns[i] = new Warn(150 * i + 150,470);
        bigEnemys[whereBigEnemy] = new BigEnemy(gap / -2,height + gap / 2,0,-1 * speed,gap);
        break;
      case 2:
        for(int i = 0; i < warnNumber; i++) warns[i] = new Warn(130,150 * i + 150);
        bigEnemys[whereBigEnemy] = new BigEnemy(-1 * height - gap / 2,gap / -2,speed,0,gap);
        break;
      case 3:
        for(int i = 0; i < warnNumber; i++) warns[i] = new Warn(470,150 * i + 150);
        bigEnemys[whereBigEnemy] = new BigEnemy(height + gap / 2,gap / -2,-1 * speed,0,gap);
        break;
    }
    whereBigEnemy = (whereBigEnemy + 1) % bigNumber;
    startTimeBig = millis();
  }
  
  void DrawCurtain(){
    if(!player.isDead) return;
    if(isFirstDead) curtain = new Curtain(colors[0],event,10,0);
    curtain.Display();
    isFirstDead = false;
  }
  
  void DrawTime(){
    if(!player.isDead) score = round((millis() - GameStartTime) / 100f) / 10f;
    fill(colors[2]);
    textSize(20);
    textAlign(LEFT,TOP);
    text("Time : " + score,10,5);
  }
  
  boolean CheckTouch(){
    for(int i = 0; i < enemyNumber; i++){
      Enemy now = enemys[i];
      if(now.state == 1) if(player.Check(now.x,now.y,now.w/2)) return true;
    }
    for(int i = 0; i < bigNumber; i++){
      BigEnemy now = bigEnemys[i];
      if(player.CheckRect(now.x,now.y,now.w + now.gap,now.h + now.gap)) return true;
    }
    return false;
  }
  
  State decideState(){
    CheckTouch();
    return nextState;
  }
}
