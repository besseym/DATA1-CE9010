int scheduledTime;

void setup(){
  size(400, 400);
  scheduledTime = 10000;
}

void draw(){
  background(0);
  int diff = scheduledTime - millis();
  text("I still have " + diff + " milliseconds before my scheduled time.", 10, height/2);
}
