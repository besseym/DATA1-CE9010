float value = 0;
float targetValue = 0;
float speed = 0.01;

void setup() {
  size(500,500);
}

void draw() {
  background(100);

  //Easing
  value += (targetValue - value) * speed;

  println("targetValue: " + targetValue + "\t value: " + value);
  
  float x = map(value, 0, 1, 0, width);
  float y = height/2;
  
  ellipse(x, y, 100, 100);
}

void mousePressed() {
  // This is a short way to do a switch:
  // if targetValue == 1, change it to 0;
  // else, change it to 1.
  targetValue = (targetValue == 1) ? (0):(1);
}
