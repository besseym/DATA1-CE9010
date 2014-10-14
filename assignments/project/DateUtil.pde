import java.text.SimpleDateFormat;
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
  
  private int secondsInWindow;
  private SimpleDateFormat simpleDateFormat;

  /**
   * 
   */
  public DateUtil() {
    
    this.secondsInWindow = 300;
    this.simpleDateFormat = new SimpleDateFormat("HH:mm:ss");
  }
  
  /**
   * 
   * @param date
   * @return
   */
  public String formatDate(Date date){
    return this.simpleDateFormat.format(date);
  }
  
  /**
   * 
   * @param date
   * @return
   */
  public Date getStartWindow(Date date){
    
    Calendar c = Calendar.getInstance();
    c.setTime(date);
    c.add(Calendar.SECOND, -this.secondsInWindow);
    
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
  
  /**
   * 
   * @param startDate
   * @param seconds
   * @return
   */
  public Date addSeconds(Date startDate, int seconds){
    
    Calendar c = Calendar.getInstance();
    c.setTime(startDate);
    c.add(Calendar.SECOND, seconds);
    
    return c.getTime();
  }

  /**
   * @return the secondsInWindow
   */
  public int getSecondsInWindow() {
    return secondsInWindow;
  }

}

