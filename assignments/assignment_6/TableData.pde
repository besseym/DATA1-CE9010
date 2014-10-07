
class TableData{
  
  int nRows;
  int nCols;
  
  String [][] data;
  
  public TableData(int nRows, int nCols){
    
    this.nRows = nRows;
    this.nCols = nCols;
  }
  
  int getColIndex(String colName){
    
    int index = -1;
    
    for(int c = 0; c < nCols; c++){
      
      if(data[0][c].equals(colName)){
        index = c;
      }
    }
    
    return index;
  }
  
  String [] getColValArray(int cIndex){
    
    String [] cArray = new String [nRows - 1];
    for(int r = 1; r < nRows; r++){
      cArray[r - 1] = data[r][cIndex];
    }
    
    return cArray;
  }
  
  String [] getColValArray(String cName){
    
    int cIndex = this.getColIndex(cName);
    return getColValArray(cIndex);
  }
  
  float [] getColValFloatArray(int cIndex){
    
    String [] cValArray = this.getColValArray(cIndex);
    int l = cValArray.length;
    
    float [] cValFloatArray = new float [l];
    
    for(int i = 0; i < l; i++){
      cValFloatArray[i] = parseFloat(cValArray[i]);
    }
    
    return cValFloatArray;
  }
  
  float [] getColValFloatArray(String cName){
    
    int cIndex = this.getColIndex(cName);
    return getColValFloatArray(cIndex);
  }
  
  String toString(){
    
    String str = "";
    
    for(int r = 0; r < nRows; r++){
      for(int c = 0; c < nCols; c++){
        
        if(c > 0){
          str += ",";
        }
        
        str += data[r][c];
      }
      
      str += "\n";
    }
    
    return str;
  }
}

public TableData readTableData(String fileName, char delimiter){
  
  TableData tableData = null;
  
  String [] dataArray = loadStrings(fileName);
  String [] header = split(dataArray[0], delimiter);

  int nRows = dataArray.length;
  int nCols = header.length;

  String [][] data = new String[nRows][nCols];
  
  String row = null;
  String [] cellArray = null;
  
  for(int r = 0; r < nRows; r++){
    cellArray = split(dataArray[r], delimiter);
    for(int c = 0; c < nCols; c++){
      data[r][c] = cellArray[c];
    }
  }
  
  tableData = new TableData(nRows, nCols);
  tableData.data = data;
  
  return tableData;
}
