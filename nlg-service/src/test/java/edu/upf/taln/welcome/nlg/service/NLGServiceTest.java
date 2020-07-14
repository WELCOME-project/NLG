package edu.upf.taln.welcome.nlg.service;

import java.io.File;

import org.junit.Test;
import static org.junit.Assert.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.FileUtils;

import edu.upf.taln.welcome.dms.commons.output.DMOutput;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;

/**
 *
 * @author rcarlini
 * 
 * https://docs.google.com/document/d/12Avaok_aItg4wgZuPvclnNt4Ngx1k-1NE-CLGGmiMuw/edit?pli=1
 * 
 */
public class NLGServiceTest {
    
    public void testSample(File inputFile, File expectedFile) throws Exception {
        
        ObjectMapper mapper = new ObjectMapper();
        DMOutput input = mapper.readValue(inputFile, DMOutput.class);
        
        NLGService instance = new NLGService();
        
        String expected = FileUtils.readFileToString(expectedFile, "utf-8");
        GenerationOutput output = instance.generate(input);
        String result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(output);
        assertEquals(expected, result);
    }

    @Test
    public void testSampleInitialExtrapolateTurn() throws Exception {
        
        File inputFile0 = new File("src/test/resources/initial/turn0_input.json");
        File expectedFile0= new File("src/test/resources/initial/turn0_output.json");
        testSample(inputFile0, expectedFile0);

        File inputFile1 = new File("src/test/resources/initial/turn1_input.json");
        File expectedFile1 = new File("src/test/resources/initial/turn1_output.json");
        testSample(inputFile1, expectedFile1);


        File inputFile2 = new File("src/test/resources/initial/turn2_input.json");
        File expectedFile2 = new File("src/test/resources/initial/turn2_output.json");
        testSample(inputFile2, expectedFile2);

        File inputFile3 = new File("src/test/resources/initial/turn3_input.json");
        File expectedFile3 = new File("src/test/resources/initial/turn3_output.json");
        testSample(inputFile3, expectedFile3);
    }
    
}
