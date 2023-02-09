color[] colors = {color(239, 245, 245),color(214, 228, 229),color(73, 113, 116),color(235, 100, 64)};
//color[] colors = {color(34,40,49),color(57,62,70),color(0,173,181),color(238,238,238)};
//color[] colors = {color(57,62,70),color(0,173,181),color(170,216,211),color(238,238,238)};
//color[] colors = {color(216,227,231),color(81,196,211),color(18,110,130),color(19,44,51)};
//color[] colors = {color(246,245,245),color(211,224,234),color(22,135,167),color(39,102,120)};
//color[] colors = {color(236,244,243),color(104,176,171),color(0,106,113),color(255,126,103)}; //good
//color[] colors = {color(239,245,245),color(215,247,245),color(42,97,113),color(243,69,115)};
State state;
float score = 0;
float[] ranking;

void setup(){
  size(600,600);
  state = new TitleState();
}

void draw(){
  background(colors[0]);
  state = state.doState();
}

abstract class State {
  State doState(){
    DrawState();
    return decideState();
  }
  abstract void DrawState();
  abstract State decideState();
}

String ToOrdinal(int num){
  String s;
  char c = str(num).charAt(str(num).length() - 1);
  if(c == '1') s = num + "st";
  else if(c == '2') s = num + "nd";
  else if(c == '3') s = num + "rd";
  else s = num + "th";
  if(num >= 10 && num <= 19) s = num + "th";
  return s;
}

void RankingLoad(){
  String[] _ranking = loadStrings("data/ranking.csv");
  ranking = new float[ _ranking.length];
  for(int i = 0; i < _ranking.length; i++){
    ranking[i] = float(_ranking[i]);
  }
  
}
