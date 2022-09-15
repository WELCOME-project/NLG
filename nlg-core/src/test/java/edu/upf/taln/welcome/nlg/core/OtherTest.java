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
public class OtherTest {

    public void generate(String jsonldPath, String textOutput, List<String> ttsOutput) throws Exception {
        
        File inputFile = new File(jsonldPath);

        ObjectMapper mapper = new ObjectMapper();
        DialogueMove move = mapper.readValue(inputFile, DialogueMove.class);
        
        LanguageGenerator generator = new LanguageGenerator();
        Pair<GenerationOutput, ULocale> result = generator.generate(move, new ULocale("ell"));
        
        assertEquals(textOutput, result.getLeft().getText());
        assertEquals(ttsOutput, result.getLeft().getChunks());
    }
    
    @Test
    public void languageRdfs() throws Exception {
        String jsonldPath = "src/test/resources/other/languageTag_Move.json";
        String textOutput = "Μιλάτε Ελληνικά, σωστά;.";
        List<String> ttsOutput = new ArrayList<>();
        ttsOutput.add("Μιλάτε Ελληνικά. Είναι σωστό?");
        
        generate(jsonldPath, textOutput, ttsOutput);
    }
}
