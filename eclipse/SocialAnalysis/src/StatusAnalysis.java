import java.util.Map;

/**
 * 
 */

/**
 * @author besseym
 *
 */
public class StatusAnalysis {
	
	private Long id;
	private Map<String, Integer> positiveWordCountMap;
	private Map<String, Integer> negativeWordCountMap;

	/**
	 * 
	 */
	public StatusAnalysis(long id) {
		
		this.id = Long.valueOf(id);
	}
	
	/**
	 * 
	 * @return
	 */
	public int getPositiveWordCount(){
		return countWordTotal(positiveWordCountMap);
	}
	
	/**
	 * 
	 * @return
	 */
	public int getNegativeWordCount(){
		return countWordTotal(positiveWordCountMap);
	}
	
	/**
	 * 
	 * @param wordCountMap
	 * @return
	 */
	private int countWordTotal(Map<String, Integer> wordCountMap){
		
		int count = 0;
		for(String word : wordCountMap.keySet()){
			
			count = count + wordCountMap.get(word);
		}
		
		return count;
	}

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
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

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StatusAnalysis other = (StatusAnalysis) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}
