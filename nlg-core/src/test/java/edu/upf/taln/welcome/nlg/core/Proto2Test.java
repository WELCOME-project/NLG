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
public class Proto2Test {

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
        String jsonldPath = "src/test/resources/proto2/sample.json";
        String textOutput = "Thank you. Here is a pre-filled form using the data you entered during your registration to :AppName:hasValue:.\n\nPlease keep in mind that this pre-filled form doesn't replace the online full-registration procedure that you must complete through the official website of the :Country:hasValue: Asylum Service (:webURL:).";
        List<String> ttsOutput = new ArrayList<>();
		ttsOutput.add("Thank you. Here is a pre-filled form using the data you entered during your registration to :AppName:hasValue:.");
		ttsOutput.add("Please keep in mind that this pre-filled form doesn't replace the online full-registration procedure that you must complete through the official website of the :Country:hasValue: Asylum Service.");
		ttsOutput.add("You can see the link on the screen.");
        
        generate(jsonldPath, textOutput, ttsOutput);
    }
	
    @Test
    public void testSayYesNo() throws Exception {
        String jsonldPath = "src/test/resources/proto2/yes_no_question.json";
        String textOutput = "Please, say \"yes\" or \"no\".\n\nIs it clear?";
        List<String> ttsOutput = new ArrayList<>();
		ttsOutput.add("Please, say \"yes\" or \"no\".");
		ttsOutput.add("Is it clear?");
        
        generate(jsonldPath, textOutput, ttsOutput);
    }
    
    @Test
    public void testNeedsUpdate() throws Exception {
        String jsonldPath = "src/test/resources/proto2/NeedsUpdate-Original_Move.json";
        String textOutput = "Please give me your email.\n\nCurrently I have stored testuser@example.com. Would you like to update it?";
        List<String> ttsOutput = new ArrayList<>();
        ttsOutput.add("Please give me your email.");
		ttsOutput.add("Currently I have stored testuser@example.com. Would you like to update it?");
        
        generate(jsonldPath, textOutput, ttsOutput);
    }
}
