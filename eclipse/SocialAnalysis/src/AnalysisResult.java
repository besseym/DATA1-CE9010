import java.util.ArrayList;
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
	
	private List<StatusAnalysis> statusList;
	
	/**
	 * 
	 */
	public AnalysisResult() {
		this.statusList = new ArrayList<StatusAnalysis>();
	}
	
	/**
	 * 
	 * @param date
	 */
	public void removeOutOfWindowStatuses(Date startDate, Date endDate){
		
		List<StatusAnalysis> removeList = new ArrayList<StatusAnalysis>();
		
		for(StatusAnalysis s : statusList){
			
			if(s.getCreatedAt().before(startDate) || s.getCreatedAt().after(endDate)){
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
	public Long getMaxPostId(){
		
		Long max = null;
		
		if(!statusList.isEmpty()){
			
			max = statusList.get(0).getId();
			
			Long value = null;
			for(int i = 1; i < statusList.size(); i++){
				
				value = statusList.get(i).getId();
				if(value > max){
					
					max = value;
				}
			}
		}
		
		return max;
	}
	
	/**
	 * 
	 * @return
	 */
	public Date getMinCreatedAt(){
		
		Date min = null;
		
		if(!statusList.isEmpty()){
			
			min = statusList.get(0).getCreatedAt();
			
			Date value = null;
			for(int i = 1; i < statusList.size(); i++){
				
				value = statusList.get(i).getCreatedAt();
				if(value.before(min)){
					
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
	public Integer getMinWordCount(){
		
		Integer min = null;
		
		if(!statusList.isEmpty()){
			
			min = statusList.get(0).getNetWordCount();
			
			Integer value = null;
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
	public Integer getMaxWordCount(){
		
		Integer max = null;
		
		if(!statusList.isEmpty()){
			
			max = statusList.get(0).getNetWordCount();
			
			Integer value = null;
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
	public Long getMinCreatedAtValue(){
		
		Long min = null;
		
		if(!statusList.isEmpty()){
		
			min = statusList.get(0).getCreatedAtValue();
			
			Long value = null;
			
			for(int i = 1; i < statusList.size(); i++){
				
				value = statusList.get(i).getCreatedAtValue();
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
	public Long getMaxCreatedAtValue(){
		
		Long max = null;
		
		if(!statusList.isEmpty()){
			
			max = statusList.get(0).getCreatedAtValue();
			
			Long value = null;
			
			for(int i = 1; i < statusList.size(); i++){
				
				value = statusList.get(i).getCreatedAtValue();
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
	 */
	public void updateCreatedAtValue(Date startDate){
		
		for(StatusAnalysis status : this.statusList){
			status.setCreatedAtValue(startDate);
		}
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
