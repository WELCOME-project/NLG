package edu.upf.taln.welcome.nlg.core.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.ibm.icu.text.RuleBasedNumberFormat;
import com.ibm.icu.util.ULocale;

/**
 *
 * @author rcarlini
 */
public class TimeMapper {

    private static final Pattern HOUR_PATTERN = Pattern.compile("(\\d?\\d):(\\d\\d)"); //
	
	public static String spelloutHours(String text, ULocale language, boolean addPmAm) {
		
		StringBuilder sb = new StringBuilder();
		RuleBasedNumberFormat ruleBasedNumberFormat = new RuleBasedNumberFormat(language, RuleBasedNumberFormat.SPELLOUT);
		
		Matcher hourMatcher = HOUR_PATTERN.matcher(text);
		while(hourMatcher.find()) {
			
			String hourMatch = hourMatcher.group(1);
			String minutesMatch = hourMatcher.group(2);

			Integer hour = Integer.parseInt(hourMatch);
			Integer minutes = Integer.parseInt(minutesMatch);

			String meridian = "am";
			if (hour > 12) {
				hour = hour % 12;
				meridian = "pm";
				
			} else if (hour == 12 && minutes > 0) {
				meridian = "pm";
			}
			
			StringBuilder formattedTime = new StringBuilder();
			String hourStr = ruleBasedNumberFormat.format(hour);
			formattedTime.append(hourStr);

			if (minutes != 0) {
				formattedTime.append(" ");
				String minutesStr = ruleBasedNumberFormat.format(minutes);
				formattedTime.append(minutesStr);
			}

			if (addPmAm) {
				formattedTime.append(" ");
				formattedTime.append(meridian);
			}

			hourMatcher.appendReplacement(sb, formattedTime.toString());
		}
		hourMatcher.appendTail(sb);
		
		return sb.toString();
	}
}
