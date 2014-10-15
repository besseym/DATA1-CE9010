float value = 0;
float targetValue = 0;
float speed = 0.1;

int nScreens = 4;

void setup() {
  size(500,500);
}

void draw() {
  background(100);

  //Easing
  value += (targetValue - value) * speed;

  println("targetValue: " + targetValue + "\t value: " + value);
  
  float x = map(value, 0, 1, 0, -width);
  
  pushMatrix();
  translate(x, 0);
  
    for(int i = 0; i < nScreens; i++){
      stroke(0);
      strokeWeight(10);
      fill(255);
      rect(0, 0, width, height);
      
      textAlign(CENTER, CENTER);
      fill(0);
      text("chart " + i, width/2, height/2);
      
      translate(width, 0);      
    }
  popMatrix();
}

void keyPressed() {
  if(key == CODED){
    if(keyCode == LEFT){
      if(targetValue > 0){
        targetValue --;
      }
    }else if(keyCode == RIGHT){
      if(targetValue < nScreens - 1){
        targetValue ++;
      }
    }
  }
}
