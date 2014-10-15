int posX;

void setup(){
  size(400, 400);
}

void draw(){
  background(0);
  rect(posX, height/2, 40, 40);
  posX ++;
}
