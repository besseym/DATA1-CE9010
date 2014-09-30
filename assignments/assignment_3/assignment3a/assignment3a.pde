
color bgColor;

String title;

int numOfBars;

float padT, padR, padB, padL, padLS;

float barHeight;
float barMaxWidth;

float [] dataArray;
String [] labelArray;

float hue;

int textSize;

void drawBar(int index, float value){
  
  float x = 0;
  float y = map(index, 0, dataArray.length - 1, 0, height - barHeight - (padT + padB));
  
  float barWidth = map(value, 0, max(dataArray), 0, barMaxWidth);
  
  float brightness = map(value, 0, max(dataArray), 0, 100);
  fill(hue, 100, brightness);
  
  //draw bar
  rect(x + padL, y + padT, barWidth, barHeight);
  
  String vStr = nf(value, 0, 2);
  float textWidth = textWidth(vStr);
  float textS = (textWidth * 0.1);
  
  float textX = barWidth + padL + textS;
  float textY = y + padT + (barHeight * 0.25);
  
  textAlign(LEFT);
  fill(0, 100, 0);
  
  //draw value label
  pushMatrix();
  translate(textX, textY);
  rotate(radians(30)) ;
  text(vStr, 0, 0);
  popMatrix();
  
  //draw item label
  fill(0, 100, 0);
  textAlign(RIGHT);
  
  text(labelArray[index], padL - padLS, y + padT + (barHeight * 0.5) + textDescent());
}

void drawBars(){
  
  for(int i = 0; i < dataArray.length; i++){
    drawBar(i, dataArray[i]);
  }
}

void drawScale(){
  
  stroke(0, 0, 80);
  strokeWeight(1);
  
  float x1, x2, y1, y2, textY;
  
  textAlign(CENTER);
  
  int spacing = int(max(dataArray) / dataArray.length);
  for(int i = 0; i <= max(dataArray); i += spacing){
    
    x1 = map(i, 0, max(dataArray), 0, barMaxWidth);
    x1 = x1 + padL;
    x2 = x1;
    y1 = padT;
    y2 = height - padB;
   
    line(x1, y1, x2, y2);
    
    textY = y2 + textDescent() + (padB * 0.5);
    text(i, x1, textY);
  }
}

void setup(){
  
  size(600, 400);
  smooth();
  
  rectMode(CORNER);
  
  bgColor = color(220);
  colorMode(HSB, 360, 100, 100);
  
  numOfBars = int(random(1, 20)) + 1;
  textSize = int(map(numOfBars, 1, 20, 18, 10));
  textSize(textSize);
  
  title = "Lorem Ipsum";
  
  //padding
  padT = height * 0.10;
  padR = width * 0.10; 
  padB = height * 0.10;
  
  labelArray = new String[] {"Lorem", "Ipsum", "Dolor", "Sit", "Amet", "Consectetur", "Adipiscing", "Elit", "Duis", "Pharetra", "Quam", "Sed", "Tempor", "Dictum", "Massa", "Lacus", "Convallis", "Justo", "Sed", "Mattis"};
  
  float maxLabelWidth = 0;
  
  float textWidth = 0;
  for(int i = 0; i < labelArray.length; i++){
    textWidth = textWidth(labelArray[i]);
    if(textWidth > maxLabelWidth){
      maxLabelWidth = textWidth;
    }
  }
  
  padL = maxLabelWidth;
  padLS = (padL * 0.1);
  padL = padL + (2 * padLS);
  
  barHeight = ((height - (padT + padB)) / numOfBars);
  barHeight = barHeight - (barHeight * 0.3);
  barMaxWidth = (width - (padL + padR));
  
  dataArray = new float[numOfBars];
  for(int i = 0; i < dataArray.length; i++){
    dataArray[i] = random(101);
  }
  
  hue = 200.0;
}

void draw(){
  
  background(bgColor);
  
  textSize(24);
  textAlign(CENTER);
  text(title, width * 0.5, (padT * 0.5) + textDescent());
  
  textSize(textSize);
  
  drawScale();
  drawBars();
}
