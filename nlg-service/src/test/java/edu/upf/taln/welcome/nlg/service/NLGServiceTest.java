package edu.upf.taln.welcome.nlg.service;

import java.io.File;

import org.junit.Test;
import static org.junit.Assert.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.FileUtils;

import edu.upf.taln.welcome.dms.commons.output.DMOutput;

/**
 *
 * @author rcarlini
 * 
 * https://docs.google.com/document/d/12Avaok_aItg4wgZuPvclnNt4Ngx1k-1NE-CLGGmiMuw/edit?pli=1
 * 
 */
public class NLGServiceTest {
    
    @Test
    public void testSample(DMOutput input, File expected) throws Exception {
        
        ObjectMapper mapper = new ObjectMapper();
        NLGService instance = new NLGService();
        
        System.out.println("realize_next_turn");
        String expResult = FileUtils.readFileToString(expected, "utf-8");
        DMOutput output = instance.analyze(input);
        String result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(output);
        assertEquals(expResult, result);
    }    
}
