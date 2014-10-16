
class Face {
  
  int type;
  float x, y, w, h;
  color c;
  boolean isVisible;
  
  public Face(int type){
    
    this.type = type;
    this.c = color(255);
    
    this.isVisible = true;
  }
  
  public void display(){
    
    if(!this.isVisible){
      return;
    }
    
    ellipseMode(CENTER);
    
    stroke(50);
    strokeWeight(2);
    fill(this.c);
    ellipse(x, y, w, h);
    
    fill(0);
    
    float eX = (w * 0.15);
    float ey = (h * 0.25);
    ellipse(x - eX, y - h * 0.15, w * 0.15, h * 0.15);
    ellipse(x + eX, y - h * 0.15, w * 0.15, h * 0.15);
    
    noFill();
    
    switch(this.type){
      case 0:
        arc(x, y, w * 0.75, h * 0.5, 0, PI);
        break;
      case 1:
        line(x - eX, y + ey, x + eX, y + ey);
        break;
      case 2:
        arc(x, y + ey, w * 0.75, h * 0.25, PI, TWO_PI);
        break;
    }
  }
}
