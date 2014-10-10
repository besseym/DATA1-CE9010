import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 */

/**
 * @author besseym
 *
 */
public class WordDetector {
	
	private static String START_REGEX = "(^|\\s|[\\(,\",:,-])";
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
	
	public static void main(String[] args) {
		
		String [] wordArray = {"hate", "lorem", "imperdiet", "despise"};
		WordDetector emotionDetector = new WordDetector(wordArray);
		
		String text = "\"Hate\" Lorem ipsum dolor sit amet, consectetur adipiscing Lorem. Integer consequat ac nibh sed varius. Mauris tristique augue urna, sit amet iaculis dolor blandit congue. Praesent sit amet sodales dolor. Phasellus congue est ac nibh hendrerit tincidunt. Donec ullamcorper lacus quis nibh rhoncus vehicula. Donec cursus nibh a magna consequat, eu rutrum arcu tempor. Aliquam eleifend odio nec nisl eleifend molestie. Curabitur laoreet leo sit amet urna scelerisque, sit amet tempor sapien laoreet. Ut tincidunt accumsan felis, eu vestibulum lectus. Quisque imperdiet porttitor ante. ";
		Map<String, Integer> wordCountMap = emotionDetector.detect(text);
		
		System.out.println(wordCountMap);
	}

}
