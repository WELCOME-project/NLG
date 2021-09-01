package edu.upf.taln.welcome.nlg.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;

import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.dms.commons.utils.JsonLDUtils;
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
    
    public void testSample(File inputFile) throws Exception {
        
        ObjectMapper mapper = new ObjectMapper();
        JsonNode input = mapper.readValue(inputFile, JsonNode.class);

        NLGService instance = new NLGService();
        GenerationOutput output = instance.generate(input);
        
        ObjectWriter writer = mapper
                .configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, true)
                .writerWithDefaultPrettyPrinter();
        
        String expResult = null;
        String[] nameParts = inputFile.getName().split("\\.");
		if (nameParts.length == 2) {
			File expectedFile = new File(inputFile.getParent() + "/" + nameParts[0] + "_output.json");
			if (!expectedFile.exists()) {
				writer.writeValue(expectedFile, output);        
			}
			expResult = FileUtils.readFileToString(expectedFile, "utf-8");
	        
		}
		
		String result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(output);
		System.out.println(result);
		
		assertEquals(expResult, result);
    }

    /*@Test
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
    }*/
    
    @Test
    public void testDtasfProto1() throws Exception {
        String baseDir = "src/test/resources/proto1/dtasf/";
        
        File folder = new File(baseDir);
        for (final File fileEntry : folder.listFiles()) {
            if (!fileEntry.isDirectory() && fileEntry.getName().endsWith("_Move.json")) {
            	testSample(fileEntry);
            }
        }
    }
    
    @Test
    public void testPraksisProto1() throws Exception {
        String baseDir = "src/test/resources/proto1/praksis/";
        
        File folder = new File(baseDir);
        for (final File fileEntry : folder.listFiles()) {
            if (!fileEntry.isDirectory() && fileEntry.getName().endsWith("_Move.json")) {
            	testSample(fileEntry);
            }
        }
    }
    
    @Test
    public void testCaritasProto1() throws Exception {
        String baseDir = "src/test/resources/proto1/caritas/";
        
        File folder = new File(baseDir);
        for (final File fileEntry : folder.listFiles()) {
            if (!fileEntry.isDirectory() && fileEntry.getName().endsWith("_Move.json")) {
            	testSample(fileEntry);
            }
        }
    }
    
    //@Test
    public void testLoadMove() throws Exception {
        
        File inputFile = new File("src/test/resources/proto1/Opening_Move.json");
        File contextFile = new File("src/test/resources/welcome-nlg-context.jsonld");
        ObjectMapper mapper = new ObjectMapper();
        JsonNode input = mapper.readValue(inputFile, JsonNode.class);

        DialogueMove move = JsonLDUtils.readMove(input, contextFile.toURI().toURL());
        String moveStr = mapper.writeValueAsString(move);
        System.out.println(moveStr);
    }
}
