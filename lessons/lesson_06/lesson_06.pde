
int btX, btY, btWidth, btHeight;
float btHue, btBrightness;

String label;

boolean isPaused;
boolean isOverButton;

void setup(){
  
  size(400, 400);
  
  colorMode(HSB);
  
  btWidth = 120;
  btHeight = 60;
  btX = (width/2) - (btWidth/2);
  btY = (height/2) - (btHeight/2);
  
  btHue = 140;
  btBrightness = 120;
  
  label = "PLAY";
  isPaused = false;
  isOverButton = false;
  
  textAlign(CENTER, CENTER);
}

void draw(){
  
  background(255);
  
  if(isOverButton){
    btBrightness = 225;
  }
  else {
    btBrightness = 120;
  }
  
  if(isPaused){
    label = "PAUSED";
  }
  else {
    label = "PLAY";
  }
  
  fill(btHue, 255, btBrightness);
  rect(btX, btY, btWidth, btHeight, 10);
  
  fill(255);
  text(label, btX, btY, btWidth, btHeight);
}

void mouseReleased(){
  
  if(isOverButton){
    
    isPaused = !isPaused;
  }
}

void mouseMoved(){
  
  if((mouseX >= btX && mouseX <= (btX + btWidth) && mouseY >= btY && mouseY <= (btY + btHeight))){
    isOverButton = true;
  }
  else {
    isOverButton = false;
  }
}




