package edu.upf.taln.welcome.nlg.core.utils;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author rcarlini
 */
public class ContentDBClientTest {

    private static String CONTENTDB_URL = "https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections";

    /**
     * Test of getTemplate method, of class ContentDBClient.
     */
    @Test
    public void testGetTemplate() throws Exception {
        
        System.out.println("getTemplate");
        
        String collection = "UtteranceTemplatesFirstPrototype";
        String term = "TInformConnection";
        String language = "en";
        ContentDBClient instance = new ContentDBClient(CONTENTDB_URL);
        
        List<String> expResult = new ArrayList<>();
        expResult.add("It is very important, that you are in a place with very good internet connection, because you will need to do a video call so the <set><ServiceName> can make a picture of you.");
        
        List<String> result = instance.getTemplate(collection, term, language);
        assertEquals(expResult, result);
    }
    
}
