// Reading NYC trash collection data
// Data downloaded from NYC Department of Sanitation
// http://www.nyc.gov/html/nycwasteless/html/resources/reports_ll40.shtml

int nRows, nColumns;
String[][] myData;

// Buttons
int[] btX, btY, btWidth, btHeight, btHue, btBrightness;
String[] label;
boolean[] showCategory, isHovering;

void setup(){
  size(600, 600);
  colorMode(HSB);
  // Loading the original tsv and storing each line as an element of my array originalData
  String[] originalData = loadStrings("manhattan_garbage_collection.tsv");
//  printArray(originalData);

  getnRowsAndNColumns(originalData);
  
  myData = new String[nRows][nColumns];

  saveMyData(originalData);
  
  createButtons();  
//  debug();
}

int timeIndex = 0;

void draw(){
  background(255);
  
  float margin = 80;
  
  // Draw Buttons
  for(int i = 0; i < btX.length; i++){  

    // Changing style based on interaction
    if(isHovering[i]){
       btBrightness[i] = 240;  
    }else{
       btBrightness[i] = 200;  
    }  
    
    // Drawing
    fill(btHue[i], 255, btBrightness[i]);
    noStroke();
    rect(btX[i], btY[i], btWidth[i], btHeight[i], 10);
    fill(255);
    textSize(12);
    textAlign(CENTER, CENTER);
    text(label[i], btX[i], btY[i], btWidth[i], btHeight[i]);
  }   
  
  // Draw chart
  for(int r = 1; r < nRows; r ++){
    
//    println("r: " + r);
    
    if(showCategory[r-1]){
      beginShape();
      for(int c = 1; c < timeIndex; c ++){
//      for(int c = 1; c < nColumns; c ++){
        
  //      println("\t c: "+ c);
        float x, y;
        x = map(c,
                1, nColumns - 1,
                margin, width - margin);
        y = map(parseFloat(myData[r][c]),
                0, 1900,
                height - margin, margin);
        
        fill(btHue[r-1], 255, btBrightness[r-1]);
        noStroke();
        ellipse(x, y, 5, 5);
        
        vertex(x, y);
        
        fill(0);
        textSize(8);
        textAlign(CENTER, BOTTOM);
        text(myData[r][c], x, y - 3);
      }
      noFill();
      stroke(btHue[r-1], 255, btBrightness[r-1]);
      endShape();
    }
    
  } 
  if(timeIndex < nColumns && frameCount % 20 == 0){
    timeIndex ++;
  }
}

void debug(){
  for(int r = 0; r < nRows; r ++){
    for(int c = 0; c < nColumns; c ++){
      println("[" + r + "]" + "[" + c + "] " + myData[r][c]);
    }
  }
}

void saveMyData(String[] myArray){
  // This is gonna loop through each row of my originalData
  for(int r = 0; r < myArray.length; r++){
  
    // Storing the current row
    String thisRow = myArray[r];
//    println("This row is: " + thisRow);
    
    // Take the current row, and break it into separate elements
    // Store them in an Array of Strings called theseColumns
    String[] theseColumns = split(thisRow, '\t');
//    printArray(theseColumns);
 
    for(int c = 0; c < theseColumns.length; c++){
//      println(theseColumns[c]);
      myData[r][c] = theseColumns[c];
    }
  }
}

void getnRowsAndNColumns(String[] myArray){
  nRows = myArray.length;
  String[] cellsFromTheFirstRow = split(myArray[0], '\t');
  nColumns = cellsFromTheFirstRow.length;
  
  println(nRows);
  println(nColumns);
}

void createButtons(){
  int nBt = 4;
  int spacing = 10;
  btX = new int[nBt];
  btY = new int[nBt];
  btWidth = new int[nBt];
  btHeight = new int[nBt];
  btHue = new int[nBt];
  btBrightness = new int[nBt];
  label = new String[nBt];
  showCategory = new boolean[nBt];
  isHovering = new boolean[nBt];  
  
  for(int i = 0; i < btX.length; i++){
    btWidth[i] = 120;
    btHeight[i] = 30;
    btX[i] = 40 + i*(spacing + btWidth[i]);
    btY[i] = height - 60;
    btHue[i] = i*15;
    btBrightness[i] = 200;
    label[i] = myData[i + 1][0];
    showCategory[i] = true;
    isHovering[i] = false;
  }
}

void mouseMoved(){
  for(int i = 0; i < btX.length; i++){
    if(mouseX >= btX[i] && mouseX <= btX[i] + btWidth[i] &&
       mouseY >= btY[i] && mouseY <= btY[i] + btHeight[i]){
       isHovering[i] = true;     
    }else{
       isHovering[i] = false;
    }
  }
}

void mouseReleased(){
  for(int i = 0; i < btX.length; i++){
    if(isHovering[i]){
       if(!showCategory[i]){
         showCategory[i] = true;    
       }else{
         showCategory[i] = false;  
       }
    }
  }
}
