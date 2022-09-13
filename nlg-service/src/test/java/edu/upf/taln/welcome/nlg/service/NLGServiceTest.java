package edu.upf.taln.welcome.nlg.service;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Stream;

import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MultivaluedHashMap;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.filefilter.AndFileFilter;
import org.apache.commons.io.filefilter.FileFileFilter;
import org.apache.commons.io.filefilter.IOFileFilter;
import org.apache.commons.io.filefilter.SuffixFileFilter;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
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
public class NLGServiceTest {
    
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
    
    public void testMove(File inputFile) throws Exception {
        
        boolean overrideExpected = false;
        String baseName = FilenameUtils.getBaseName(inputFile.getName());
        
        ObjectMapper mapper = new ObjectMapper();
        JsonNode input = mapper.readValue(inputFile, JsonNode.class);

        //Creating headers mock up
        HttpHeaders httpHeaders = Mockito.mock(HttpHeaders.class);
        MultivaluedMap<String, String> headers = new MultivaluedHashMap<String, String>();
        headers.putSingle("X-Language", "eng");
        Mockito.when(httpHeaders.getRequestHeaders()).thenReturn(headers);
        Mockito.when(httpHeaders.getRequestHeader("X-Language")).thenReturn(new ArrayList<>(Arrays.asList(new String[] {"eng"})));
        
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

    static File[] getDirectoryInputs(String baseDir) {
        
        File folder = new File(baseDir);
        
        IOFileFilter filterFile = FileFileFilter.FILE;
        SuffixFileFilter filterSuffix = new SuffixFileFilter("_Move.json");
        FilenameFilter filter = new AndFileFilter(filterFile, filterSuffix);

        File[] fileList = folder.listFiles(filter);
        Arrays.sort(fileList);
        
        return fileList;
    }
    
    static Stream<File> proto1DtasfInputs() {
        String baseDir = "src/test/resources/proto1/dtasf/";
        File[] fileList = getDirectoryInputs(baseDir);
        
        return Stream.of(fileList);
    }
    
    static Stream<File> proto1PraksisInputs() {
        String baseDir = "src/test/resources/proto1/praksis/";
        File[] fileList = getDirectoryInputs(baseDir);
        
        return Stream.of(fileList);
    }
    
    static Stream<File> proto1CaritasInputs() {
        String baseDir = "src/test/resources/proto1/caritas/";
        File[] fileList = getDirectoryInputs(baseDir);
        
        return Stream.of(fileList);
    }
    
    @BeforeEach
    public void resetCounters() {
        DialogueMove.resetCounter();
        SpeechAct.resetCounter();        
    }
    
    @DisplayName("DTASF inputs separate tests")
    @ParameterizedTest(name = "{0}")
    @MethodSource("proto1DtasfInputs")
    public void testDtasfPrototype1(File jsonLDInput) throws Exception {
        testMove(jsonLDInput);
    }
    
    @DisplayName("Praksis inputs tests")
    @ParameterizedTest(name = "{0}")
    @MethodSource("proto1PraksisInputs")
    public void testPraksisPrototype1(File jsonLDInput) throws Exception {
        testMove(jsonLDInput);
    }
    
    @DisplayName("Caritas inputs tests")
    @ParameterizedTest(name = "{0}")
    @MethodSource("proto1CaritasInputs")
    public void testCaritasPrototype1(File jsonLDInput) throws Exception {
        testMove(jsonLDInput);
    }
    
	@Test
    public void testAgreeSpeechActPrototype1() throws Exception {
		File jsonLDInput = new File("src/test/resources/proto1/input_to_nlg.txt");
		
        testMove(jsonLDInput);
    }
    
	@Test
    public void testElaboratePrototype1() throws Exception {
		File jsonLDInput = new File("src/test/resources/proto1/input_to_nlg_elaborate_move.json");
		
        testMove(jsonLDInput);
    }
    
	@Test
    public void testError400Prototype1() throws Exception {
		File jsonLDInput = new File("src/test/resources/proto1/error_400.json");
		
        testMove(jsonLDInput);
    }

	@Test
    public void testHoursPrototype1() throws Exception {
		File jsonLDInput = new File("src/test/resources/proto1/dtasf/InformFirstReceptionService_informLanguageModuleHours_Move.json");
		
        testMove(jsonLDInput);
    }

	@Test
    public void testSkypeIdPrototype1() throws Exception {
		File jsonLDInput = new File("src/test/resources/proto1/praksis/InformSkypeUser_informSkypeID_oneLanguage_Move.json");
		
        testMove(jsonLDInput);
    }
}
