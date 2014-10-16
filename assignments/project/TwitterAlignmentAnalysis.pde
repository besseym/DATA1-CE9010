import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.Configuration;

/**
 * @author besseym
 *
 */
public class TwitterAlignmentAnalysis {
  
  private Twitter twitter;
  private String [] positiveWordArray;
  private String [] negativeWordArray;

  /**
   * 
   */
  public TwitterAlignmentAnalysis(Configuration configuration) {
    
    this.twitter = new TwitterFactory(configuration).getInstance();
    
    this.positiveWordArray = new String [] {"love", "loved", "like", "liked", "enjoy", "enjoyed", "adore", "adored", "great", "good", "best", "favorite", "favourite", "awesome", "spectacular", "wonderful", "impressive", "magnificent", "brilliant", "glorious", "splendid", "superb", "excellent", "fantastic", "sensational", "outstanding", "marvelous", "terrific", "fabulous", "delightful", "excite", "excited", "exciting", "thrilled", "delighted", "beautiful", "better", "yay", "hooray", "wahoo", "whoopee", "positive", "enthusiastic", "nice", "amazing", "scintillating", "interesting", "interested", "captivating", "charming", "inspired", "inspiring", "happy"};
    this.negativeWordArray = new String [] {"hate", "hated", "dislike", "disliked", "detest", "detested", "despise", "despised", "abhor", "abhored", "loathe", "loathed", "disdain", "bad", "worst", "sucks", "horrible", "intolerable", "unbearable", "terrrible", "repugnant", "abhorrent", "repulsive", "awful", "disgusting", "horrendous", "dreadful", "inadequate", "substandard", "lousy", "ugly", "meh", "blah", "yuck", "trash", "crap", "crappy", "negative", "pessimistic", "unpleasant", "tragic", "boring", "bored", "dull", "absurd", "nasty", "lousy", "bogus", "tear", "uninteresting", "tedious", "overrated", "sad"};
  }
  
  /**
   * 
   * @param query
   * @return
   * @throws TwitterException
   */
  public void analyze(Query query, AnalysisResult result) throws TwitterException{
    
    QueryResult queryResult = twitter.search(query);
    
    List<Status> statusList = queryResult.getTweets();
    
    String text = null;
    StatusAnalysis status = null;
    
    //analyze for positive words
    WordDetector positiveWordDetector = new WordDetector(positiveWordArray);
    WordDetector negativeWordDetector = new WordDetector(negativeWordArray);
    for(Status s : statusList){
      
      text = s.getText();
      
      status = new StatusAnalysis(s);
      status.setPositiveWordCountMap(positiveWordDetector.detect(text));
      status.setNegativeWordCountMap(negativeWordDetector.detect(text));
      
      result.getStatusList().add(status);
    }
    
    Collections.sort(result.getStatusList());
  }

}

