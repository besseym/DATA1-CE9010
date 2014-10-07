
color bgColor;

float padding;

RectButton button;

BarVertChart barVertChart;
BarHorizChart barHorizChart;

boolean displayBarVertChart;

Button [] buttonArray;

int numbOfButtons;

int RED_BUTTON_INDEX = 0;
int GREEN_BUTTON_INDEX = 1;
int BLUE_BUTTON_INDEX = 2;

int VERT_BUTTON_INDEX = 3;
int HORIZ_BUTTON_INDEX = 4;

void setup(){
  
  size(500, 500);
  
  bgColor = color(220);
  
  padding = 5.0;
  button = new RectButton(width/4, width/4, 100, 50);
  
  TableData data = readTableData("population.tsv", '\t');
//  println(data.toString());
  
  
  float bRowHeight = (height * 0.25);
  
  float x = 20.0;
  float y = 20.0;
  float w = width - 40;
  float h = height - bRowHeight;
  
  barVertChart = new BarVertChart(x, y, w, h);
  barVertChart.setPadding(padding);
  barVertChart.setLabelArray(data.getColValArray("city"));
  barVertChart.setValueArray(data.getColValFloatArray("population"));
  barVertChart.setLabelPadding(2 * padding);
  barVertChart.setScaleLabelPadding(padding);
  
  barHorizChart = new BarHorizChart(x, y, w, h);
  barHorizChart.setPadding(padding);
  barHorizChart.setLabelArray(data.getColValArray("city"));
  barHorizChart.setValueArray(data.getColValFloatArray("population"));
  barHorizChart.setLabelPadding(padding);
  barHorizChart.setScaleLabelPadding(2 * padding);
  
  displayBarVertChart = false;
  
  float rStart = bRowHeight - y;
  float rHeight = (bRowHeight - y) * 0.8;
  float rPadding = (bRowHeight - y) * 0.1;
  
  float r = rHeight * 0.5;
  float bX = 0.0;
  float bY = 0.0;
  
  numbOfButtons = 5;
  buttonArray = new Button [numbOfButtons];
  for(int i = 0; i < numbOfButtons; i++){
    
    bX = map(i, 0, numbOfButtons - 1, x + r, (width - x) - r);
    
    if(i <= BLUE_BUTTON_INDEX){
      
      bY = h + y + r + rPadding;
      
      buttonArray[i] = new EllipseButton(bX, bY, r);
      
      if(i == RED_BUTTON_INDEX){
        buttonArray[i].fillColor = color(#ff0000);
      }
      else if(i == GREEN_BUTTON_INDEX){
        buttonArray[i].fillColor = color(#00ff00);
      }
      else if(i == BLUE_BUTTON_INDEX){
        buttonArray[i].fillColor = color(#0000ff);
      }
    }
    else {
      
      bY = h + y + rPadding;
      
      if(i == VERT_BUTTON_INDEX){
        buttonArray[i] = new RectButton(bX - r + (rHeight * 0.25), bY, rHeight * 0.5, rHeight);        
        buttonArray[i].fillColor = color(#FFF703);
      }
      else if(i == HORIZ_BUTTON_INDEX){
        buttonArray[i] = new RectButton(bX - r, bY + (rHeight * 0.25), rHeight, rHeight * 0.5);
        buttonArray[i].fillColor = color(#FA03FF);
      }
    }
  }
}

void draw(){
  
  background(bgColor);
  
  if(displayBarVertChart){
    barVertChart.draw();
  }
  else {
    barHorizChart.draw();
  }
  
  for(int i = 0; i < numbOfButtons; i++){
    buttonArray[i].draw();
  }
}

void mouseReleased(){
  
  for(int i = 0; i < numbOfButtons; i++){
    
    if(buttonArray[i].isHover){
      
      if(i == RED_BUTTON_INDEX){
        barVertChart.hue = 0.0;
        barHorizChart.hue = 0.0;
      }
      else if(i == GREEN_BUTTON_INDEX){
        barVertChart.hue = 119.0;
        barHorizChart.hue = 119.0;
      }
      else if(i == BLUE_BUTTON_INDEX){
        barVertChart.hue = 239.0;
        barHorizChart.hue = 239.0;
      }
      else if(i == VERT_BUTTON_INDEX){
        displayBarVertChart = true;
      }
      else if(i == HORIZ_BUTTON_INDEX){
        displayBarVertChart = false;
      }
    }
  }
}

void mouseMoved(){
  
  for(int i = 0; i < numbOfButtons; i++){
    buttonArray[i].setHover(mouseX, mouseY);
  }
}
