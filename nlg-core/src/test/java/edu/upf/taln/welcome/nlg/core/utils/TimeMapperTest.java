package edu.upf.taln.welcome.nlg.core.utils;

import com.ibm.icu.util.ULocale;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 *
 * @author rcarlini
 */
public class TimeMapperTest {
	
	/**
	 * Test of spelloutHours method, of class TimeMapper.
	 */
	@Test
	public void testSpelloutHours() {
		System.out.println("spelloutHours");
		String text = "Module B is given on Wednesdays from 19:30 to 21:00.";
		ULocale language = ULocale.ENGLISH;
		String expResult = "Module B is given on Wednesdays from seven thirty to nine.";
		String result = TimeMapper.spelloutHours(text, language, false);
		assertEquals(expResult, result);
	}
	
	/**
	 * Test of spelloutHours method, of class TimeMapper.
	 */
	@Test
	public void testSpelloutHoursMeridian() {
		System.out.println("spelloutHoursMeridian");
		String text = "Module B is given on Wednesdays from 19:30 to 21:00.";
		ULocale language = ULocale.ENGLISH;
		String expResult = "Module B is given on Wednesdays from seven thirty pm to nine pm.";
		String result = TimeMapper.spelloutHours(text, language, true);
		assertEquals(expResult, result);
	}
}
