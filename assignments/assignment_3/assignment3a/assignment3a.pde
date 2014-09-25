
color bgColor;

int numOfBars;

float padT, padR, padB, padL;

float barHeight;
float barMaxWidth;

float [] dataArray;

void drawBar(float index, float value){
  
  if(value > 100){
    value = 100;
  }
  
  if(value < 0){
    value = 0;
  }
  
  float barWidth = barMaxWidth * (value / 100);
  
  float x = padL;
  float y = (index * barHeight) + padT;
  
  float brightness = barWidth * 0.5;
  fill(200, 99, brightness);
  rect(x, y, barWidth, barHeight);
  
  int textSize = 18;
  textSize(textSize);
  
  String vStr = nf(value, 0, 2);
  float textWidth = textWidth(vStr);
  
  float textS = (textWidth * 0.1);
  float textX = x + barWidth - textWidth - textS;
  float textY = y + (barHeight * 0.5) + (textSize * 0.4);
  
  if(textX < x){
    textX = x + barWidth + textS;
    fill(0, 99, 0);
  }
  else {
    fill(0, 0, 99);
  }
  
  text(vStr, textX, textY);
}

void setup(){
  
  size(600, 400);
  
  rectMode(CORNER);
  
  numOfBars = 15;
  
  //padding
  padT = height * 0.05; 
  padR = width * 0.05; 
  padB = height * 0.05; 
  padL = width * 0.05;
  
  barHeight = (height - (padT + padB)) / numOfBars;
  barMaxWidth = (width - (padL + padR));
  
  bgColor = color(220);
  colorMode(HSB, 359, 100, 100);
  
  dataArray = new float[numOfBars];
  for(int i = 0; i < dataArray.length; i++){
    dataArray[i] = random(101);
  }
  
  println(dataArray);
}

void draw(){
  
  background(bgColor);
  
  for(int i = 0; i < dataArray.length; i++){
    drawBar(i, dataArray[i]);
  }
}
