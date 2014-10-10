import twitter4j.Status;

/**
 * 
 */

/**
 * @author besseym
 *
 */
public class StatusView {
	
	private Long id;

	/**
	 * 
	 */
	public StatusView(Status status) {
		
		this.id = status.getId();
	}

}
