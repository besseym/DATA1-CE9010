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
		
		String text = null;
		StatusAnalysis statusAnalysis = null;
		
		//analyze for positive words
		WordDetector positiveWordDetector = new WordDetector(positiveWordArray);
		WordDetector negativeWordDetector = new WordDetector(negativeWordArray);
		for(Status s : statusList){
			
			text = s.getText();
			
			statusAnalysis = new StatusAnalysis(s.getId());
			statusAnalysis.setPositiveWordCountMap(positiveWordDetector.detect(text));
			statusAnalysis.setNegativeWordCountMap(negativeWordDetector.detect(text));
		}
		
		//count users
//		for(Status s : statusList){
//			userSet.add(s.getUser().getScreenName());
//		}
		
		result.setUserCount(userSet.size());
		
		return result;
	}
	
	

}
