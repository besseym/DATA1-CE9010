int[] population = {37239000, 26746000, 22868000,
                    22826000, 21766000, 21241000,
                    20877000,20673000, 20568000,
                    20032000};

String[] name = {"Tokyo", "Jakarta", "Seoul",
                 "Delhi", "Shanghai", "Manila",
                 "Karachi", "New York", "Sao Paulo",
                 "Mexico City"};

float hMargin = 100;
float vMargin = 100;

void setup(){
  size(500, 500);
  colorMode(HSB);
}

void draw(){
  background(0);

  drawScale();  
  drawBars();
}

void drawScale(){
  for(int i = 0; i < max(population); i += 5000000){
//    println(i);
    float x1, y1, x2, y2;
    x1 = hMargin;
    x2 = width - hMargin;
    y1 = map(i,
             0, max(population),
             height - vMargin, vMargin);
                         
    y2 = y1;
    stroke(200);
    line(x1, y1, x2, y2);
    textAlign(RIGHT);
    fill(255);
    text(i, x1 - 10, y1);
  }  
}

float value = 0;
float targetValue = 0;
float speed = 0.01;

void drawBars(){
  // Drawing my bars
  for(int i = 0; i < population.length; i++){
    float barX, barY, barWidth, barHeight;
    barWidth = 20;
    barHeight = map(population[i],
                    0, max(population),
                    0, height - 2 * vMargin);
    barX = map(i,
               0, population.length - 1,
               0 + hMargin, width - barWidth - hMargin);
    barY = height - vMargin;
    noStroke();
    float brightness = map(population[i],
                           0, max(population),
                           0, 255);
    fill(120, 255, brightness);
    
    value += (targetValue - value) * speed;
    float currHeight = map(value, 0, 1, 0, barHeight);    
    rect(barX, barY, barWidth, -currHeight);
    
    
    
    pushMatrix();
      translate(barX + barWidth/2, height - vMargin + 20);
      rotate(radians(-45));
      textAlign(RIGHT);
      fill(255);
      text(name[i], 0, 0);
    popMatrix();    
  }
}

void mousePressed() {
  // This is a short way to do a switch:
  // if targetValue == 1, change it to 0;
  // else, change it to 1.
  targetValue = (targetValue == 1) ? (0):(1);
}

