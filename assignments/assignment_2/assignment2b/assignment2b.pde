
color bgColor;

float barIndex;
float barHeight;
float barMaxWidth;

float startX;
float startY;

float calcBarWidth(float value){
  
  if(value > 100){
    value = 100;
  }
  
  return barMaxWidth * (value / 100);
}

void drawBar(float value){
  
  float barWidth = calcBarWidth(value);
  
  float brightness = barWidth * 0.5;
  fill(200, 99, brightness);
  rect(startX, barIndex * startY, barWidth, barHeight);
  barIndex = barIndex + 1;
}

void drawBarGraph(float v1, float v2, float v3, float v4, float v5, float v6, float v7, float v8){
  
  drawBar(v1);
  drawBar(v2);
  drawBar(v3);
  drawBar(v4);
  drawBar(v5);
  drawBar(v6);
  drawBar(v7);
  drawBar(v8);
}

void setup(){
  
  size(300, 400);
  
  barIndex = 1;
  
  barHeight = height * 0.1;
  barMaxWidth = width * 0.8;
  
  startX = width * 0.1;
  startY = height * 0.1;
  
  rectMode(CORNER);
  
  bgColor = color(220);
  colorMode(HSB, 359, 100, 100);
  
  background(bgColor);
}

void draw(){
  
  background(bgColor);
  
  barIndex = 1;
  
  drawBarGraph(100, 65, 35, 80, 10, 85, 20, 45);
}
