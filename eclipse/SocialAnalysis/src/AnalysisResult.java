import java.util.HashMap;
import java.util.Map;

/**
 * 
 */

/**
 * @author besseym
 *
 */
public class AnalysisResult {

	private Long maxPostId;
	
	private Integer userCount;
	private Integer postCount;
	
	private Map<String, Integer> positiveWordCountMap;
	private Map<String, Integer> negativeWordCountMap;
	
	/**
	 * 
	 */
	public AnalysisResult() {
		
		this.userCount = Integer.valueOf(0);
		this.postCount = Integer.valueOf(0);
		
		this.positiveWordCountMap = new HashMap<String, Integer>();
		this.negativeWordCountMap = new HashMap<String, Integer>();
	}
	
	/**
	 * 
	 * @param wordCountMap
	 */
	public void addToPositiveWordCount(Map<String, Integer> wordCountMap){
		
		Integer count = null;
		
		for(String word : wordCountMap.keySet()){
			
			if(this.positiveWordCountMap.containsKey(word)){
				
				count = this.positiveWordCountMap.get(word);
				count = count + wordCountMap.get(word);
			}
			else {
				count = wordCountMap.get(word);
			}
			
			this.positiveWordCountMap.put(word, count);
		}
	}
	
	/**
	 * 
	 * @param wordCountMap
	 */
	public void addToNegativeWordCount(Map<String, Integer> wordCountMap){
		
		Integer count = null;
		
		for(String word : wordCountMap.keySet()){
			
			if(this.negativeWordCountMap.containsKey(word)){
				
				count = this.negativeWordCountMap.get(word);
				count = count + wordCountMap.get(word);
			}
			else {
				count = wordCountMap.get(word);
			}
			
			this.negativeWordCountMap.put(word, count);
		}
	}

	/**
	 * @return the maxPostId
	 */
	public Long getMaxPostId() {
		return maxPostId;
	}

	/**
	 * @param maxPostId the maxPostId to set
	 */
	public void setMaxPostId(Long maxPostId) {
		this.maxPostId = maxPostId;
	}

	/**
	 * @return the userCount
	 */
	public Integer getUserCount() {
		return userCount;
	}

	/**
	 * @param userCount the userCount to set
	 */
	public void setUserCount(Integer userCount) {
		this.userCount = userCount;
	}

	/**
	 * @return the postCount
	 */
	public Integer getPostCount() {
		return postCount;
	}

	/**
	 * @param postCount the postCount to set
	 */
	public void setPostCount(Integer postCount) {
		this.postCount = postCount;
	}

	/**
	 * @return the positiveWordCountMap
	 */
	public Map<String, Integer> getPositiveWordCountMap() {
		return positiveWordCountMap;
	}

	/**
	 * @param positiveWordCountMap the positiveWordCountMap to set
	 */
	public void setPositiveWordCountMap(Map<String, Integer> positiveWordCountMap) {
		this.positiveWordCountMap = positiveWordCountMap;
	}

	/**
	 * @return the negativeWordCountMap
	 */
	public Map<String, Integer> getNegativeWordCountMap() {
		return negativeWordCountMap;
	}

	/**
	 * @param negativeWordCountMap the negativeWordCountMap to set
	 */
	public void setNegativeWordCountMap(Map<String, Integer> negativeWordCountMap) {
		this.negativeWordCountMap = negativeWordCountMap;
	}

}
