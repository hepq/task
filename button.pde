enum ButtonState{
    PushButtonFirst,
    PushButton,
    PushOut,
    OnButton,
    NoTouch
}

interface ButtonEvent{
  void Event();
}

class Button{
  float startX,startY,sizeX,sizeY;
  ButtonState state;
  boolean beforeMouse,canPush;
  ButtonEvent pushEvent,longPushEvent;
  color baseColor,textColor;
  int normalAlpha;
  int hoverAlpha;
  int pushAlpha;
  String text;
  int textSize;
  int valueY;
  
  Button(float _startX,float _startY,float _sizeX,float _sizeY,color baseColor,String text,int textSize,int valueY,color textColor){
    startX = _startX;
    startY = _startY;
    sizeX = _sizeX;
    sizeY = _sizeY;
    this.baseColor = baseColor;
    this.textColor = textColor;
    this.text = text;
    this.textSize = textSize;
    this.valueY = valueY;
    
    beforeMouse = true;
    state = ButtonState.NoTouch;
    normalAlpha = 255;
    hoverAlpha = 160;
    pushAlpha = 220;
    canPush = true;
    
    this.pushEvent = new ButtonEvent(){@Override void Event(){}};
    this.longPushEvent = new ButtonEvent(){@Override void Event(){}};
  }
  
  void SetPushEvent(ButtonEvent event){
    this.pushEvent = event;
  }
  
  void SetLongPushEvent(ButtonEvent event){
    this.longPushEvent = event;
  }
  
  void pushEnable(boolean b){
    canPush = b;
  }
  
  boolean isOverlap(){
    return (mouseX >= startX && mouseX <= startX + sizeX && mouseY >= startY && mouseY <= startY + sizeY);
  }
  
  void Display(){
    state = WhatState();
    DoDraw();
    
    if(state == ButtonState.PushButtonFirst && canPush){
      pushEvent.Event();
    }
    if(state == ButtonState.PushButton && canPush){
      longPushEvent.Event();
    }
  }
  
  ButtonState WhatState(){
    ButtonState returnState;
    if(isOverlap()){
      if(mousePressed){
        if(state == ButtonState.PushButtonFirst || state == ButtonState.PushButton) returnState = ButtonState.PushButton;
        else if(!beforeMouse) returnState = ButtonState.PushButtonFirst;
        else returnState = ButtonState.OnButton;
      }
      else returnState = ButtonState.OnButton;
    }else returnState = ButtonState.NoTouch;
    
    beforeMouse = mousePressed;
    return returnState;
  }
  
  color ButtonColor(color material){
    color base = color(red(material),green(material),blue(material),normalAlpha);
    color on = color(red(material),green(material),blue(material),hoverAlpha);
    color push = color(red(material),green(material),blue(material),pushAlpha);
    
    switch(state){
      case PushButtonFirst:
        return push;
      case PushButton:
        return push;
      case PushOut:
        return base;
      case OnButton:
        return on;
      case NoTouch:
        return base;
      default:
        color error = #ff00ff;
        return error;
    }
  }
  
  void DoDraw(){
    noStroke();
    textSize(textSize);
    textAlign(CENTER,CENTER);
    fill(ButtonColor(baseColor));
    rect(startX,startY,sizeX,sizeY,5);
    fill(ButtonColor(textColor));
    text(text,startX,startY-valueY,sizeX,sizeY);
  }
}
