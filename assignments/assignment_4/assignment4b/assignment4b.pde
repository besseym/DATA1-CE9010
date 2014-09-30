

color bgColor;

String[] nameArray;
int[] populationArray;
float[] radiusArray;

color[] palletArray;

float total = 0.0;

float pieWidth;
float pieHeight;

float pieCenterX;
float pieCenterY;

void setup(){
  
  size(500, 500);
  smooth();
  
  bgColor = color(100);
  
  palletArray = new color[] {#8dd3c7, #ffffb3, #bebada, #fb8072, #80b1d3, #fdb462, #b3de69, #fccde5, #d9d9d9, #bc80bd};
  
  nameArray = new String [] {"Tokyo", "Jakarta", "Seoul",
                           "Delhi", "Shanghai", "Manila",
                           "Karachi", "New York", "Sao Paulo",
                           "Mexico City"};
  
  populationArray = new int []{37239000, 26746000, 22868000,
                          22826000, 21766000, 21241000,
                          20877000,20673000, 20568000,
                          20032000};
                          
  total = 0.0;
  for(int i = 0; i < populationArray.length; i++){
    total += populationArray[i];
  }
  
  pieWidth = width * 0.75;
  pieHeight = height * 0.75;
  
  pieCenterX = width * 0.5;
  pieCenterY = height * 0.5;
  
  noStroke();
  textAlign(CENTER);
  
}

void draw(){

  background(bgColor);
  
  float sliceSize = 0.0;
  float startAngle = 0.0;
  float endAngle = 0.0;
  
  float value = 0.0;
  for(int i = 0; i < populationArray.length; i++){
    
    value = populationArray[i];
    sliceSize = map(value, 0, total, 0, 360);
    endAngle = startAngle + sliceSize;
    
    //draw pie slice
    fill(palletArray[i]);
    arc(pieCenterX, pieCenterY, pieWidth, pieHeight, radians(startAngle), radians(endAngle));
    
    fill(#000000);
    
    pushMatrix();
    
    translate(pieCenterX, pieCenterY);
    rotate(radians(startAngle + (sliceSize * 0.5))) ;
    translate((pieWidth * 0.3), 0);
    
    //draw item label
    textSize(18);
    text(nameArray[i], 0, 0);
    
    translate(0, textAscent());
    
    //draw value label
    textSize(10);
    text("(" + populationArray[i] + ")", 0, 0);
    
    popMatrix();
    
    startAngle = endAngle;
  }
}
