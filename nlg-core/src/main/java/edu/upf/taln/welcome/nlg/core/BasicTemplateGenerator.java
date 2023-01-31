package edu.upf.taln.welcome.nlg.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.tuple.MutablePair;
import org.apache.commons.lang3.tuple.Pair;

import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.input.RDFContent;
import edu.upf.taln.welcome.dms.commons.input.Slot;
import edu.upf.taln.welcome.nlg.core.utils.ContentDBClient;
import edu.upf.taln.welcome.nlg.core.utils.TimeMapper;

/**
 *
 * @author rcarlini
 */
public class BasicTemplateGenerator {

	private final Logger logger = Logger.getLogger(BasicTemplateGenerator.class.getName());

	// demo server
    private static final String CONTENTDB_URL = "https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections";
    // dev server
    //private static final String CONTENTDB_URL = "http://3.20.64.60/welcome/integration/workflow/dispatcher/contentDBCollections";

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
	
	public BasicTemplateGenerator(String templatesURL) throws WelcomeException {
		contentClient = new ContentDBClient(templatesURL);		
	}
	
	public boolean isLanguageTemplate(String templateId, ULocale language, String collectionId) {

        String template = null;
		try {
			template = contentClient.getTemplate(collectionId, templateId, language);
		} catch (WelcomeException we) {
			logger.log(Level.INFO, we.getMessage());
		}

        return template != null;
	}
	
	public List<Pair<String, String>> getRequiredTemplatesIds(Slot slot, String collectionId, String subCollectionId, ULocale language) {
		List<Pair<String, String>> templatesIds = new ArrayList<>();
		
		String baseTemplateId = slot.templateId;
		templatesIds.add(Pair.of(baseTemplateId, collectionId));
		
		Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap = new HashMap<>();
        rdfMap = extractRdfData(slot.rdf);
        
        //look for subtemplates
        if (rdfMap.containsKey("subTemplate")) {
        	List<MutablePair<RDFContent, Boolean>> rdfList = rdfMap.get("subTemplate");
        	RDFContent rdf = rdfList.get(0).getLeft();
        	if (rdf.predicate != null && rdf.object != null && rdf.object.value != null) {
        		templatesIds.add(Pair.of(rdf.object.value, subCollectionId));
        	}
        }
        
        //look for ontology info
        if (slot.ontology != null) {
        	String onto = Ontology2TemplateDictionary.getInstance().get(slot.ontology);
        	if (onto != null) {
        		templatesIds.add(Pair.of(onto, subCollectionId));
        	}
        }
	        
		String newTemplate = getSpecialCasesTemplateId(slot, rdfMap, language);
		if (newTemplate != null) {
			templatesIds.add(Pair.of(newTemplate, collectionId));
		}
			
		return templatesIds;
	}

    public List<String> getTemplateText(Slot slot, ULocale language, String collectionId, String subCollectionId, boolean spelloutNumbers) throws WelcomeException {

    	String templateId = slot.templateId;
    	
        List<String> sentences = new ArrayList<>();
        
        try {
        	String template = contentClient.getTemplate(collectionId, templateId, language);

            //TODO case when template contains <hasTranslation>
            //get hasOntologyType value and obtain new template
            
            if (template != null) {

    			// split template <s_end> into separated sentences
    			String[] templatesArray = template.split("<s_end>");
    			for (String sentenceTemplate : templatesArray) {

    				String message = applyTemplate(sentenceTemplate, slot, language, collectionId, subCollectionId,	spelloutNumbers);

    				message = message.replaceAll(" NGO", " N G O");
    				message = message.replaceAll("PRAKSIS", "Praksis");

    				message = message.trim();
    				if (!message.endsWith(".") && !message.endsWith("!") && !message.endsWith("?")) {
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
    
    private static void addValueToRDFMap(Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, String key, RDFContent value) {
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
    
    private void getSubtemplateValue(Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, String subTemplateId, ULocale language, String valueName, String collectionId) throws WelcomeException {
        
    	String subTemplate = contentClient.getTemplate(collectionId, subTemplateId, language);
    	if (subTemplate != null) {
            RDFContent subTemplateRdf = new RDFContent();
            subTemplateRdf.object = new RDFContent.JsonldGeneric(subTemplate);
            addValueToRDFMap(rdfMap, valueName, subTemplateRdf);
        }
    }
    
    public static Map<String, List<MutablePair<RDFContent, Boolean>>> extractRdfData(List<RDFContent> rdfs) {
    	Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap = new LinkedHashMap<>();
        if (rdfs != null) {
	        for (RDFContent rdf : rdfs) {

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
        return rdfMap;
    }

    public Map<String, List<MutablePair<RDFContent, Boolean>>> extractData(Slot slot, ULocale language, String subCollectionId) throws WelcomeException {
        
        Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap = new HashMap<>();
        rdfMap = extractRdfData(slot.rdf);
        
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
    
    private List<MutablePair<RDFContent, Boolean>> getSpecificLanguageRdfs(List<MutablePair<RDFContent, Boolean>> rdfList, ULocale language) {
    	//get language specific rdf's
		List<MutablePair<RDFContent, Boolean>> languageList = new ArrayList<>();
		if (rdfList.size() > 1) {
			for (MutablePair<RDFContent, Boolean> rdfPair : rdfList) {
				RDFContent rdf = rdfPair.getLeft();
				if (rdf.object != null && rdf.object.language != null 
						&& rdf.object.language.equalsIgnoreCase(language.getISO3Language())) {
					languageList.add(rdfPair);
				}
			}
		}
		//If there are not rdf for the specific language get the English ones
		if (languageList.isEmpty()) {
			for (MutablePair<RDFContent, Boolean> rdfPair : rdfList) {
				RDFContent rdf = rdfPair.getLeft();
				if (rdf.object != null 
						&& ((rdf.object.language != null && rdf.object.language.equalsIgnoreCase(ULocale.ENGLISH.getISO3Language())) 
						|| rdf.object.language == null)) {
					languageList.add(rdfPair);
				}
			}
		}
		return languageList;
    }

    private String applyTemplate(String template, Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, ULocale language, boolean spelloutNumbers) {
        
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
					
					rdfList = getSpecificLanguageRdfs(rdfList, language);
					
					if(!rdfList.isEmpty()) {
						//get one unused rdf
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
        
        Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap = extractData(slot, language, subCollectionId);
        
        String newTemplate = specialCases(slot, rdfMap, language, collectionId);
        if (newTemplate != null) {
        	template = newTemplate;
        }
        
        String text = applyTemplate(template, rdfMap, language, spelloutNumbers);
        return text;
    }
    
    private String getSpecialCasesTemplateId(Slot slot, Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, ULocale language) {
    	String newTemplateId = null;
    	List<MutablePair<RDFContent, Boolean>> rdfResults;
		switch(slot.id) {
			case "frs:informLanguageModuleHours":
			case "frs:informSocietyModuleHours":
				rdfResults = rdfMap.get("dayOfWeek");
				
				if (rdfResults != null && !rdfResults.isEmpty()) {
					rdfResults = getSpecificLanguageRdfs(rdfResults, language);
				}
				
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TInformModuleHoursTwoDays";
				} else {
					newTemplateId = "TInformModuleHoursSingleDay";
				}
				break;
			case "frs:informLanguageModule":
				rdfResults = rdfMap.get("hasCourseName");
				
				if (rdfResults != null && !rdfResults.isEmpty()) {
					rdfResults = getSpecificLanguageRdfs(rdfResults, language);
				}
				
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TInformLanguageModuleTwoCourses";
				} else {
					newTemplateId = "TInformLanguageModuleOneCourse";
				}
				//"hasNumberHours"
				break;
			case "frs:obtainNationality":
				rdfResults = rdfMap.get("IDCountry:hasValue");
				
				if (rdfResults != null && !rdfResults.isEmpty()) {
					rdfResults = getSpecificLanguageRdfs(rdfResults, language);
				}
				
				if (rdfResults != null && rdfResults.size() > 0) {
					newTemplateId = "TObtainNationalityPassportKnown";
				} else {
					newTemplateId = "TObtainNationalityPassportUnknown";
				}
				break;
			case "welcome:obtainRequest":
				rdfResults = rdfMap.get("availableServices:hasValue");
				
				if (rdfResults != null && !rdfResults.isEmpty()) {
					rdfResults = getSpecificLanguageRdfs(rdfResults, language);
				}
				
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TObtainMatterConcernChoice";
				} else {
					newTemplateId = "TObtainMatterConcern";
				}
				break;
			case "pps:informSkypeID":
				rdfResults = rdfMap.get("Language:hasValue");
				
				if (rdfResults != null && !rdfResults.isEmpty()) {
					rdfResults = getSpecificLanguageRdfs(rdfResults, language);
				}
				
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TInformAppCallAccountIDTwoLanguages";
				} else {
					newTemplateId = "TInformAppCallAccountIDOneLanguage";
				}
				break;
			case "schc:informScenarioIntroduction":
			case "schd:informScenarioIntroduction":
			case "hlth:informScenarioIntroduction":
				String defaultTemplate = slot.templateId;
				rdfResults = rdfMap.get("topicName");
				
				if (rdfResults != null && !rdfResults.isEmpty()) {
					rdfResults = getSpecificLanguageRdfs(rdfResults, language);
				}
				
				if (defaultTemplate.equals("TInformSchoolingScenarioIntroductionCARITAS")) {
					if (rdfResults != null && rdfResults.size() < 2) {
						newTemplateId = "TInformSchoolingScenarioIntroductionCARITAS" + rdfResults.size();
					}
				} else if (defaultTemplate.equals("TInformSchoolingScenarioIntroductionDIFE")) {
					if (rdfResults != null && rdfResults.size() < 3) {
						newTemplateId = "TInformSchoolingScenarioIntroductionDIFE" + rdfResults.size();
					}
				} else if (defaultTemplate.equals("TInformHealthScenarioIntroduction")) {
					if (rdfResults != null && rdfResults.size() < 2) {
						newTemplateId = "TInformHealthScenarioIntroduction" + rdfResults.size();
					}
				}
				break;
			case "schc:obtainSubtopic":
			case "schd:obtainSubtopic":
			case "hlth:obtainSubtopic":
				rdfResults = rdfMap.get("topicName");
				
				if (rdfResults != null && !rdfResults.isEmpty()) {
					rdfResults = getSpecificLanguageRdfs(rdfResults, language);
				}
				
				if (rdfResults != null && rdfResults.size() > 1) {
					newTemplateId = "TObtainSubtopicMany";
				} else {
					newTemplateId = "TObtainSubtopicOne";
				}
				break;
			default: 
				break;
		}
		
		return newTemplateId;
	}
    
    private String specialCases(Slot slot, Map<String, List<MutablePair<RDFContent, Boolean>>> rdfMap, ULocale language, String collectionId) throws WelcomeException {
    	String newTemplateId = getSpecialCasesTemplateId(slot, rdfMap, language);
    	
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
