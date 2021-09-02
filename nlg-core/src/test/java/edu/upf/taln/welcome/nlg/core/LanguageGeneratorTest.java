package edu.upf.taln.welcome.nlg.core;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.File;
import java.io.IOException;

import org.junit.jupiter.api.Test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.input.Slot;
import edu.upf.taln.welcome.dms.commons.output.DialogueMove;

/**
 *
 * @author rcarlini
 */
public class LanguageGeneratorTest {

    /**
     * Test of generate method, of class LanguageGenerator.
     */
    @Test
    public void testGenerate() throws WelcomeException, IOException {
        System.out.println("generate");
        
        File inputFile = new File("src/test/resources/proto1/Opening_Move.json");
        
        ObjectMapper mapper = new ObjectMapper();
        DialogueMove move = mapper.readValue(inputFile, DialogueMove.class);
        
        LanguageGenerator generator = new LanguageGenerator();
        String result = generator.generate(move, ULocale.ENGLISH);
        
        String expResult = "Can you see me?\nCan you hear me?";
        assertEquals(expResult, result);
    }
    
    @Test
    public void testApplyTemplate() throws WelcomeException, IOException {
        String template = "Do you want me to inform you on the <hasTranslation><welcome:ServiceName:hasValue>?";
        File inputFile = new File("src/test/resources/proto1/ProposeService_Move.json");

        ObjectMapper mapper = new ObjectMapper();
        DialogueMove move = mapper.readValue(inputFile, DialogueMove.class);
        Slot slot = move.speechActs.get(0).slot;

        LanguageGenerator generator = new LanguageGenerator();
        String result = generator.applyTemplate(template, slot, ULocale.UK);
        
        assertEquals("Do you want me to inform you on the First Reception Service in Catalonia?", result);
    }
    
}
