
void setup(){
  size(400, 400);
  
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("MYDeYi8rLbmqJeyNcJz92vVK9");
  cb.setOAuthConsumerSecret("vUf3ePnVhNnGCuX4HAcLGIKByeGtUstVgxLO3iLPL1lE6AQyaQ");
  cb.setOAuthAccessToken("188482760-FXnx6MVyKSFVGdh6qZHteeKVsAxb3iz1pRweC5rt");
  cb.setOAuthAccessTokenSecret("eUoRaPzK09hieT9tJxayPoGT2QDILZJPWEjdq0pAmJMVY");
  
  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  Query query = new Query("#OWS");
   
  try {
    QueryResult result = twitter.search(query);
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  }
}

void draw(){
  
}
