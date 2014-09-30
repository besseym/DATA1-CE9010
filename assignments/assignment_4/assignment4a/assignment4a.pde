
color bgColor;

String[] nameArray;
int[] populationArray;
float[] radiusArray;

color[] palletArray;

float maxRadius;

void setup(){
  
  size(1000, 100);
  
  bgColor = color(100);
  
  palletArray = new color[] {#8dd3c7, #ffffb3, #bebada, #fb8072, #80b1d3, #fdb462, #b3de69, #fccde5, #d9d9d9, #bc80bd};
  
  nameArray = new String [] {"Tokyo", "Jakarta", "Seoul",
                           "Delhi", "Shanghai", "Manila",
                           "Karachi", "New York", "Sao Paulo",
                           "Mexico City"};
  
  populationArray = new int []{37239000, 26746000, 22868000,
                          22826000, 21766000, 21241000,
                          20877000,20673000, 20568000,
                          20032000};
  
  radiusArray = new float [populationArray.length];
  
  //caculate the radius to produce the an area of the value in the population array
  for(int i = 0; i < populationArray.length; i++){
    radiusArray[i] = sqrt(populationArray[i] / PI);
  }
                           
  maxRadius = width / (2 * populationArray.length);
}

void draw(){

  background(bgColor);
  
  fill(#FF0000);
  ellipseMode(RADIUS);
  
  textAlign(CENTER);
  
  float x = 0.0;
  float radius = 0.0;
  for(int i = 0; i < radiusArray.length; i++){
    
    noStroke();
    
    radius = map(radiusArray[i], 1, max(radiusArray), 1, maxRadius);
    x = map(i, 0, radiusArray.length -1, maxRadius, width - maxRadius);
    
    //draw elipse with area relevent to the population value
    fill(palletArray[i]);
    ellipse(x, height/2, radius, radius);
    
    fill(#000000);
    
    //draw item label
    textSize(12);
    text(nameArray[i], x, (height * 0.5));
    
    //draw value label
    textSize(10);
    text("(" + populationArray[i] + ")", x, (height * 0.5) + textAscent() + textDescent());
    
    //draw bubble separator
    stroke(#AAAAAA);
    strokeWeight(1);
    
    line(i * 100, 0, i * 100, height);
  }
}
