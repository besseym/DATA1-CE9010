void setup(){
  size(400, 400);
}

void draw(){
  background(0);
  text(frameCount + " frames have passed since this application started running.", 10, height/2);
  
  if(frameCount % 60 == 0){
    rect(0, 0, width, height);
  }
}
