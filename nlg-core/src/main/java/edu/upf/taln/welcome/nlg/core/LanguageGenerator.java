package edu.upf.taln.welcome.nlg.core;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.commons.lang3.tuple.Pair;

import com.ibm.icu.util.ULocale;

import edu.upf.taln.forge.commons.ForgeException;
import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.input.RDFContent;
import edu.upf.taln.welcome.dms.commons.input.Slot;
import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;
import edu.upf.taln.welcome.dms.commons.output.SpeechActLabel;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;
import edu.upf.taln.welcome.nlg.core.forge.ENProto2Configuration;
import edu.upf.taln.welcome.nlg.core.forge.ForgeBasedGenerator;


public class LanguageGenerator {
        
    private final Logger logger = Logger.getLogger(LanguageGenerator.class.getName());

    protected static final String DEFAULT_TEMPLATE_COLLECTION = "UtteranceTemplatesThirdPrototype";
    protected static final String DEFAULT_SUBTEMPLATE_COLLECTION = "ConstantSubtemplatesThirdPrototype";
    protected static final String TTS_TEMPLATE_COLLECTION = "UtteranceTemplatesThirdPrototypeTTS";
    protected static final String TTS_SUBTEMPLATE_COLLECTION = "ConstantSubtemplatesThirdPrototypeTTS";
	
	private CannedGenerator cannedGenerator;
	private BasicTemplateGenerator templateGenerator;
	private ForgeBasedGenerator forgeGenerator;
	
    public static class GenerationResult {
    	ULocale generationLanguage;
        String text;
        List<String> displayStr = new ArrayList<>();
        List<String> ttsStr = new ArrayList<>();
    }
    
    public LanguageGenerator() throws WelcomeException {
		
		cannedGenerator = new CannedGenerator("/canned.json");
		templateGenerator = new BasicTemplateGenerator();
		
        try {
			ENProto2Configuration config = new ENProto2Configuration();
			forgeGenerator = new ForgeBasedGenerator(config);

        } catch (ForgeException  ex) {
			throw new WelcomeException("Forge-based generator initialization failed!", ex);
        }
    }
    
    public LanguageGenerator(String templatesUrl) throws WelcomeException {
		
		cannedGenerator = new CannedGenerator("/canned.json");
		templateGenerator = new BasicTemplateGenerator(templatesUrl);
		
        try {
			ENProto2Configuration config = new ENProto2Configuration();
			forgeGenerator = new ForgeBasedGenerator(config);

        } catch (ForgeException  ex) {
			throw new WelcomeException("Forge-based generator initialization failed!", ex);
        }
    }
    
    protected boolean isSingleTextGeneratableInLanguage(SpeechAct act, ULocale language) throws WelcomeException {
    	if (language == ULocale.ENGLISH) return true;
    	
    	String templateId = null;
		Set<RDFContent> rdfContents = null;
		
    	Slot slot = act.slot;
		if (slot != null) {
			
			templateId = slot.templateId;
			rdfContents = cleanUpSlot(slot);
		}
        
        boolean availableInLanguage;
        if (act.label == SpeechActLabel.Signal_non_understanding ||
				act.label == SpeechActLabel.Apology_No_Extra_Information ||
				act.label == SpeechActLabel.NeedsUpdateAnswer) {
            
        	availableInLanguage = cannedGenerator.isGeneratableInLanguage(act, language);
			
        } else if (templateId == null && (rdfContents == null || rdfContents.isEmpty())) {
        	availableInLanguage = cannedGenerator.isGeneratableInLanguage(act, language);
			
		} else if (templateId != null) {
			List<Pair<String, String>> requiredTemplatesIds = templateGenerator.getRequiredTemplatesIds(slot, DEFAULT_TEMPLATE_COLLECTION, DEFAULT_SUBTEMPLATE_COLLECTION);
			requiredTemplatesIds.addAll(templateGenerator.getRequiredTemplatesIds(slot, TTS_TEMPLATE_COLLECTION, TTS_SUBTEMPLATE_COLLECTION));
			
			boolean allTemplatesForLanguage = true;
			int i = 0;
			while (allTemplatesForLanguage && i < requiredTemplatesIds.size()) {
				Pair<String, String> templateInfo = requiredTemplatesIds.get(i);
				allTemplatesForLanguage = templateGenerator.isLanguageTemplate(templateInfo.getLeft(), language, templateInfo.getRight());
				i++;
			}
			if (!allTemplatesForLanguage) {
				logger.log(Level.WARNING, "There are some missing templates for language: " + language.getDisplayLanguage());
				availableInLanguage = false;
			} else {
				availableInLanguage = true;
			}
			
        } else {
        	logger.log(Level.WARNING, "Forge generation not configured for language: " + language.getDisplayLanguage());
        	availableInLanguage = false;
        }
        
        return availableInLanguage;
    }
    
    protected GenerationResult generateSingleText(SpeechAct act, ULocale language) throws WelcomeException {
		
		String templateId = null;
		Set<RDFContent> rdfContents = null;
		
    	Slot slot = act.slot;
		if (slot != null) {
			
			templateId = slot.templateId;
			rdfContents = cleanUpSlot(slot);
		}
        
        GenerationResult result = new GenerationResult();
        if (act.label == SpeechActLabel.Signal_non_understanding ||
				act.label == SpeechActLabel.Apology_No_Extra_Information ||
				act.label == SpeechActLabel.NeedsUpdateAnswer) {
            
            String text = cannedGenerator.getCannedText(act, language);
            
            result.text = text;
            result.displayStr.add(text);
            result.ttsStr.add(text);
			
        } else if (templateId == null && (rdfContents == null || rdfContents.isEmpty())) {
            String text = cannedGenerator.getCannedText(act, language);
            
            result.text = text;
            result.displayStr.add(text);
            result.ttsStr.add(text);
			
		} else if (templateId != null) {
			/*if (language != ULocale.ENGLISH) {
				List<Pair<String, String>> requiredTemplatesIds = templateGenerator.getRequiredTemplatesIds(slot, DEFAULT_TEMPLATE_COLLECTION, DEFAULT_SUBTEMPLATE_COLLECTION);
				requiredTemplatesIds.addAll(templateGenerator.getRequiredTemplatesIds(slot, TTS_TEMPLATE_COLLECTION, TTS_SUBTEMPLATE_COLLECTION));
				
				boolean allTemplatesForLanguage = true;
				int i = 0;
				while (allTemplatesForLanguage && i < requiredTemplatesIds.size()) {
					Pair<String, String> templateInfo = requiredTemplatesIds.get(i);
					allTemplatesForLanguage = templateGenerator.isLanguageTemplate(templateInfo.getLeft(), language, templateInfo.getRight());
					i++;
				}
				if (!allTemplatesForLanguage) {
					logger.log(Level.INFO, "There are some missing templates for language: " + language.getDisplayLanguage() + ". Changing language to English.");
					language = ULocale.ENGLISH;
				}
			}*/
			
			List<String> display = templateGenerator.getTemplateText(slot, language, DEFAULT_TEMPLATE_COLLECTION, DEFAULT_SUBTEMPLATE_COLLECTION, false);
            result.text = String.join("\n\n", display);
            result.displayStr = display;
            result.ttsStr = templateGenerator.getTemplateText(slot, language, TTS_TEMPLATE_COLLECTION, TTS_SUBTEMPLATE_COLLECTION, true);

        } else {
            String text = forgeGenerator.generate(act, 10, true);

            result.text = text;
            result.displayStr.add(text);
            result.ttsStr.add(text);
        }
        
        result.generationLanguage = language;
        return result;
    }

	private Set<RDFContent> cleanUpSlot(Slot slot) {
		
		Set<RDFContent> rdfContents = null;
		if (slot.rdf != null) {
			Set<RDFContent> rdfToRemove = new HashSet<>();
			rdfContents = new HashSet<RDFContent>(slot.rdf);
			for (RDFContent rdf : rdfContents) {
				if (rdf.id != null && rdf.id.equals("welcome:Unknown")) {
					rdfToRemove.add(rdf);
				}
			}
			
			for (RDFContent rdf : rdfToRemove) {
				rdfContents.remove(rdf);
			}
		}
		return rdfContents;
	}

    public Pair<GenerationOutput, ULocale> generate(DialogueMove move, ULocale language) throws WelcomeException {
        
    	List<String> texts = new ArrayList<>();
    	List<String> displayChunks = new ArrayList<>();
        List<String> chunks = new ArrayList<>();
        
        boolean allSentencesGeneratableInLanguage = true;
        int i = 0;
        while (allSentencesGeneratableInLanguage && i < move.speechActs.size()) {
        	SpeechAct act = move.speechActs.get(i);
        	allSentencesGeneratableInLanguage = isSingleTextGeneratableInLanguage(act, language);
        	i++;
        }
        if (!allSentencesGeneratableInLanguage) {
        	logger.log(Level.WARNING, "Some sentences cannot be generated in " + language.getDisplayLanguage() + ". Changing language to English.");
			language = ULocale.ENGLISH;
        }
        
        for (SpeechAct act: move.speechActs) {
            
        	//List<String> sentences = new ArrayList<>();
			// TODO: Collect forge-generable slots to send them grouped!
			
            GenerationResult result = generateSingleText(act, language);
        	texts.add(result.text);
        	displayChunks.addAll(result.displayStr);
            chunks.addAll(result.ttsStr);
        }

        GenerationOutput output = new GenerationOutput();
        output.setText(String.join("\n\n", texts));
        output.setDisplayChunks(displayChunks);
        output.setChunks(chunks);
        output.setChunkType(GenerationOutput.ChunkType.Slot);
        
    	return Pair.of(output, language);
    }
}
