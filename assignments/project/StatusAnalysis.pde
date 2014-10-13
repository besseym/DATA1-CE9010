import java.util.Date;
import java.util.Map;

import twitter4j.Status;

/**
 * @author besseym
 *
 */
public class StatusAnalysis implements Comparable<StatusAnalysis> {
  
  private Long id;
  private String text;
  private Date createdAt;
  private String userScreenName;
  
  private Long createdAtValue;
  
  private Integer positiveWordCount;
  private Integer negativeWordCount;
  
  private Map<String, Integer> positiveWordCountMap;
  private Map<String, Integer> negativeWordCountMap;
  
  public StatusAnalysis() {
  }

  /**
   * 
   */
  public StatusAnalysis(Status s) {
    
    this.id = Long.valueOf(s.getId());
    this.text = s.getText();
    this.createdAt = s.getCreatedAt();
    
    this.userScreenName = s.getUser().getScreenName();
  }
  
  /**
   * 
   * @return
   */
  public int getNetWordCount(){
    
    return this.positiveWordCount - this.negativeWordCount;
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
   * 
   * @return
   */
  public String getText() {
    return text;
  }
  
  /**
   * 
   * @param text
   */
  public void setText(String text) {
    this.text = text;
  }

  /**
   * 
   * @return
   */
  public Date getCreatedAt() {
    return createdAt;
  }
  
  /**
   * 
   * @param startDate
   * @return
   */
  public Long getCreatedAtValue(Date startDate){
    
    if(this.createdAtValue == null){
      this.createdAtValue = (new DateUtil()).getSecondsDiff(startDate, this.createdAt);
    }
    
    return createdAtValue;
  }
  
  /**
   * 
   * @param createdAtValue
   */
  public void setCreatedAtValue(Long createdAtValue) {
    this.createdAtValue = createdAtValue;
  }

  /**
   * 
   * @return
   */
  public String getUserScreenName() {
    return userScreenName;
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
    this.positiveWordCount = countWordTotal(positiveWordCountMap);
  }

  /**
   * 
   * @return
   */
  public Integer getPositiveWordCount() {
    return positiveWordCount;
  }
  
  /**
   * 
   */
  public void setPositiveWordCount(Integer positiveWordCount){
    this.positiveWordCount = positiveWordCount;
  }

  /**
   * 
   * @return
   */
  public Integer getNegativeWordCount() {
    return negativeWordCount;
  }
  
  /**
   * 
   */
  public void setNegativeWordCount(Integer negativeWordCount){
    this.negativeWordCount = negativeWordCount;
  }

  /**
   * @param negativeWordCountMap the negativeWordCountMap to set
   */
  public void setNegativeWordCountMap(Map<String, Integer> negativeWordCountMap) {
    
    this.negativeWordCountMap = negativeWordCountMap;
    this.negativeWordCount = countWordTotal(negativeWordCountMap);
  }
  
  /**
   * @return the negativeWordCountMap
   */
  public Map<String, Integer> getNegativeWordCountMap() {
    return negativeWordCountMap;
  }

  @Override
  public String toString() {
    return "StatusAnalysis [id=" + id + ", createdAt=" + createdAt 
        + ", positiveWordCount=" + positiveWordCount 
        + ", negativeWordCount=" + negativeWordCount + "]";
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

  /*
   * (non-Javadoc)
   * @see java.lang.Comparable#compareTo(java.lang.Object)
   */
  @Override
  public int compareTo(StatusAnalysis o) {
    
    return this.createdAt.compareTo(o.createdAt);
  }

}

