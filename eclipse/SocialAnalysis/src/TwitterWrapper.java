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
 * 
 */

/**
 * @author besseym
 *
 */
public class TwitterWrapper {
	
	private Twitter twitter;
	private String [] positiveWordArray;
	private String [] negativeWordArray;

	/**
	 * 
	 */
	public TwitterWrapper(Configuration configuration) {
		
		this.twitter = new TwitterFactory(configuration).getInstance();
		
		this.positiveWordArray = new String [] {"love", "like", "enjoy", "adore", "great"};
		this.negativeWordArray = new String [] {"hate", "dislike", "detest", "despise", "horrible"};
	}
	
	/**
	 * 
	 * @param query
	 * @return
	 * @throws TwitterException
	 */
	public AnalysisResult analyze(Query query) throws TwitterException{
		
		Set<String> userSet = new HashSet<String>();
		
		AnalysisResult result = new AnalysisResult();
		
		QueryResult queryResult = twitter.search(query);
		result.setMaxPostId(queryResult.getMaxId());
		
		List<Status> statusList = queryResult.getTweets();
		result.setPostCount(statusList.size());
		
		Map<String, Integer> wordCountMap = null;
		
		//analyze for positive words
		WordDetector wordDetector = new WordDetector(positiveWordArray);
		for(Status s : statusList){
			
			wordCountMap = wordDetector.detect(s.getText());
			result.addToPositiveWordCount(wordCountMap);
		}
		
		//analyze for negative words
		wordDetector = new WordDetector(negativeWordArray);
		for(Status s : statusList){
			
			wordCountMap = wordDetector.detect(s.getText());
			result.addToNegativeWordCount(wordCountMap);
		}
		
		//count users
		for(Status s : statusList){
			userSet.add(s.getUser().getScreenName());
		}
		
		result.setUserCount(userSet.size());
		
		return result;
	}

}
