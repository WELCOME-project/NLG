package edu.upf.taln.welcome.nlg.service;

import java.io.File;
import java.io.FilenameFilter;
import java.util.Arrays;
import java.util.stream.Stream;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.AndFileFilter;
import org.apache.commons.io.filefilter.FileFileFilter;
import org.apache.commons.io.filefilter.IOFileFilter;
import org.apache.commons.io.filefilter.SuffixFileFilter;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.databind.SerializationFeature;

import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;

import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;
import org.apache.commons.io.FilenameUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;


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
    
    public void testMove(File inputFile) throws Exception {
        
        boolean overrideExpected = false;
        String baseName = FilenameUtils.getBaseName(inputFile.getName());
        
        ObjectMapper mapper = new ObjectMapper();
        JsonNode input = mapper.readValue(inputFile, JsonNode.class);

        NLGService instance = new NLGService();
        GenerationOutput output = instance.generate(input);
        
        File expectedFile = new File(inputFile.getParent(), baseName + "_output.json");
        if (!expectedFile.exists() || overrideExpected) {
            writer.writeValue(expectedFile, output);        
        }
        String expResult = FileUtils.readFileToString(expectedFile, "utf-8");
		
		String result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(output);
		System.out.println(result);
		
		Assertions.assertEquals(expResult, result, "Actual and expected doesn't match in " + expectedFile.getPath());
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

}
