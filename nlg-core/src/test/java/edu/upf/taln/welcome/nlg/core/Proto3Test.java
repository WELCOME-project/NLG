package edu.upf.taln.welcome.nlg.core;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.File;

import org.apache.commons.lang3.tuple.Pair;
import org.junit.jupiter.api.Test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author rcarlini
 */
public class Proto3Test {

    public void generate(String jsonldPath, String textOutput, List<String> ttsOutput) throws Exception {
        
        File inputFile = new File(jsonldPath);

        ObjectMapper mapper = new ObjectMapper();
        DialogueMove move = mapper.readValue(inputFile, DialogueMove.class);
        
        LanguageGenerator generator = new LanguageGenerator();
        Pair<GenerationOutput, ULocale> result = generator.generate(move, ULocale.ENGLISH);
        
        assertEquals(textOutput, result.getLeft().getText());
        assertEquals(ttsOutput, result.getLeft().getChunks());
    }
    
    @Test
    public void testSample() throws Exception {
        String jsonldPath = "src/test/resources/proto3/test1.json";
        String textOutput = "How can I help you?";
        List<String> ttsOutput = new ArrayList<>();
		ttsOutput.add("How can I help you?");
        
        generate(jsonldPath, textOutput, ttsOutput);
    }
    
    @Test
    public void testS8Schooling1Topic() throws Exception {
        String jsonldPath = "src/test/resources/proto3/s8CARITAS_schoolingTopic_1_Move.json";
        String textOutput = "I can also tell you how to recognize school degrees.\n\nDo you want to know more about this topic?";
        List<String> ttsOutput = new ArrayList<>();
		ttsOutput.add("I can also tell you how to recognize school degrees.");
		ttsOutput.add("Do you want to know more about this topic?");
		
        generate(jsonldPath, textOutput, ttsOutput);
    }
    
    @Test
    public void testS8Schooling2Topic() throws Exception {
        String jsonldPath = "src/test/resources/proto3/s8CARITAS_schoolingTopic_2_Move.json";
        String textOutput = "I can provide you with information on how to recognize school degrees and university diplomas.\n\nDo you want to know more about these topics? If so, please tell me which.";
        List<String> ttsOutput = new ArrayList<>();
		ttsOutput.add("I can provide you with information on how to recognize school degrees and university diplomas.");
		ttsOutput.add("Do you want to know more about this topic?");
		
        generate(jsonldPath, textOutput, ttsOutput);
    }
}
