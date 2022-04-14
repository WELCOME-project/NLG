package edu.upf.taln.welcome.nlg.core;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;

/**
 *
 * @author rcarlini
 */
public class CannedGenerator {
	
    private Map<ULocale, Map<String, String>> canned;

	public CannedGenerator(String filepath) throws WelcomeException {
		try {
			ObjectMapper mapper = new ObjectMapper();
			TypeReference<Map<ULocale, Map<String, String>>> type = new TypeReference<>() {};

			InputStream cannedStream = LanguageGenerator.class.getResourceAsStream(filepath);
			canned = mapper.readValue(cannedStream, type);

		} catch (IOException  ex) {
			throw new WelcomeException(ex);
		}		
	}
	
    public String getCannedText(SpeechAct act, ULocale language) throws WelcomeException {
        
        Map<String, String> languageMap = canned.get(language);
        if (languageMap == null) {
            throw new WelcomeException("Language not supported for canned text: " + language.getBaseName());

        } else {
			String key = act.label.toString();
			String cannedText = languageMap.get(key);
			
			if (cannedText == null && act.slot != null) {
                key = BasicTemplateGenerator.cleanCompactedSchema(act.slot.id);				
	            cannedText = languageMap.get(key);
			}

            if (cannedText == null) {
                throw new WelcomeException("No canned text found for key: " + key + " (" + language.getBaseName() + ")");

            } else {
                return cannedText;
            }
        }
    }
	
}
