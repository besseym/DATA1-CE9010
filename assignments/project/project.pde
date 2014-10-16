
color bgColor;
color ftColor;

String title;
String topic;
PImage topicImg;

DateUtil dateUtil;
Date startWindowDate;
Date endWindowDate;

AnalysisResult analysisResult;
TwitterAlignmentAnalysis twitterAlignmentAnalysis;

float [] marginArray;
int M_TOP = 0, M_RIGHT = 1, M_BOTTOM = 2, M_LEFT = 3;

TwitterAnalysisBubbleChart chart;

void setup(){
  
  smooth();
  size(800, 500);
  
  bgColor = color(220);
  ftColor = color(0);
  
  title = "Social Satisfaction Scale";
  topic = "Homeland";
  topicImg = loadImage("http://www.sho.com/site/image-bin/images/804_4_0/804_4_0_01_444x250.jpg");
  
  marginArray = new float []{20.0f, 40.0f, 50.0f, 40.0f};
  
  float chartWidth = width - (marginArray[M_LEFT] + marginArray[M_RIGHT]);
  float chartHeight = height/2 - (marginArray[M_BOTTOM]);
  
  chart = new TwitterAnalysisBubbleChart(marginArray[M_LEFT], height/2, chartWidth, chartHeight);
  chart.setPadding(0.0, 15.0);
  chart.bRadius = 10.0;
  
  //twitter configuration
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("MYDeYi8rLbmqJeyNcJz92vVK9");
  cb.setOAuthConsumerSecret("vUf3ePnVhNnGCuX4HAcLGIKByeGtUstVgxLO3iLPL1lE6AQyaQ");
  cb.setOAuthAccessToken("188482760-FXnx6MVyKSFVGdh6qZHteeKVsAxb3iz1pRweC5rt");
  cb.setOAuthAccessTokenSecret("eUoRaPzK09hieT9tJxayPoGT2QDILZJPWEjdq0pAmJMVY");
  
  dateUtil = new DateUtil();
  endWindowDate = new Date();
  startWindowDate = dateUtil.getStartWindow(endWindowDate);
  
  analysisResult = new AnalysisResult();
  
  twitterAlignmentAnalysis = new TwitterAlignmentAnalysis(cb.build());
//  analyzeTwitter();
//  generateStatusList();
  
  thread("analyzeTwitter");
}

void draw(){
  
  background(bgColor);
  
  fill(ftColor);
  textAlign(LEFT, TOP);
  textSize(50);
  text(title, marginArray[M_LEFT], marginArray[M_TOP], width/2, height/2);
  
  textSize(20);
  float lineHeight = textAscent() + textDescent();
  text(topic, width/2, marginArray[M_TOP]);
  
  imageMode(CORNERS);
  image(topicImg, width/2, marginArray[M_TOP] + lineHeight, width - marginArray[M_RIGHT], height/2);
  
  textSize(11);
  fill(ftColor);
  String timestampLabel = null;
  for(int s = 0; s <= dateUtil.getSecondsInWindow(); s = s + 50){
    
    timestampLabel = dateUtil.formatDate(dateUtil.addSeconds(startWindowDate, s));
    
    float x = map(s, 0, dateUtil.getSecondsInWindow(), marginArray[M_LEFT], width - marginArray[M_RIGHT]);
    
    pushMatrix();
    translate(x, height - marginArray[M_BOTTOM]);
    rotate(radians(45));
    textAlign(LEFT, TOP);
    text(timestampLabel, 0, 0);
    popMatrix();
  }
  
  chart.display();
  
  //display details rollover
  for(Bubble b : chart.bubbleList){
    
    if(b.getIsMouseOver()){
      b.displayDetails();
    }
  }
}

void mouseMoved(){
  
  for(Bubble b : chart.bubbleList){
    b.setMouseOver(mouseX, mouseY);
  }
}

void generateStatusList(){
  
  Date createdAt = null;
  StatusAnalysis s = null;
  for(int i = 0; i < 10; i++){
    
    createdAt = dateUtil.addSeconds(startWindowDate, int(random(0, dateUtil.getSecondsInWindow())));
    
    s = new StatusAnalysis();
    s.setUserScreenName("besseym");
    s.setCreatedAt(createdAt);
    s.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque viverra et urna vel venenatis. Duis ante mi, molestie pretium cursus.");
//    s.setPositiveWordCount(0);
//    s.setNegativeWordCount(0);
    s.setPositiveWordCount(int(random(0, 5)));
    s.setNegativeWordCount(int(random(0, 5)));
    s.setCreatedAtValue(startWindowDate);
    analysisResult.getStatusList().add(s);
  }
  
  chart.setBubbles(analysisResult, startWindowDate);
}

void analyzeTwitter() {
  
  Query query = new Query("#" + topic);
  Long maxPostId = null;
  
  while(true){
    
    try{
      
      if(maxPostId != null){
        query.sinceId(maxPostId);
      }
      
      twitterAlignmentAnalysis.analyze(query, analysisResult);
      
      endWindowDate = new Date();
      startWindowDate = dateUtil.getStartWindow(endWindowDate);
      
      analysisResult.removeOutOfWindowStatuses(startWindowDate, endWindowDate);
      analysisResult.updateCreatedAtValue(startWindowDate);
      
      chart.setBubbles(analysisResult, startWindowDate);
      
      maxPostId = analysisResult.getMaxPostId();
      
    }
    catch (TwitterException te) {
      println("Couldn't connect: " + te);
    }
    
    delay(5000);
  }
  
}
