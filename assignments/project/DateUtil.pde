import java.util.Calendar;
import java.util.Date;

/**
 * 
 */

/**
 * @author michaelbessey
 *
 */
public class DateUtil {

  /**
   * 
   */
  public DateUtil() {}
  
  /**
   * 
   * @param date
   * @return
   */
  public Date getStartWindow(Date date){
    
    Calendar c = Calendar.getInstance();
    c.setTime(date);
    c.add(Calendar.MINUTE, -5);
    
    return c.getTime();
  }
  
  /**
   * 
   * @param startDate
   * @param endDate
   * @return
   */
  public long getSecondsDiff(Date startDate, Date endDate){
    
    long start = startDate.getTime();
    long end = endDate.getTime();
    
    return ((end - start) / 1000);
  }

}

