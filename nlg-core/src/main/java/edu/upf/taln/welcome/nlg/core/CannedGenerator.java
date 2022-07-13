package edu.upf.taln.welcome.nlg.core;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.tuple.MutablePair;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.input.RDFContent;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;

/**
 *
 * @author rcarlini
 */
public class CannedGenerator {
	
    private Map<ULocale, Map<String, String>> canned;
    
    private static final Pattern placeholder = Pattern.compile("<([^>]+)>");

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
            	cannedText = cannedText.trim();
            	
            	if(act.slot != null && act.slot.tcnAnswer != null) {
	            	StringBuilder message = new StringBuilder();
	            	Map<String, List<MutablePair<RDFContent, Boolean>>> tcnAnswer = BasicTemplateGenerator.extractRdfData(act.slot.tcnAnswer);
	            	
	            	Matcher matcher = placeholder.matcher(cannedText);
	            	
	            	if (tcnAnswer != null && !tcnAnswer.isEmpty() && matcher.find()) {
		            	Iterator<Entry<String, List<MutablePair<RDFContent, Boolean>>>> iterator = tcnAnswer.entrySet().iterator();
								
		        		do {
		        			String replacement = null;
		        			
		        			String variable = matcher.group(1);
		        			if (variable.equals("TCNAnswer")) {
		        				replacement = "";
		        				Entry<String, List<MutablePair<RDFContent, Boolean>>> lastElement = null;
		    					while (iterator.hasNext()) { lastElement = iterator.next(); }
			    				if (lastElement != null) {
			    					List<MutablePair<RDFContent, Boolean>> rdfList = lastElement.getValue();
		    						if (rdfList != null && !rdfList.isEmpty()) {
		    							RDFContent rdf = null;
		    							rdf = rdfList.get(0).getLeft();
		    							if (rdf.object != null && rdf.object.value != null) {
		    								replacement = rdf.object.value;
		    							}
		    						}
			        			}
			        			matcher.appendReplacement(message, replacement);
			                }
		        			matcher.appendTail(message);
						} while (matcher.find());
		        		
		        		return message.toString();
		        		
	            	} 
            	}
            		
            	return cannedText;
            	
            }
        }
    }
	
}
