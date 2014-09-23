
color bgColor;

float total;

int sliceIndex;
float startAngle;

float pieWidth;
float pieHeight;

float pieCenterX;
float pieCenterY;

float calcSliceSize(float value){
  
  if((value + total) > 100){
    value = 100 - total;
  }
  
  total = total + value;
  
  return (2 * PI) * (value / 100);
}

void drawSlice(float value){
  
  float sliceSize = calcSliceSize(value);
  
  float endAngle = startAngle + sliceSize;
  
  arc(pieCenterX, pieCenterY, pieWidth, pieHeight, startAngle, endAngle);
  startAngle += sliceSize;
  sliceIndex++;
}

void drawPieGraph(float v1, float v2, float v3, float v4, float v5){
  
  fill(#8dd3c7);
  drawSlice(v1);
  
  fill(#ffffb3);
  drawSlice(v2);
  
  fill(#bebada);
  drawSlice(v3);
  
  fill(#fb8072);
  drawSlice(v4);
  
  fill(#80b1d3);
  drawSlice(v5);
  
  if(total < 100){
    drawSlice(100 - total);
  }
} 

void setup(){
  
  size(400, 400);
  smooth();
  
  total = 0.0;
  
  sliceIndex = 0;
  startAngle = 0.0;
  
  pieWidth = width * 0.75;
  pieHeight = height * 0.75;
  
  pieCenterX = width * 0.5;
  pieCenterY = height * 0.5;
  
  bgColor = color(220);
  background(bgColor);
}

void draw(){
  
  background(bgColor);
  
  total = 0.0;
  
  sliceIndex = 0;
  startAngle = 0.0;
  
  drawPieGraph(10, 20, 25, 35, 50);
}


