
import java.util.Calendar;
import java.util.Date;

import twitter4j.Query;
import twitter4j.TwitterException;
import twitter4j.conf.ConfigurationBuilder;

/**
 * 
 */

/**
 * @author besseym
 *
 */
public class TwitterTest {

	/**
	 * 
	 */
	public TwitterTest() {
		// TODO Auto-generated constructor stub
	}
	
	public Date getStartWindow(Date date){
		
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(Calendar.MINUTE, -10);
		
		return c.getTime();
	}
	
	public static long getSecondsDiff(Date startDate, Date endDate){
		
		long start = startDate.getTime();
		long end = endDate.getTime();
		
		return ((end - start) / 1000);
	}

	/**
	 * @param args
	 * @throws InterruptedException 
	 */
	public static void main(String[] args) throws InterruptedException {
		
		ConfigurationBuilder cb = new ConfigurationBuilder();
		cb.setOAuthConsumerKey("MYDeYi8rLbmqJeyNcJz92vVK9");
		cb.setOAuthConsumerSecret("vUf3ePnVhNnGCuX4HAcLGIKByeGtUstVgxLO3iLPL1lE6AQyaQ");
		cb.setOAuthAccessToken("188482760-FXnx6MVyKSFVGdh6qZHteeKVsAxb3iz1pRweC5rt");
		cb.setOAuthAccessTokenSecret("eUoRaPzK09hieT9tJxayPoGT2QDILZJPWEjdq0pAmJMVY");
		
		TwitterAlignmentAnalysis twitterWrapper = new TwitterAlignmentAnalysis(cb.build());
		
		try {
			
			Query query = new Query("#Homeland");
			
			Long maxPostId = null;
			AnalysisResult result = new AnalysisResult();
			
			for(int i = 0; i < 1; i++){
			
				maxPostId = result.getMaxPostId();
				if(maxPostId != null){
					query.sinceId(maxPostId);
				}
				
				twitterWrapper.analyze(query, result);
				
				System.out.println();
				
//				System.out.println("Number of Posts: " + result.getPostCount());
//				System.out.println("Number of Users: " + result.getUserCount());
//				System.out.println("Max Post Id: " + result.getMaxPostId());
				System.out.println("Max: " + result.getMaxWordCount());
				System.out.println("Min: " + result.getMinWordCount());
				System.out.println("Numb statuses: " + result.getStatusList().size());
				
				Date now = new Date();
				Date startDate = (new DateUtil()).getStartWindow(now);
				result.removeOldStatuses(startDate);
				
				System.out.println("Now: " + new Date());
				for(StatusAnalysis s : result.getStatusList()){
					System.out.println(s.getText());
//					System.out.println(s.getDateValue(startDate));
				}
				
				System.out.println();
				
				Thread.sleep(5000);
			}
			
		}
		catch (TwitterException te) {
			System.out.println("Couldn't connect: " + te);
		}

	}

}
