import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 
 */

/**
 * @author besseym
 *
 */
public class AnalysisResult {

  private Long maxPostId;
  
  private List<StatusAnalysis> statusList;
  
  /**
   * 
   */
  public AnalysisResult() {
    
    this.maxPostId = null;
    
    this.statusList = new ArrayList<StatusAnalysis>();
  }
  
  /**
   * 
   * @param date
   */
  public void removeOldStatuses(Date date){
    
    List<StatusAnalysis> removeList = new ArrayList<StatusAnalysis>();
    
    for(StatusAnalysis s : statusList){
      
      if(s.getCreatedAt().before(date)){
        removeList.add(s);
      }
    }
    
    for(StatusAnalysis s : removeList){
      statusList.remove(s);
    }
  }
  
  /**
   * 
   * @return
   */
  public Integer getMinWordCount(){
    
    Integer min = null;
    
    if(!statusList.isEmpty()){
      
      min = statusList.get(0).getNetWordCount();
      
      int value = 0;
      for(int i = 1; i < statusList.size(); i++){
        
        value = statusList.get(i).getNetWordCount();
        if(value < min){
          
          min = value;
        }
      }
    
    }
    
    return min;
  }
  
  /**
   * 
   * @return
   */
  public int getMaxWordCount(){
    
    Integer max = null;
    
    if(!statusList.isEmpty()){
      
      max = statusList.get(0).getNetWordCount();
      
      int value = 0;
      for(int i = 1; i < statusList.size(); i++){
        
        value = statusList.get(i).getNetWordCount();
        if(value > max){
          
          max = value;
        }
      }
    }
    
    return max;
  }
  
  /**
   * 
   * @param startDate
   * @return
   */
  public long getMinCreatedAtValue(Date startDate){
    
    Long min = null;
    
    if(!statusList.isEmpty()){
    
      min = statusList.get(0).getCreatedAtValue(startDate);
      
      long value = 0;
      
      for(int i = 1; i < statusList.size(); i++){
        
        value = statusList.get(i).getCreatedAtValue(startDate);
        if(value < min){
          min = value;
        }
      }
    }
    
    return min;
  }
  
  /**
   * 
   * @param startDate
   * @return
   */
  public long getMaxCreatedAtValue(Date startDate){
    
    Long max = null;
    
    if(!statusList.isEmpty()){
      
      max = statusList.get(0).getCreatedAtValue(startDate);
      
      long value = 0;
      
      for(int i = 1; i < statusList.size(); i++){
        
        value = statusList.get(i).getCreatedAtValue(startDate);
        if(value > max){
          
          max = value;
        }
      }
    }
    
    return max;
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
   * 
   * @return
   */
  public List<StatusAnalysis> getStatusList() {
    return statusList;
  }

  /**
   * 
   * @param statusList
   */
  public void setStatusList(List<StatusAnalysis> statusList) {
    this.statusList = statusList;
  }

}

