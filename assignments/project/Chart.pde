
class Chart {
  
  String title;
  
  float x, y, w, h;
  float padT, padR, padB, padL;
  
  color background;
  
  public Chart(float x, float y, float w, float h){
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.padT = 0.0;
    this.padR = 0.0;
    this.padB = 0.0;
    this.padL = 0.0;
    
    background = color(255);
  }
  
  float getDrawStartX(){
    return x + padL;
  }
  
  float getDrawEndX(){
    return x + w - padR;
  }
  
  float getDrawStartY(){
    return y + padT;
  }
  
  float getDrawEndY(){
    return y + h - padB;
  }
  
  public void setPadding(float p){
    this.setPadding(p, p);
  }
  
  public void setPadding(float hp, float vp){
    
    this.padT = vp;
    this.padR = hp;
    this.padB = vp;
    this.padL = hp;
  }
  
  public void display(){
    
    noStroke();
    
    fill(background);
    rectMode(CORNER);
    rect(x, y, w, h);
  }
  
}

class BubbleChart extends Chart {
  
  float axisY;
  float bRadius;
  List<Bubble> bubbleList;
  
  public BubbleChart(float x, float y, float w, float h){
    
    super(x, y, w, h);
    
    this.bRadius = 10.0;
    this.axisY = y + (h / 2);
    this.bubbleList = new ArrayList<Bubble>();
  }
  
  public void display(){
    
    super.display();
    
    stroke(0);
    strokeWeight(1);
    line(this.x, this.axisY, this.x + this.w, this.axisY);
    
    for(Bubble b : bubbleList){
      b.display();
    }
  }
  
}

class TwitterAnalysisBubbleChart extends BubbleChart {
  
  private Face [] faceArray;
  
  public TwitterAnalysisBubbleChart(float x, float y, float w, float h){
    
    super(x, y, w, h);
    
    this.faceArray = new Face [6];
    this.faceArray[0] = new Face(0);
    this.faceArray[1] = new Face(1);
    this.faceArray[2] = new Face(2);
    this.faceArray[3] = new Face(0);
    this.faceArray[4] = new Face(1);
    this.faceArray[5] = new Face(2);
    
    float d = this.h * 0.15;
    for(int i = 0; i < this.faceArray.length; i++){
      
      if(i < 3){
        this.faceArray[i].x = x - (d * 0.5);
      }
      else{
        this.faceArray[i].x = x + w + (d * 0.5);
      }
      
      this.faceArray[i].y = y;
      this.faceArray[i].w = d;
      this.faceArray[i].h = d;
    }
  }
  
  public void setBubbles(AnalysisResult analysisResult, Date startDate){
    
    List<Bubble> newBubbleList = new ArrayList<Bubble>();
    
    if(analysisResult.getStatusList().isEmpty()){
      return;
    }
    
    float x = 0.0, y = 0.0, r = this.bRadius;
    float hue = 0.0, pHue = 0.0, nHue = 239.0, saturation = 0.0;
    
    color c = 0;
    
    int netWordCount = 0;
    int maxWordCount = analysisResult.getMaxWordCount();
    int minWordCount = analysisResult.getMinWordCount();
    
    boolean isNeutral = (minWordCount == 0 && maxWordCount == 0);
    float neutralY =  this.getDrawStartY() + ((this.getDrawEndY() - this.getDrawStartY()) / 2);
    
    long minCreatedAtValue = analysisResult.getMinCreatedAtValue();
    long maxCreatedAtValue = analysisResult.getMaxCreatedAtValue();
    
    colorMode(HSB, 360, 100, 100);
    
    int xValue, yValue;
    String label = null;
    
    StatusBubble b = null;
    List<StatusAnalysis> statusList = analysisResult.getStatusList();
    for(StatusAnalysis s : statusList){
      
      netWordCount = s.getNetWordCount();
      
      xValue = int(s.getCreatedAtValue());
      yValue = netWordCount;
      
      label = "(" + xValue + "," + yValue + ")";
      
      x = map(s.getCreatedAtValue(), 0, (new DateUtil()).getSecondsInWindow(), this.getDrawStartX(), this.getDrawEndX());
      
      if(isNeutral){
       y = neutralY;
      }
      else {
        y = map(netWordCount, minWordCount, maxWordCount, this.getDrawEndY(), this.getDrawStartY());
      }
      
      b = new StatusBubble(x, y, r);
      b.setStatus(s);
      
      if(netWordCount >= 0){
        hue = pHue;
        saturation = map(netWordCount, 0, maxWordCount, 0, 100.0);
      }
      else if(netWordCount < 0){
        hue = nHue;
        saturation = map(netWordCount, 0, minWordCount, 0, 100.0);
      }
      
      c = color(hue, 100.0, saturation);
      b.setColor(c);
      b.setLabel(label);
      
      newBubbleList.add(b);
    }
    
    if(isNeutral){
      this.axisY = neutralY;
    }
    else {
      this.axisY = map(0.0, minWordCount, maxWordCount, this.getDrawEndY(), this.getDrawStartY());
    }
    
    this.faceArray[1].y = this.axisY;
    this.faceArray[4].y = this.axisY;
    
    if(maxWordCount > 0){
      float fy = map(maxWordCount, minWordCount, maxWordCount, this.getDrawEndY(), this.getDrawStartY());
      this.faceArray[0].y = fy; 
      this.faceArray[0].isVisible = true;
      this.faceArray[3].y = fy; 
      this.faceArray[3].isVisible = true;
    }
    else {
      this.faceArray[0].isVisible = false;
      this.faceArray[3].isVisible = false;
    }
    
    if(minWordCount < 0){
      float fy = map(minWordCount, minWordCount, maxWordCount, this.getDrawEndY(), this.getDrawStartY());
      this.faceArray[2].y = fy;
      this.faceArray[2].isVisible = true;
      this.faceArray[5].y = fy;
      this.faceArray[5].isVisible = true;
    }
    else {
      this.faceArray[2].isVisible = false;
      this.faceArray[5].isVisible = false;
    }
    
    this.bubbleList = new ArrayList<Bubble>();
    this.bubbleList.addAll(newBubbleList);
  }
  
  public void display(){
    
    super.display();
    
    for(int i = 0; i < this.faceArray.length; i++){
      this.faceArray[i].display(); 
    }
  }
}
