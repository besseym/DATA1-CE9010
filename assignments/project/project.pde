
color bgColor;
color ftColor;

String title;

Date startWindowDate;
Date endWindowDate;

AnalysisResult analysisResult;
TwitterAlignmentAnalysis twitterAlignmentAnalysis;

float [] marginArray;
int M_TOP = 0, M_RIGHT = 1, M_BOTTOM = 2, M_LEFT = 3;

TwitterAnalysisBubbleChart chart;

void setup(){
  
  smooth();
  size(600, 400);
  
  bgColor = color(220);
  ftColor = color(0);
  
  title = "Social Satisfaction Scale";
  
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("MYDeYi8rLbmqJeyNcJz92vVK9");
  cb.setOAuthConsumerSecret("vUf3ePnVhNnGCuX4HAcLGIKByeGtUstVgxLO3iLPL1lE6AQyaQ");
  cb.setOAuthAccessToken("188482760-FXnx6MVyKSFVGdh6qZHteeKVsAxb3iz1pRweC5rt");
  cb.setOAuthAccessTokenSecret("eUoRaPzK09hieT9tJxayPoGT2QDILZJPWEjdq0pAmJMVY");
  
  endWindowDate = new Date();
  startWindowDate = (new DateUtil()).getStartWindow(endWindowDate);
  
  analysisResult = new AnalysisResult();
  
  StatusAnalysis s = null;
  for(int i = 0; i < 10; i++){
    
    s = new StatusAnalysis();
    s.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eu.");
    s.setPositiveWordCount(int(random(0, 5)));
    s.setNegativeWordCount(int(random(0, 5)));
    s.setCreatedAtValue((long)random(0, 300));
    analysisResult.getStatusList().add(s);
  }
  
  twitterAlignmentAnalysis = new TwitterAlignmentAnalysis(cb.build());
//  analyzeTwitter();
  
  marginArray = new float []{10.0f, 10.0f, 10.0f, 10.0f};
  
  float chartWidth = width - (marginArray[M_LEFT] + marginArray[M_RIGHT]);
  float chartHeight = height/2 - (marginArray[M_BOTTOM]);
  
  chart = new TwitterAnalysisBubbleChart(marginArray[M_LEFT], height/2, chartWidth, chartHeight);
  chart.setPadding(5.0);
  
  chart.setBubbles(analysisResult, startWindowDate);
}

void draw(){
  
  background(bgColor);
  
  fill(ftColor);
  textAlign(LEFT, TOP);
  text(title, marginArray[M_LEFT], marginArray[M_TOP]);
  
  chart.display();
}

void drawGraph(){
  
}

void analyzeTwitter() {
  
  Query query = new Query("#Homeland");
  Long maxPostId = null;
  
//  while(true){
//    
    try{
    
      maxPostId = analysisResult.getMaxPostId();
      if(maxPostId != null){
        query.sinceId(maxPostId);
      }
      
      twitterAlignmentAnalysis.analyze(query, analysisResult);
      
      endWindowDate = new Date();
      startWindowDate = (new DateUtil()).getStartWindow(endWindowDate);
      
      analysisResult.removeOldStatuses(startWindowDate); 
      
    }
    catch (TwitterException te) {
      println("Couldn't connect: " + te);
    }
    
//    Thread.sleep(5000);
//  }
  
}
