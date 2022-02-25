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
import com.ibm.icu.text.RuleBasedNumberFormat;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.input.RDFContent;
import edu.upf.taln.welcome.dms.commons.input.RDFContent.JsonldGeneric;
import edu.upf.taln.welcome.dms.commons.input.Slot;
import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;
import edu.upf.taln.welcome.dms.commons.output.SpeechActLabel;
import edu.upf.taln.welcome.nlg.core.utils.ContentDBClient;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;


public class LanguageGenerator {
    
    private static final String CONTENTDB_URL = "https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections";
    protected static final String DEFAULT_TEMPLATE_COLLECTION = "UtteranceTemplatesSecondPrototype";
    protected static final String DEFAULT_SUBTEMPLATE_COLLECTION = "ConstantSubtemplatesSecondPrototype";
    protected static final String TTS_TEMPLATE_COLLECTION = "UtteranceTemplatesSecondPrototype";
    protected static final String TTS_SUBTEMPLATE_COLLECTION = "ConstantSubtemplatesSecondPrototype";
    
    private static final Pattern placeholder = Pattern.compile("<([^>]+)>"); //
    private static final Pattern hourPattern = Pattern.compile("(\\d?\\d):(\\d\\d)"); //
    
    private final Logger logger = Logger.getLogger(LanguageGenerator.class.getName());

    private Map<ULocale, Map<String, String>> canned;
    private ContentDBClient contentClient;
    
    private static class GenerationResult {
        String text;
        String ttsStr;
    }
    
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
    
    public GenerationResult generateSingleText(SpeechAct act, ULocale language) throws WelcomeException {
		
		String templateId = null;
		Set<RDFContent> rdfContents = null;
		
    	Slot slot = act.slot;
		if (slot != null) {
			
			templateId = slot.templateId;
			
			if (slot.rdf != null) {
				rdfContents = new HashSet(slot.rdf);
				for (RDFContent rdf : rdfContents) {
					if (rdf.id != null && rdf.id.equals("welcome:Unknown")) {
						rdfContents.remove(rdf);
					}
				}
			}
		}
        
        GenerationResult result = new GenerationResult();
        if (act.label == SpeechActLabel.Signal_non_understanding ||
				act.label == SpeechActLabel.Apology_No_Extra_Information) {
            
            String text = getCannedText(act, language);
            
            result.text = text;
            result.ttsStr = text;
			
        } else if (templateId == null && (rdfContents == null || rdfContents.isEmpty())) {
            String text = getCannedText(act, language);
            
            result.text = text;
            result.ttsStr = text;
			
		} else if (templateId != null) {
            result.text = getTemplateText(act, language, DEFAULT_TEMPLATE_COLLECTION, DEFAULT_SUBTEMPLATE_COLLECTION, false);
            result.ttsStr = getTemplateText(act, language, TTS_TEMPLATE_COLLECTION, TTS_SUBTEMPLATE_COLLECTION, true);

        } else {
            String text = getGeneratedText(act);

            result.text = text;
            result.ttsStr = text;
        }
        return result;
}

    public GenerationOutput generate(DialogueMove move, ULocale language) throws WelcomeException {
        
    	List<String> texts = new ArrayList<>();
        List<String> chunks = new ArrayList<>();
        for (SpeechAct act: move.speechActs) {
            
            GenerationResult result = generateSingleText(act, language);
        	texts.add(result.text);
            chunks.add(result.ttsStr);
        }

        GenerationOutput output = new GenerationOutput();
        output.setText(String.join("\n\n", texts));
        output.setChunks(chunks);
        output.setChunkType(GenerationOutput.ChunkType.Slot);
        
    	return output;
    }

    private String getCannedText(SpeechAct act, ULocale language) throws WelcomeException {
        
        Map<String, String> languageMap = canned.get(language);
        if (languageMap == null) {
            throw new WelcomeException("Language not supported for canned text: " + language.getBaseName());

        } else {
			String key = act.label.toString();
			String cannedText = languageMap.get(key);
			
			if (cannedText == null && act.slot != null) {
                key = cleanCompactedSchema(act.slot.id);				
	            cannedText = languageMap.get(key);
			}

            if (cannedText == null) {
                throw new WelcomeException("No canned text found for key: " + key + " (" + language.getBaseName() + ")");

            } else {
                return cannedText;
            }
        }
    }

    private String getTemplateText(SpeechAct act, ULocale language, String collectionId, String subCollectionId, boolean spelloutNumbers) throws WelcomeException {
        Slot slot = act.slot;
        String templateId = slot.templateId;

        String message = "";
        try {
            String template = contentClient.getTemplate(DEFAULT_TEMPLATE_COLLECTION, templateId, language);
            
            //TODO case when template contains <hasTranslation>
            //get hasOntologyType value and obtain new template

            if (template != null) {
                message = applyTemplate(template, slot, language, collectionId, subCollectionId, spelloutNumbers);
                
                String trimmed = message.trim();
                if (!trimmed.endsWith(".") &&
                        !trimmed.endsWith("!") &&
                        !trimmed.endsWith("?")) {
                    message = trimmed + ".";
                }
            }
            
        } catch (WelcomeException we) {
            logger.log(Level.SEVERE, we.getMessage());
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
    
    private void getSubtemplateValue(HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, String subTemplateId, ULocale language, String valueName, String collectionId) throws WelcomeException {
        
    	String subTemplate = contentClient.getTemplate(collectionId, subTemplateId, language);
    	if (subTemplate != null) {
            RDFContent subTemplateRdf = new RDFContent();
            subTemplateRdf.object = new JsonldGeneric(subTemplate);
            addValueToRDFMap(rdfMap, valueName, subTemplateRdf);
        }
    }

    private HashMap<String, List<MutablePair<RDFContent, Boolean>>>  extractData(Slot slot, ULocale language, String subCollectionId) throws WelcomeException {
        
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
	        	getSubtemplateValue(rdfMap, rdf.object.value, language, cleanCompactedSchema(rdf.predicate), subCollectionId);
        	}
        }
        
        //look for ontology info
        if (slot.ontology != null) {
        	String onto = Ontology2TemplateDictionary.getInstance().get(slot.ontology);
        	if (onto != null) {
        		getSubtemplateValue(rdfMap, onto, language, "hasOntologyType", subCollectionId);
        	}
        }
        
        return rdfMap;
    }

    private String applyTemplate(String template, HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, ULocale language, boolean spelloutNumbers) {
        
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
                        }
                        
                        if (variable.contains("hasSkypeId")) {
                            replacement = replacement.replaceAll("\\.", " dot ");
                        }
                        
                        if (spelloutNumbers){
                            Matcher hourMatcher = hourPattern.matcher(replacement.trim());
                            if (hourMatcher.matches()) {
                                String hourStr = hourMatcher.group(1);
                                String minutesStr = hourMatcher.group(2);

                                String meridian = "am";
                                Integer hour = Integer.parseInt(hourStr);
                                if (hour > 12) {
                                    hour = hour % 12;
                                    meridian = "pm";
                                }
                                Integer minutes = Integer.parseInt(minutesStr);
                                if (hour == 12 && minutes > 0) {
                                    meridian = "pm";
                                }
                                RuleBasedNumberFormat ruleBasedNumberFormat = new RuleBasedNumberFormat(language, RuleBasedNumberFormat.SPELLOUT);
                                String spelloutHour = ruleBasedNumberFormat.format(hour);

                                String spelloutMinutes;
                                if (minutes == 0) {
                                    spelloutMinutes = meridian;
                                } else {
                                    spelloutMinutes = ruleBasedNumberFormat.format(minutes) + " " + meridian;
                                }
                                String formattedTime = spelloutHour + " " + spelloutMinutes;
                                replacement = formattedTime;
                            }
                        }
                    }
                }
                
                if (replacement.isEmpty()) {
                    replacement = ":" + variable + ":";
                    logger.log(Level.SEVERE, "No rdf subject found for placeholder ''{0}''.", variable);                    
                }
                
                if (!replacement.startsWith("http") && !replacement.startsWith("www")) {
                    replacement = replacement.replace("&", " and ").replace("/", " or ");
                }
                message.replace(matcher.start(), matcher.end(), replacement);
            }
        } while (marchFound);

        return message.toString();
    }
    
    public String applyTemplate(String template, Slot slot, ULocale language, String collectionId, String subCollectionId, boolean spelloutNumbers) throws WelcomeException {
        
        HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap = extractData(slot, language, subCollectionId);
        
        String newTemplate = specialCases(slot, rdfMap, language, collectionId);
        if (newTemplate != null) {
        	template = newTemplate;
        }
        
        String text = applyTemplate(template, rdfMap, language, spelloutNumbers);
        return text;
    }
    
    private String specialCases(Slot slot, HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, ULocale language, String collectionId) throws WelcomeException {
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
			case "pps:informSkypeID":
				rdfResults = rdfMap.get("Language:hasValue");
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TInformAppCallAccountIDTwoLanguages";
				} else {
					newTemplateId = "TInformAppCallAccountIDOneLanguage";
				}
				break;
			default: 
				break;
		}
		
		String template = null;
		
		if(newTemplateId != null) {
			String newTemplate = contentClient.getTemplate(collectionId, newTemplateId, language);
			if (newTemplate != null) {
	            template = newTemplate;
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
