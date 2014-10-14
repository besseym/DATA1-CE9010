
abstract class Bubble {
  
  color c;
  float x, y, r;
  
  String label;
  
  boolean isMouseOver;
  
  public Bubble(float x, float y, float r){
    
    this.x = x;
    this.y = y;
    this.r = r;
    
    this.label = "(" + x + "," + y + ")";
    
    this.isMouseOver = false;
  }
  
  public abstract void displayDetails();
  
  public void setLabel(String label){
    this.label = label;
  }
  
  public void setColor(color c) {
    this.c = c;
  }
  
  public void setMouseOver(float x, float y){
    this.isMouseOver = (dist(this.x, this.y, x, y) < this.r);
  }
  
  public boolean getIsMouseOver(){
    return this.isMouseOver;
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
  
  private StatusDetails statusDetails;
  
  public StatusBubble(float x, float y, float r){
    
    super(x, y, r);
  }
  
  public void display(){
    
    super.display();
  }
  
  public void displayDetails(){
    
    this.statusDetails.display();
  }
  
  public void setStatus(StatusAnalysis status){
    
    float dX = this.x;
    float dY = this.y;
    float dW = 200;
    float dH = 175;
    
    if((dX + dW) > width){
      dX = dX - dW;
    }
    
    if((dY + dH) > height){
      dY = dY - dH;
    }
    
    this.statusDetails = new StatusDetails(dX, dY, dW, dH, status);
    this.statusDetails.setPadding(5);
  }
}

class StatusDetails extends Chart {
  
  private String userScreenName;
  private String text;
  private String timestamp;
  private Integer positiveWordCount;
  private Integer negativeWordCount;
  private Integer netWordCount;
  
  public StatusDetails(float x, float y, float w, float h, StatusAnalysis status){
    
    super(x, y, w, h);
    
    this.userScreenName = status.getUserScreenName();
    this.text = status.getText();
    this.timestamp = (new DateUtil()).formatDate(status.getCreatedAt());
    
    this.positiveWordCount = status.getPositiveWordCount();
    this.negativeWordCount = status.getNegativeWordCount();
    this.netWordCount = status.getNetWordCount();
  }
  
  public void display(){
    
    super.display();
    
    fill(0);
    textSize(16);
    textAlign(LEFT, TOP);
       
    float titleLineHeight = textAscent() + textDescent();
    
    text(this.userScreenName, this.getDrawStartX(), this.getDrawStartY());
    
    textAlign(RIGHT, TOP);
    textSize(11);
    text(this.timestamp, this.getDrawEndX(), this.getDrawStartY());
    
    stroke(0);
    strokeWeight(1);
    line(this.getDrawStartX(), this.getDrawStartY() + titleLineHeight, this.getDrawEndX(), this.getDrawStartY() + titleLineHeight);
    
    textSize(11);
    float lineHeight = textAscent() + textDescent();
    float endTextY = this.getDrawEndY() - (3 * lineHeight);
    
    rectMode(CORNERS);
    textAlign(LEFT, TOP);
    text(this.text, this.getDrawStartX(), this.getDrawStartY() + titleLineHeight, this.getDrawEndX(), endTextY);
    
//    float sumStartY = this.getDrawEndY();
    
    line(this.getDrawStartX(), endTextY, this.getDrawEndX(), endTextY);
    
    textAlign(LEFT, BOTTOM);
    text("Positive Word Count: ", this.getDrawStartX(), this.getDrawEndY() - lineHeight - lineHeight);
    text("Negative Word Count: ", this.getDrawStartX(), this.getDrawEndY() - lineHeight);
    text("Net Word Count: ", this.getDrawStartX(), this.getDrawEndY());
    
    textAlign(RIGHT, BOTTOM);
    textSize(12);
    text(this.positiveWordCount, this.getDrawEndX(), this.getDrawEndY() - lineHeight - lineHeight);
    text(this.negativeWordCount, this.getDrawEndX(), this.getDrawEndY() - lineHeight);
    text(this.netWordCount, this.getDrawEndX(), this.getDrawEndY());
    
  }
}
