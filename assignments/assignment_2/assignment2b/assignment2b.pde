
color bgColor;

float barIndex;
float barHeight;
float barStart;
float barMaxHeight;


float calcBarWidth(float value){
  return barMaxHeight / value;
}

void drawBar(float value){
  
  float barWidth = calcBarWidth(value);
  
  rect(50, barStart, barWidth, barHeight);
}

void setup(){
  
  size(300, 400);
  
  barIndex = 0;
  barHeight = 20;
  barStart = 20;
  barMaxHeight = 200;
  
  rectMode(CORNER);
  
  colorMode(HSB, 359, 100, 100);
  bgColor = color(220);
  background(bgColor);
}

void draw(){
  
  drawBar(100);
}
