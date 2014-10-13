
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
  
  float xAxisY;
  List<Bubble> bubbleList;
  
  public BubbleChart(float x, float y, float w, float h){
    
    super(x, y, w, h);
    
    this.xAxisY = y + (h / 2);
    this.bubbleList = new ArrayList<Bubble>();
  }
  
  public void display(){
    
    super.display();
    
    stroke(0);
    line(this.x, this.xAxisY, this.x + this.w, this.xAxisY);
    
    for(Bubble b : bubbleList){
      b.display();
    }
  }
  
}

class TwitterAnalysisBubbleChart extends BubbleChart {
  
  public TwitterAnalysisBubbleChart(float x, float y, float w, float h){
    
    super(x, y, w, h);
  }
  
  public void setBubbles(AnalysisResult analysisResult, Date startDate){
    
    this.bubbleList = new ArrayList<Bubble>();
    
    float x = 0.0, y = 0.0, r = 5.0;
    float hue = 0.0, pHue = 0.0, nHue = 239.0, saturation = 0.0;
    
    color c = 0;
    
    int netWordCount = 0;
    int maxWordCount = analysisResult.getMaxWordCount();
    int minWordCount = analysisResult.getMinWordCount();
    
    long minCreatedAtValue = analysisResult.getMinCreatedAtValue(startDate);
    long maxCreatedAtValue = analysisResult.getMaxCreatedAtValue(startDate);
    
    
    println("Min: " + minCreatedAtValue);
    println("Max: " + maxCreatedAtValue);
    
    colorMode(HSB, 360, 100, 100);
    
    int xValue, yValue;
    String label = null;
    
    StatusBubble b = null;
    List<StatusAnalysis> statusList = analysisResult.getStatusList();
    for(StatusAnalysis s : statusList){
      
      netWordCount = s.getNetWordCount();
      
      xValue = int(s.getCreatedAtValue(startDate));
      yValue = netWordCount;
      
      label = "(" + xValue + "," + yValue + ")";
      
      x = map(s.getCreatedAtValue(startDate), minCreatedAtValue, maxCreatedAtValue, this.getDrawStartX(), this.getDrawEndX());
      y = map(netWordCount, minWordCount, maxWordCount, this.getDrawEndY(), this.getDrawStartY());
      
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
      
      this.bubbleList.add(b);
    }
    
    this.xAxisY = map(0, minWordCount, maxWordCount, this.y + this.h, this.y);
  } 
}
