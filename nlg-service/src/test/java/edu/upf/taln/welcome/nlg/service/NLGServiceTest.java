package edu.upf.taln.welcome.nlg.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.FileUtils;
import org.junit.Test;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;

import java.io.File;

import static org.junit.Assert.assertEquals;

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
        JsonNode input = mapper.readValue(inputFile, JsonNode.class);

        NLGService instance = new NLGService();
        GenerationOutput output = instance.generate(input);
        String result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(output);

        String expected = FileUtils.readFileToString(expectedFile, "utf-8");
        assertEquals(expected, result);
    }

    @Test
    public void testSampleInitialExtrapolateTurn() throws Exception {
        
        File inputFile0 = new File("src/test/resources/OpeningDIP_input.jsonld");
        File expectedFile0= new File("src/test/resources/OpeningDIP_output.json");
        testSample(inputFile0, expectedFile0);

        File inputFile1 = new File("src/test/resources/ObtainRegistrationStatus_input.jsonld");
        File expectedFile1 = new File("src/test/resources/ObtainRegistrationStatus_output.json");
        testSample(inputFile1, expectedFile1);

        File inputFile2 = new File("src/test/resources/ProposeService_input.jsonld");
        File expectedFile2 = new File("src/test/resources/ProposeService_output.json");
        testSample(inputFile2, expectedFile2);
//
//        File inputFile3 = new File("src/test/resources/initial/turn3_input.json");
//        File expectedFile3 = new File("src/test/resources/initial/turn3_output.json");
//        testSample(inputFile3, expectedFile3);
    }
    
}
