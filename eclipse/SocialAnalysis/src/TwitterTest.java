
import twitter4j.GeoLocation;
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
		
		TwitterWrapper twitterWrapper = new TwitterWrapper(cb.build());
		
		try {
			
			Query query = new Query("#Homeland");
			
//			GeoLocation geolocation = new GeoLocation(40.6986770, -73.9859410);
//			query.setGeoCode(geolocation, 10, Query.MILES);
			
			AnalysisResult result = twitterWrapper.analyze(query);
			
			System.out.println("Number of Posts: " + result.getPostCount());
			System.out.println("Number of Users: " + result.getUserCount());
			System.out.println("Max Post Id: " + result.getMaxPostId());
			System.out.println(result.getPositiveWordCountMap());
			System.out.println(result.getNegativeWordCountMap());
			
//			Long maxId = null;
			
//			for(int i = 0; i < 2; i++){
//			
//				if(maxId != null){
//					query.sinceId(maxId);
//				}
//				
//				QueryResultWrapper queryResultWrapper = twitterWrapper.search(query);
//				maxId = queryResultWrapper.getMaxId();
//				
//				System.out.println(maxId);
//				System.out.println(queryResultWrapper.getResultCount());
//				
//				Thread.sleep(1000);
//			}
			
			
//			QueryResult result = twitter.search(query);
//			List<Status> statusList = result.getTweets();
//			for(Status status : statusList){
//				System.out.print(status.getId());
//				System.out.print(" ");
//				System.out.println(status.getUser().getScreenName());
//				System.out.println(status.getText());
//				System.out.print(status.getCreatedAt());
//				
//				System.out.println(status.getRateLimitStatus());
//				
//				System.out.println();
//			}
			
		}
		catch (TwitterException te) {
			System.out.println("Couldn't connect: " + te);
		}

	}

}
