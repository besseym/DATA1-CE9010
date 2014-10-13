
class Bubble {
  
  color c;
  float x, y, r;
  
  String label;
  
  public Bubble(float x, float y, float r){
    
    this.x = x;
    this.y = y;
    this.r = r;
    
    this.label = "(" + x + "," + y + ")";
  }
  
  public void setLabel(String label){
    this.label = label;
  }
  
  public void setColor(color c) {
    this.c = c;
  }
  
  public boolean isMouseOver(float x, float y){
    return (dist(this.x, this.y, x, y) < this.r);
  }
  
  public void display(){
    
    noStroke();
    
    fill(this.c);
    
//    if(this.isMouseOver(mouseX, mouseY)){
//      textAlign(CENTER);
//      text(label, this.x, this.y - 20);
//    }
    
    ellipseMode(RADIUS);
    ellipse(this.x, this.y, this.r, this.r);
  }
}

class StatusBubble extends Bubble {
  
  private StatusAnalysis status;
  
  public StatusBubble(float x, float y, float r){
    
    super(x, y, r);
  }
  
  public void display(){
    
    super.display();
    
    if(this.isMouseOver(mouseX, mouseY)){
//      textAlign(CENTER);

      colorMode(RGB);
      fill(225);
      rect(this.x, this.y - 20, 100, 100);
      
      fill(0);
      text(status.getText(), this.x, this.y - 20, 100, 100);
    }
  }
  
  public void setStatus(StatusAnalysis status){
    this.status = status;
  }
}
