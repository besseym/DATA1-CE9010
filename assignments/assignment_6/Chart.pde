
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
  
  public float calMaxTextWidth(String [] textArray){
    
    float maxTextWidth = 0;
    
    //calculate max text width
    float textWidth = 0;
    for(int i = 0; i < textArray.length; i++){
      textWidth = textWidth(textArray[i]);
      if(textWidth > maxTextWidth){
        maxTextWidth = textWidth;
      }
    }
    
    return maxTextWidth;
  }
  
  public void draw(){
    
    noStroke();
    
    fill(background);
    rect(x, y, w, h);
  }
  
}

abstract class BarChart extends Chart {
  
  float hue;
  
  color textColor;
  color scaleColor;
  
  float labelPad;
  float scaleLabelPad;
  int numbScaleLines;
  
  float maxValue;
  float maxLabelWidth;
  float maxScaleLabelWidth;
  
  String [] labelArray; 
  float [] valueArray;
  
  float [] scaleValueArray;
  String [] scaleLabelArray;
  
  public BarChart(float x, float y, float width, float height){
    
    super(x, y, width, height);
    
    this.hue = 0.0;
    this.textColor = color(#000000);
    this.scaleColor = color(0.0, 125.0);
    
    this.labelPad = 0;
    this.scaleLabelPad = 0;
    this.numbScaleLines = 8;
  }
  
  public void setLabelArray(String [] labelArray){
    
    this.labelArray = labelArray;
    this.maxLabelWidth = calMaxTextWidth(labelArray);
  }
  
  public void setValueArray(float [] valueArray){
    
    this.valueArray = valueArray;
    this.maxValue = max(valueArray);
    
    
    int spacing = int(maxValue / numbScaleLines);
    
    this.scaleLabelArray = new String [numbScaleLines];
    this.scaleValueArray = new float [numbScaleLines];
    
    float s = 0.0;
    for(int i = 0; i < numbScaleLines; i += 1){
      
      s = i * spacing;
      this.scaleLabelArray[i] = nf(s, 0, 2);
      this.scaleValueArray[i] = s;
    }
    
    this.maxScaleLabelWidth = calMaxTextWidth(scaleLabelArray);
  }
  
  public abstract void drawScale();
  public abstract void drawBars();
  
  public void draw(){
    
    super.draw();
    this.drawScale();
    this.drawBars();
  }
  
}

class BarHorizChart extends BarChart {
  
  public BarHorizChart(float x, float y, float width, float height){
    super(x, y, width, height);
  }
  
  public void setLabelPadding(float labelPad){
    
    this.padL = (2 * labelPad) + this.maxLabelWidth;
    this.labelPad = labelPad;
  }
  
  public void setScaleLabelPadding(float scaleLabelPad){
    
    this.padB = (2 * scaleLabelPad) + (this.maxScaleLabelWidth * 0.75);
    this.scaleLabelPad = scaleLabelPad; 
  }
  
  public void drawScale(){
    
    strokeWeight(1);
    stroke(scaleColor);
    
    float x, y1, y2, textY;
    
    fill(textColor);
    textAlign(LEFT);
    
    for(int i = 0; i < scaleValueArray.length; i++){
      
      x = map(scaleValueArray[i], 0, maxValue, getDrawStartX(), getDrawEndX());
      y1 = this.getDrawStartY();
      y2 = this.getDrawEndY();
      
      line(x, y1, x, y2);
      
      textY = y2;
      
      pushMatrix();
      translate(x, textY + scaleLabelPad);
      rotate(radians(45));
      text(scaleLabelArray[i], 0, 0);
      popMatrix();
    }
  }
  
  public void drawBars(){
    
    float value = 0;
    
    float brightness = 100;
    
    float barX = getDrawStartX();
    float barY = 0;
    float barWidth = 0; 
    float barHeight = (getDrawEndY() - getDrawStartY()) / valueArray.length;
    barHeight = barHeight * 0.9;
    
    float barMaxWidth = getDrawEndX() - getDrawStartX();
    
    noStroke();
    textAlign(RIGHT);
    
    for(int i = 0; i < valueArray.length; i++){
      
      value = valueArray[i];
      
      barY = map(i, 0, valueArray.length - 1, getDrawStartY(), getDrawEndY() - barHeight);
      barWidth = map(value, 0, maxValue, 0, barMaxWidth);
      
      brightness = map(value, 0, maxValue, 0, 100);
      
      colorMode(HSB, 360, 100, 100);
      fill(hue, 100, brightness, 200);
      
      rect(barX, barY, barWidth, barHeight);
      
      colorMode(RGB);
      fill(textColor);
      
      text(labelArray[i], barX - labelPad, barY + (barHeight * 0.5) + textDescent());
    }
  }
  
}

class BarVertChart extends BarChart {
  
  public BarVertChart(float x, float y, float width, float height){
    super(x, y, width, height);
  }
  
  public void setLabelPadding(float labelPad){
    
    this.padB = (2 * labelPad) + this.maxLabelWidth;
    this.padL = (this.maxLabelWidth * 0.5);
    this.labelPad = labelPad;
  }
  
  public void setScaleLabelPadding(float scaleLabelPad){
    
    this.padR = (2 * scaleLabelPad) + (this.maxScaleLabelWidth);
    this.scaleLabelPad = scaleLabelPad; 
  }
  
  public void drawScale(){
    
    stroke(scaleColor);
    strokeWeight(1);
    
    float x1, x2, y, textY;
    
    fill(textColor);
    textAlign(LEFT);
    
    for(int i = 0; i < scaleValueArray.length; i++){
      
      x1 = getDrawStartX();
      x2 = getDrawEndX();
      y = map(scaleValueArray[i], 0, maxValue, getDrawEndY(), getDrawStartY());
      
      line(x1, y, x2, y);
      
      text(scaleLabelArray[i], x2 + scaleLabelPad, y + textDescent());
    }
  }
  
  public void drawBars(){
    
    float value = 0;
    
    float brightness = 100;
    
    float barX = 0;
    float barY = getDrawEndY();
    float barWidth = (getDrawEndX() - getDrawStartX()) / valueArray.length;
    barWidth = barWidth * 0.9;
    
    float barHeight = 0.0;
    
    float barMaxHeight = getDrawEndY() - getDrawStartY();
    
    noStroke();
    textAlign(RIGHT);
    
    for(int i = 0; i < valueArray.length; i++){
      
      value = valueArray[i];
      
      barX = map(i, 0, valueArray.length - 1, getDrawStartX(), getDrawEndX() - barWidth);
      barHeight = map(value, 0, maxValue, 0, barMaxHeight);
      
      brightness = map(value, 0, maxValue, 0, 100);
      
      colorMode(HSB, 360, 100, 100);
      fill(hue, 100, brightness, 200);
      
      rect(barX, barY, barWidth, -barHeight);
      
      
      colorMode(RGB);
      fill(textColor);
      
      pushMatrix();
      translate(barX + (barWidth * 0.5), barY + labelPad);
      rotate(radians(-45));
      text(labelArray[i], 0, 0);
      popMatrix();
      
//      colorMode(RGB);
//      fill(textColor);
//      
//      text(labelArray[i], barX - labelPad, barY + (barHeight * 0.5) + textDescent());
    }
  }
  
}

class LineChart extends Chart {
  
  public LineChart(float x, float y, float width, float height){
    super(x, y, width, height);
  }
}
