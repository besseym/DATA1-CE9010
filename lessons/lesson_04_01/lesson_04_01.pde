
color bgColor;

float barX, barY, barWidth, barHeight;

float hMargin, vMargin;

int[] population;
String[] name;

void setup(){

  size(800, 400);
  
  bgColor = color(220);
  colorMode(HSB, 359, 100, 100);
  
  barX = 0;
  barY = height;
  barWidth = 20;
  barHeight = 0;
  
  hMargin = 80;
  vMargin = 65;
  
  population = new int []{37239000, 26746000, 22868000,
                          22826000, 21766000, 21241000,
                          20877000,20673000, 20568000,
                          20032000};
  
  name = new String [] {"Tokyo", "Jakarta", "Seoul",
                           "Delhi", "Shanghai", "Manila",
                           "Karachi", "New York", "Sao Paulo",
                           "Mexico City"};
}

void draw(){

  background(bgColor);
  
  drawScale();
  drawBars();
}

void drawScale(){
  
  for(int i = 0; i <= max(population); i += 5000000){
    
    float x1, x2, y1, y2;
    
    x1 = hMargin;
    x2 = width - hMargin;
    y1 = map(i, 0, max(population), height - vMargin, vMargin);
    y2 = y1;
    
    stroke(1);
    line(x1, y1, x2, y2);
    
    textAlign(RIGHT);
    text(i, x1 - (hMargin * 0.1), y1);
  }
}

void drawBars(){
  
  for(int i = 0; i < population.length; i++){
    
    barX = map(i, 0, population.length - 1, 0, width - barWidth - (2 * hMargin));
    
    barHeight = map(population[i], 0, max(population), 0, height - (2 * vMargin));
    
    float brightness = map(population[i], 0, max(population), 0, 99);
    
    fill(200, 99, brightness);
    rect(barX + hMargin, barY - vMargin, barWidth, -barHeight);
    
    
    fill(0, 99, 0);
    
    pushMatrix();
    translate((barX + hMargin) + (barWidth * 0.5), height - (vMargin * 0.5));
    rotate(radians(-45));
    textAlign(CENTER);
    text(name[i], 0, 0);
    popMatrix();
  }
}
