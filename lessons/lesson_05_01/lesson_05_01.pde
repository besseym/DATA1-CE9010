//String [] myData = loadStrings("weather_location.tsv");
////printArray(myData);
//
//String headerLine = myData[0];
//
//String [] headerArray = split(headerLine, '\t');
//printArray(headerArray);

color bgColor;

int nRows, nCols;
String [][] data;

void setup(){
  
  size(1000, 1000);
  
  String [] dataArray = loadStrings("manhattan_garbage_collection.tsv");
  String [] header = split(dataArray[0], '\t');
  
  nRows = dataArray.length;
  nCols = header.length;
  
  data = new String[nRows][nCols];
  
  String row = null;
  String [] cellArray = null;
  for(int r = 0; r < nRows; r++){
    
    cellArray = split(dataArray[r], '\t');
    for(int c = 0; c < nCols; c++){
      data[r][c] = cellArray[c];
    }
  }
  
  bgColor = color(255);
  
  fill(0);
  
  colorMode(HSB, 360, 100, 100);
}

void draw(){
  
  background(bgColor);
  
  float x = 0, y = 0;
  float margin = 100;
  
  float hue = 0.0;
  
  for(int r = 1; r < nRows; r++){
    
    fill(0);
    y = map(parseFloat(data[r][1]), 0, 1900, height - margin, margin);
    textAlign(LEFT);
    text(data[r][0], 25, y);
    
    hue = map(float(r), 0.0, float(nRows - 1), 0.0, 360.0);
    
    beginShape();
    
    for(int c = 1; c < nCols; c++){
      
      x = map(c, 1, nCols - 1, margin, width - margin);
      y = map(parseFloat(data[r][c]), 0, 1900, height - margin, margin);
      
      fill(hue, 100, 100);
      
      ellipse(x, y, 5.0, 5.0);
      vertex(x, y);
      
      textAlign(CENTER);
      text(data[r][c], x, y - textAscent());
    }
    
    noFill();
    endShape();
  }
}
