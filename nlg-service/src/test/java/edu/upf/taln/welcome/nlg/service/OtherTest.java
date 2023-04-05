package edu.upf.taln.welcome.nlg.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MultivaluedHashMap;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;


/**
 *
 * @author rcarlini
 * 
 * https://docs.google.com/document/d/12Avaok_aItg4wgZuPvclnNt4Ngx1k-1NE-CLGGmiMuw/edit?pli=1
 * 
 */
public class OtherTest {
    
	private final ObjectWriter writer = new ObjectMapper()
            .configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, true)
            .writerWithDefaultPrettyPrinter();
    
	private void error_management(Response response) throws WelcomeException {
        String responseStr = response.readEntity(String.class);
        ObjectMapper om = new ObjectMapper()
        		.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        if (response.getStatus() == Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()) {

        	WelcomeException we;
            try {
            	we = om.readValue(responseStr, WelcomeException.class);
            } catch (Exception e) {
                try {
                    Exception newEx = om.readValue(responseStr, Exception.class);
                    we = new WelcomeException(newEx.getMessage(), newEx);

                } catch (IOException e1) {
                    throw new WelcomeException("" + response.getStatus());
                }
            }
            throw we;
        } else {
            throw new WelcomeException("" + response.getStatus());
        }
    }
	
    public void testMove(File inputFile, String language) throws Exception {
        
        boolean overrideExpected = false;
        String baseName = FilenameUtils.getBaseName(inputFile.getName());
        
        ObjectMapper mapper = new ObjectMapper();
        JsonNode input = mapper.readValue(inputFile, JsonNode.class);

        //Creating headers mock up
        HttpHeaders httpHeaders = Mockito.mock(HttpHeaders.class);
        MultivaluedMap<String, String> headers = new MultivaluedHashMap<String, String>();
        headers.putSingle("X-Language", language);
        Mockito.when(httpHeaders.getRequestHeaders()).thenReturn(headers);
        Mockito.when(httpHeaders.getRequestHeader("X-Language")).thenReturn(new ArrayList<>(Arrays.asList(new String[] {language})));
        
        NLGService instance = new NLGService();
        Response response = instance.generate(httpHeaders, input);
        
        if (response.getStatus() == Response.Status.OK.getStatusCode()) {
        	GenerationOutput output = (GenerationOutput) response.getEntity();
        
	        File expectedFile = new File(inputFile.getParent(), baseName + "_output.json");
	        if (!expectedFile.exists() || overrideExpected) {
	            writer.writeValue(expectedFile, output);        
	        }
	        String expResult = FileUtils.readFileToString(expectedFile, "utf-8");
			
			String result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(output);
			System.out.println(result);
			
			Assertions.assertEquals(expResult, result, "Actual and expected doesn't match in " + expectedFile.getPath());
        } else {
        	error_management(response);
        }
    }
    
    @BeforeEach
    public void resetCounters() {
        DialogueMove.resetCounter();
        SpeechAct.resetCounter();        
    }

	@Test
    public void test() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/ConfirmationRequest_pending_Move.json");
		
        testMove(jsonLDInput, "eng");
    }
	
	@Test
    public void languageRdf() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/languageTag_Move.json");
		
        testMove(jsonLDInput, "ell");
    }
	
	@Test
    public void languageRdfES() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/nlg_input_multilang_Move.json");
		
        testMove(jsonLDInput, "spa");
    }
	
	@Test
    public void testMultiTemplateWithMultiLanguages() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/nlg_input_multilang_wrong_number_Move.json");
		
        testMove(jsonLDInput, "cat");
    }
	
	@Test
    public void testFailedAnalysis() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/FailedAnalysis_Move.json");
		
        testMove(jsonLDInput, "eng");
    }
	
	@Test
    public void testPreviousSlotFailed() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/PreviousSlotFailed_Move.json");
		
        testMove(jsonLDInput, "eng");
    }
	
	@Test
    public void testHasAllowedValues() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/HasAllowedValues_Move.json");
		
        testMove(jsonLDInput, "eng");
    }
	
	@Test
    public void testHasLanguageRdf_Yes() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/HasLanguageRdf_Yes_Move.json");
		
        testMove(jsonLDInput, "cat");
    }
	
	@Test
    public void testHasLanguageRdf_No1() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/HasLanguageRdf_No1_Move.json");
		
        testMove(jsonLDInput, "cat");
    }
	
	@Test
    public void testHasLanguageRdf_No2() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/HasLanguageRdf_No2_Move.json");
		
        testMove(jsonLDInput, "cat");
    }
	
	@Test
    public void testHasLanguageRdf_NoTranslation() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/HasLanguageRdf_NoTranslate_Move.json");
		
        testMove(jsonLDInput, "cat");
    }
	
	@Test
    public void testNoGreekTemplate() throws Exception {
		File jsonLDInput = new File("src/test/resources/other/NoGreekTemplate_Move.json");
		
        testMove(jsonLDInput, "ell");
    }
}
