package edu.upf.taln.welcome.nlg.core;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.File;
import java.util.List;

import org.junit.jupiter.api.Test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.output.DialogueMove;

/**
 *
 * @author rcarlini
 */
public class Proto1Test {

    public void generate(String jsonldPath, String expResult) throws Exception {
        
        File inputFile = new File(jsonldPath);

        ObjectMapper mapper = new ObjectMapper();
        DialogueMove move = mapper.readValue(inputFile, DialogueMove.class);
        
        LanguageGenerator generator = new LanguageGenerator();
		List<String> sentences = generator.generate(move, ULocale.ENGLISH);
		String result = String.join(" ", sentences);
        
        assertEquals(expResult, result);
    }
    
    @Test
    public void testOpening() throws Exception {
        String jsonldPath = "src/test/resources/proto1/Opening_Move.json";
        String expResult = "Can you see me?\nCan you hear me?";
        
        generate(jsonldPath, expResult);
    }
//    
//    @Test
//    public void testModifiedRegistration() throws Exception {
//        String jsonldPath = "src/test/resources/proto1/ModifiedRegistrationStatus.jsonld";
//        String expResult = "";
//        
//        generate(jsonldPath, expResult);
//    }
    
    @Test
    public void testProposeService() throws Exception {
        String jsonldPath = "src/test/resources/proto1/ProposeService_Move.json";
        String expResult = "Do you want me to inform you on the First Reception Service in Catalonia?";
        
        generate(jsonldPath, expResult);
    }
}