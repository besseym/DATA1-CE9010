
abstract class Button {
   
  boolean isHover;
  
  color fillColor;
  color strokeColor;
  
  public Button(){
    
    this.isHover = false;
    
    this.fillColor = color(100);
    this.strokeColor = color(0);
  }
  
  public void setHover(float x, float y){
    this.isHover = this.isHover(x, y);
  }
  
  public abstract boolean isHover(float x, float y);
  
  public void draw(){
    
    strokeWeight(2);
    stroke(strokeColor);
    
    colorMode(RGB);
    fill(this.fillColor);
  }
}

class RectButton extends Button {
  
  float x;
  float y;
  float w;
  float h;
  
  public RectButton(float x, float y, float w, float h){
    
    super();
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public boolean isHover(float x, float y){
    return (x >= this.x && x <= (this.x + this.w) && y >= this.y && y <= (this.y + this.h));
  }
  
  public void draw(){
    
    super.draw();
    
    rect(x, y, this.w, this.h);
  }
}

class EllipseButton extends Button {
  
  float x;
  float y;
  float r;
  
  public EllipseButton(float x, float y, float r){
    
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  public boolean isHover(float x, float y){
    
    float subX = x - this.x;
    float subY = y - this.y;
    
    return (sq(subX) + sq(subY)) < sq(this.r);
  }
  
  public void draw(){
    
    super.draw();
    
    ellipseMode(RADIUS);
    ellipse(this.x, this.y, this.r, this.r);
  }
  
}
