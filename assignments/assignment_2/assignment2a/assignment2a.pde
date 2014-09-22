
color bgColor;
color pieColor;

int pieIndex;
float startAngle;

color [] colorArray;

float calcPieSize(float value){
  return (2 * PI) * (value / 100);
}

void drawPie(float value){
  
  float pieSize = calcPieSize(value);
  
  float endAngle = startAngle + pieSize;
  if(endAngle <= (2 * PI)){
    
    fill(colorArray[pieIndex % colorArray.length]);
    arc(200, 200, 250, 250, startAngle, endAngle);
    startAngle += pieSize;
    pieIndex++;
  }
}

void setup(){
  
  size(400, 400);
  smooth();
  
  pieIndex = 0;
  startAngle = 0;
  
  colorArray = new color [10];
  colorArray[0] = color(#8dd3c7);
  colorArray[1] = color(#ffffb3);
  colorArray[2] = color(#bebada);
  colorArray[3] = color(#fb8072);
  colorArray[4] = color(#80b1d3);
  
//  colorMode(HSB, 359, 100, 100);
  bgColor = color(220);
  background(bgColor);
}

void draw(){
  
  background(bgColor);
  
  pieIndex = 0;
  startAngle = 0;
  
  drawPie(10);
  drawPie(40);
  drawPie(25);
  drawPie(5);
  drawPie(20);
}


