package edu.upf.taln.welcome.nlg.core;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

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

    protected static final String DEFAULT_TEMPLATE_COLLECTION = "UtteranceTemplatesSecondPrototype";
    protected static final String DEFAULT_SUBTEMPLATE_COLLECTION = "ConstantSubtemplatesSecondPrototype";
    protected static final String TTS_TEMPLATE_COLLECTION = "UtteranceTemplatesSecondPrototypeTTS";
    protected static final String TTS_SUBTEMPLATE_COLLECTION = "ConstantSubtemplatesSecondPrototypeTTS";
	
	private CannedGenerator cannedGenerator;
	private BasicTemplateGenerator templateGenerator;
	private ForgeBasedGenerator forgeGenerator;
	
    public static class GenerationResult {
        String text;
        String ttsStr;
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
				act.label == SpeechActLabel.Apology_No_Extra_Information) {
            
            String text = cannedGenerator.getCannedText(act, language);
            
            result.text = text;
            result.ttsStr = text;
			
        } else if (templateId == null && (rdfContents == null || rdfContents.isEmpty())) {
            String text = cannedGenerator.getCannedText(act, language);
            
            result.text = text;
            result.ttsStr = text;
			
		} else if (templateId != null) {
            result.text = templateGenerator.getTemplateText(act, language, DEFAULT_TEMPLATE_COLLECTION, DEFAULT_SUBTEMPLATE_COLLECTION, false);
            result.ttsStr = templateGenerator.getTemplateText(act, language, TTS_TEMPLATE_COLLECTION, TTS_SUBTEMPLATE_COLLECTION, true);

        } else {
            String text = forgeGenerator.generate(act, 10, true);

            result.text = text;
            result.ttsStr = text;
        }
        return result;
}

	private Set<RDFContent> cleanUpSlot(Slot slot) {
		
		Set<RDFContent> rdfContents = null;
		if (slot.rdf != null) {
			rdfContents = new HashSet(slot.rdf);
			for (RDFContent rdf : rdfContents) {
				if (rdf.id != null && rdf.id.equals("welcome:Unknown")) {
					rdfContents.remove(rdf);
				}
			}
		}
		return rdfContents;
	}

    public GenerationOutput generate(DialogueMove move, ULocale language) throws WelcomeException {
        
    	List<String> texts = new ArrayList<>();
        List<String> chunks = new ArrayList<>();
        for (SpeechAct act: move.speechActs) {
            
			// TODO: Collect forge-generable slots to send them grouped!
			
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
}
