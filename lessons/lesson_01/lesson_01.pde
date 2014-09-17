
//size(400, 200);
//background(100);
//rect(50, 50, 50, 20);
//ellipse(100, 50, 80, 40);

PFont futura;

void setup(){
  
  size(600, 300);
  frameRate(100);
  
  futura = loadFont("Futura-Medium-48.vlw");
}

void draw(){
  
  background(300);
  
  rectMode(CENTER);
  rect(100, 100, 50, 50);
  
  fill(255, 50);
  ellipseMode(CENTER);
  ellipse(mouseX, mouseY, 50, 50);
  
  textFont(futura);
  textAlign(CENTER, CENTER);
  text("My Text", 200, 200);
  
//  println(mouseX + ", " + mouseY);
}
