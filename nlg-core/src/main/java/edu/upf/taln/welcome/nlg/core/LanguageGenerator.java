package edu.upf.taln.welcome.nlg.core;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.tuple.MutablePair;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.input.RDFContent;
import edu.upf.taln.welcome.dms.commons.input.RDFContent.JsonldGeneric;
import edu.upf.taln.welcome.dms.commons.input.Slot;
import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;
import edu.upf.taln.welcome.dms.commons.output.SpeechActLabel;
import edu.upf.taln.welcome.nlg.core.utils.ContentDBClient;

public class LanguageGenerator {
    
    private static String CONTENTDB_URL = "https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections";
    private static String DEFAULT_TEMPLATE_COLLECTION = "UtteranceTemplatesFirstPrototype";
    private static String DEFAULT_SUBTEMPLATE_COLLECTION = "ConstantSubtemplatesFirstPrototype";
    private static final Pattern placeholder = Pattern.compile("<([^>]+)>"); //
    
    private final Logger logger = Logger.getLogger(LanguageGenerator.class.getName());

    private Map<ULocale, Map<String, String>> canned;
    private ContentDBClient contentClient;
    
    public LanguageGenerator() throws WelcomeException {

        contentClient = new ContentDBClient(CONTENTDB_URL);

        try {
            ObjectMapper mapper = new ObjectMapper();
            TypeReference<Map<ULocale, Map<String, String>>> type = new TypeReference<>() {};

            InputStream cannedStream = LanguageGenerator.class.getResourceAsStream("/canned.json");
            canned = mapper.readValue(cannedStream, type);

        } catch (IOException  ex) {
            throw new WelcomeException(ex);
        }
    }
    
    public String generateSingleText(SpeechAct act, ULocale language) throws WelcomeException {
    	Slot slot = act.slot;
        String templateId = slot.templateId;
        
        Set<RDFContent> rdfContents = null;
        if (slot.rdf != null) {
            rdfContents = new HashSet(slot.rdf);
            for (RDFContent rdf : rdfContents) {
                if (rdf.id != null && rdf.id.equals("welcome:Unknown")) {
                    rdfContents.remove(rdf);
                }
            }
        }
        
        if (templateId == null && (rdfContents == null || rdfContents.isEmpty())) {
            return getCannedText(act, language);

        } else if (templateId != null) {
            return getTemplateText(act, language);

        } else {
            return getGeneratedText(act);
        }
    }

    public List<String> generate(DialogueMove move, ULocale language) throws WelcomeException {
    	List<String> texts = new ArrayList<>();
        for (SpeechAct act: move.speechActs) {
        	texts.add(generateSingleText(act, language)); 
        }
                
    	return texts;
    }

    private String getCannedText(SpeechAct act, ULocale language) throws WelcomeException {
        
        Map<String, String> languageMap = canned.get(language);
        if (languageMap == null) {
            throw new WelcomeException("Language not supported for canned text: " + language.getBaseName());

        } else {
            String key;
            if (act.label == SpeechActLabel.Apology ||
                act.label == SpeechActLabel.Conventional_opening ||
                act.label == SpeechActLabel.Conventional_closing) {

                key = act.label.toString();
            } else {
                key = act.slot.id;
                key = cleanCompactedSchema(key);
            }

            String cannedText = languageMap.get(key);
            if (cannedText == null) {
                throw new WelcomeException("No canned text found for key: " + key + " (" + language.getBaseName() + ")");

            } else {
                return cannedText;
            }
        }
    }

    private String getTemplateText(SpeechAct act, ULocale language) throws WelcomeException {
        Slot slot = act.slot;
        String templateId = slot.templateId;

        List<String> templates = contentClient.getTemplate(DEFAULT_TEMPLATE_COLLECTION, templateId, language.toString());
        
        //TODO case when template contains <hasTranslation>
        //get hasOntologyType value and obtain new template
        
        String message = "";
        if (templates == null || templates.isEmpty()) {
            logger.log(Level.SEVERE, "No template found for templateId " + templateId);
        } else {
            String template = templates.get(0);
            message = applyTemplate(template, slot, language);
        }
        
        return message;
    }
    
    public String cleanCompactedSchema(String value) {
    	if (value == null) { return null; }
    	
    	String cleanValue = value;
    	int indexFirstColon = value.indexOf(":");
    	if (indexFirstColon != -1 && cleanValue.length() > indexFirstColon) {
    		cleanValue = value.substring(indexFirstColon + 1);
    	}
    	/*String[] splittedValue = value.split(":");
        if(splittedValue.length > 1) {
        	cleanValue = splittedValue[splittedValue.length-1];
        }*/
    	return cleanValue;
    }
    
    private void addValueToRDFMap(HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, String key, RDFContent value) {
    	if (key != null && value != null) {
    		List<MutablePair<RDFContent, Boolean>> listPairs;
    		if (rdfMap.containsKey(key)) {
    			listPairs = rdfMap.get(key);
    		} else {
    			listPairs = new ArrayList<>();
    		}
    		MutablePair<RDFContent, Boolean> newPair = MutablePair.of(value, false);
    		listPairs.add(newPair);
    		rdfMap.put(key, listPairs);
    	}
    }
    
    private void getSubtemplateValue(HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, String subTemplateId, ULocale language, String valueName) throws WelcomeException {
    	List<String> subTemplatesText = contentClient.getTemplate(DEFAULT_SUBTEMPLATE_COLLECTION, subTemplateId, language.toString());
    	if (subTemplatesText == null || subTemplatesText.isEmpty()) {
            logger.log(Level.SEVERE, "No subtemplate found for templateId " + subTemplateId);
        } else {
            String subTemplateText = subTemplatesText.get(0);
            RDFContent subTemplateRdf = new RDFContent();
            subTemplateRdf.object = new JsonldGeneric(subTemplateText);
            addValueToRDFMap(rdfMap, valueName, subTemplateRdf);
        }
    }

    public String applyTemplate(String template, Slot slot, ULocale language) throws WelcomeException {
        
        HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap = new HashMap<>();
        if (slot.rdf != null) {
	        for (RDFContent rdf : slot.rdf) {
	        	String key = null;
	        	if (rdf.subject != null && cleanCompactedSchema(rdf.subject).equals("subTemplate")) {
	        		key = cleanCompactedSchema(rdf.subject);
	        	} else if (rdf.predicate != null) {
	        		if (rdf.subject != null && (cleanCompactedSchema(rdf.predicate).equals("hasValue") || cleanCompactedSchema(rdf.predicate).equals("hasName"))) {
	        			key = cleanCompactedSchema(rdf.subject) + ":" + cleanCompactedSchema(rdf.predicate);
	        		} else {
	        			key = cleanCompactedSchema(rdf.predicate);
	        		}
	        	}
	        	addValueToRDFMap(rdfMap, key, rdf);
	        }
        }
        
        //look for subtemplates
        if (rdfMap.containsKey("subTemplate")) {
        	List<MutablePair<RDFContent, Boolean>> rdfList = rdfMap.get("subTemplate");
        	RDFContent rdf = rdfList.get(0).getLeft();
        	if (rdf.predicate != null && rdf.object != null && rdf.object.value != null) {
	        	getSubtemplateValue(rdfMap, rdf.object.value, language, cleanCompactedSchema(rdf.predicate));
        	}
        }
        
        //look for ontology info
        if (slot.ontology != null) {
        	String onto = Ontology2TemplateDictionary.getInstance().get(slot.ontology);
        	if (onto != null) {
        		getSubtemplateValue(rdfMap, onto, language, "hasOntologyType");
        	}
        }
        
        String newTemplate = specialCases(slot, rdfMap, language);
        if (newTemplate != null) {
        	template = newTemplate;
        }
        
        StringBuilder message = new StringBuilder(template);
        boolean marchFound;
        do {
	        Matcher matcher = placeholder.matcher(message);
	        marchFound = matcher.find();
	        if (marchFound && matcher.groupCount() >= 1) {
                String variable = matcher.group(1);
                String replacement = "";
                if (!variable.equals("set") && !variable.equals("hasTranslation") && !variable.equals("noTranslation")) {
                	variable = removeTemplateBrackets(variable);
                	variable = cleanCompactedSchema(variable);
                	
            		List<MutablePair<RDFContent, Boolean>> rdfList = rdfMap.get(variable);
	                if (rdfList != null && !rdfList.isEmpty()) {
	                	RDFContent rdf = null;
	                	if (rdfList.size() > 1) {
	                		Iterator<MutablePair<RDFContent, Boolean>> listIterator = rdfList.iterator();
	                		while (rdf == null && listIterator.hasNext()) {
	                			MutablePair<RDFContent, Boolean> tempPair = listIterator.next();
	                			Boolean used = tempPair.getRight();
	                			if (!used) {
	                				rdf = tempPair.getLeft();
	                				tempPair.right = true;
	                			}
	                		}
	                	}
	                	if (rdf == null) {
	                		rdf = rdfList.get(0).getLeft();
	                		rdfList.get(0).right = true;
	                	}

	                	if (rdf.object != null && rdf.object.value != null) {
	                		replacement = /*cleanCompactedSchema(*/rdf.object.value/*)*/;
	                	} else if (rdf.object != null && rdf.object.id != null) {
		                	replacement = cleanCompactedSchema(rdf.object.id);
		                } else {
		                	replacement = ":" + variable + ":";
		                    logger.log(Level.SEVERE, "No rdf object found for placeholder '" + variable + "'.");
		                }
	                } else {
	                	replacement = ":" + variable + ":";
	                    logger.log(Level.SEVERE, "No rdf subject found for placeholder '" + variable + "'.");
	                }
                }
                message.replace(matcher.start(), matcher.end(), replacement);
	        }
        } while (marchFound);

        return message.toString();
    }
    
    private String specialCases(Slot slot, HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, ULocale language) throws WelcomeException {
    	String newTemplateId = null;
    	List<MutablePair<RDFContent, Boolean>> rdfResults;
		switch(slot.id) {
			case "frs:informLanguageModuleHours":
			case "frs:informSocietyModuleHours":
				rdfResults = rdfMap.get("dayOfWeek");
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TInformModuleHoursTwoDays";
				} else {
					newTemplateId = "TInformModuleHoursSingleDay";
				}
				break;
			case "frs:informLanguageModule":
				rdfResults = rdfMap.get("hasCourseName");
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TInformLanguageModuleTwoCourses";
				} else {
					newTemplateId = "TInformLanguageModuleOneCourse";
				}
				//"hasNumberHours"
				break;
			case "frs:obtainNationality":
				rdfResults = rdfMap.get("IDCountry:hasValue");
				if (rdfResults != null && rdfResults.size() > 0) {
					newTemplateId = "TObtainNationalityPassportKnown";
				} else {
					newTemplateId = "TObtainNationalityPassportUnknown";
				}
				break;
			case "welcome:obtainRequest":
				rdfResults = rdfMap.get("availableServices:hasValue");
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TObtainMatterConcernChoice";
				} else {
					newTemplateId = "TObtainMatterConcern";
				}
				break;
			default: 
				break;
		}
		
		String template = null;
		
		if(newTemplateId != null) {
			List<String> templates = contentClient.getTemplate(DEFAULT_TEMPLATE_COLLECTION, newTemplateId, language.toString());
			if (templates == null || templates.isEmpty()) {
	            logger.log(Level.SEVERE, "No template found for special templateId " + newTemplateId);
	        } else {
	            template = templates.get(0);
	        }
		}
		
		return template;
	}

	private String removeTemplateBrackets(String template) {
    	StringBuilder sb = new StringBuilder();
    	Pattern p = Pattern.compile("(:\\[[^>]+\\])");
    	Matcher m = p.matcher(template);

    	while (m.find()) {
    	    m.appendReplacement(sb, "");
    	}
    	m.appendTail(sb);

    	return sb.toString();
    }

    private String getGeneratedText(SpeechAct act) {
        return ""; // not implemmented yet
    }
}
