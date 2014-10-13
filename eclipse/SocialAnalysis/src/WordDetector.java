import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author besseym
 *
 */
public class WordDetector {
	
	private static String START_REGEX = "(^|\\s|[\\(,\",:,-,#])";
	private static String END_REGEX = "([-,.,!,?,,,;,\\),\"]|([:,s]($|\\s))|((''s)($|\\s))|\\s|$)";
	
	private String [] wordArray;

	/**
	 * 
	 */
	public WordDetector(String [] wordArray) {
		this.wordArray = wordArray;
	}
	
	/**
	 * 
	 * @param text
	 */
	public Map<String, Integer> detect(String text){
		
		Map<String, Integer> wordCountMap = new HashMap<String, Integer>();
		
		String regex = null;
		
		Pattern pattern = null;
		Matcher matcher = null;
		
		for(String word : wordArray){
			
			regex = decorateRegex(word);
		
			pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
			matcher = pattern.matcher(text);
			
			int count = 0;
			while(matcher.find()) {
				count++;
			}
			
			wordCountMap.put(word, Integer.valueOf(count));
		}
		
		return wordCountMap;
	}
	
	private String decorateRegex(String text){
		return START_REGEX + text + END_REGEX;
	}

}
