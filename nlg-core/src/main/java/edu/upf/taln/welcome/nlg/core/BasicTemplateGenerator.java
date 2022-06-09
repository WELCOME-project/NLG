package edu.upf.taln.welcome.nlg.core;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.tuple.MutablePair;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.input.RDFContent;
import edu.upf.taln.welcome.dms.commons.input.Slot;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;
import edu.upf.taln.welcome.nlg.core.utils.ContentDBClient;
import edu.upf.taln.welcome.nlg.core.utils.TimeMapper;

/**
 *
 * @author rcarlini
 */
public class BasicTemplateGenerator {

	private final Logger logger = Logger.getLogger(BasicTemplateGenerator.class.getName());

    private static final String CONTENTDB_URL = "https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections";

	private static final Pattern placeholder = Pattern.compile("<([^>]+)>"); //

	private ContentDBClient contentClient;

    
    public static String cleanCompactedSchema(String value) {
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
	
	
	public BasicTemplateGenerator() throws WelcomeException {
		contentClient = new ContentDBClient(CONTENTDB_URL);		
	}

    public List<String> getTemplateText(SpeechAct act, ULocale language, String collectionId, String subCollectionId, boolean spelloutNumbers) throws WelcomeException {
        Slot slot = act.slot;
        String templateId = slot.templateId;

        List<String> sentences = new ArrayList<>();
        try {
            String template = contentClient.getTemplate(collectionId, templateId, language);

            //TODO case when template contains <hasTranslation>
            //get hasOntologyType value and obtain new template

            if (template != null) {
            	
            	//split template <s_end> into separated sentences
            	String[] templatesArray = template.split("<s_end>");
            	for (String sentenceTemplate : templatesArray) {
            		
            		String message = applyTemplate(sentenceTemplate, slot, language, collectionId, subCollectionId, spelloutNumbers);
                    
    				message = message.replaceAll(" NGO", " N G O");
    				message = message.replaceAll("PRAKSIS", "Praksis");
    				
    				message = message.trim();
                    if (!message.endsWith(".") &&
                            !message.endsWith("!") &&
                            !message.endsWith("?")) {
                        message = message + ".";
                    }
                    
                    sentences.add(message);
            	}
 
            }
            
        } catch (WelcomeException we) {
            logger.log(Level.SEVERE, we.getMessage());
        }
        
        return sentences;
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
            subTemplateRdf.object = new RDFContent.JsonldGeneric(subTemplate);
            addValueToRDFMap(rdfMap, valueName, subTemplateRdf);
        }
    }

    private HashMap<String, List<MutablePair<RDFContent, Boolean>>>  extractData(Slot slot, ULocale language, String subCollectionId) throws WelcomeException {
        
        HashMap<String, List<MutablePair<RDFContent, Boolean>>> rdfMap = new HashMap<>();
        if (slot.rdf != null) {
	        for (RDFContent rdf : slot.rdf) {

                String subject = null;
	        	if (rdf.subject != null) {
                    subject = cleanCompactedSchema(rdf.subject);
                }

	        	String key = null;
                if (subject != null && subject.equals("subTemplate")) {
                    key = subject;

                } else if (rdf.predicate != null) {

                    String predicate = cleanCompactedSchema(rdf.predicate);
                    if (subject != null
                            && (predicate.equals("hasValue")
                                || predicate.equals("hasName") 
                                || predicate.equals("hasRole")
								|| predicate.equals("hasRoleSummary"))) {
                        key = subject + ":" + predicate;

                    } else {
                        key = predicate;
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
        
        StringBuilder message = new StringBuilder();
		
		Matcher matcher = placeholder.matcher(template);
		while (matcher.find()) {
			String replacement = null;
			
			String variable = matcher.group(1);
			if (variable.equals("set")) {
				// TODO: What is this intended for?
				replacement = "";
				
			} else if (variable.equals("hasTranslation")) {
				// TODO: What is this intended for?
				replacement = "";
				
			} else if (variable.equals("noTranslation")) {
				// TODO: What is this intended for?
				replacement = "";
				
			} else {

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
				}

				if (replacement == null) {
					replacement = ":" + variable + ":";
					logger.log(Level.SEVERE, "No rdf subject found for placeholder ''{0}''.", variable);                    
					
				} else {

					if (variable.contains("hasSkypeId")) {
						replacement = replacement.replaceAll("\\.", " dot ");
					}

					if (spelloutNumbers) {
						replacement = TimeMapper.spelloutHours(replacement, language, false);
					}

					if (!replacement.startsWith("http") && !replacement.startsWith("www")) {
						replacement = replacement.replace("&", " and ").replace("/", " or ");
					}
				}
			}

			matcher.appendReplacement(message, replacement);
        }
		matcher.appendTail(message);

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
	
}