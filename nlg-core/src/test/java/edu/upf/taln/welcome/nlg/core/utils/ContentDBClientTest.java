package edu.upf.taln.welcome.nlg.core.utils;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.mockito.Mockito;

import static org.mockito.Mockito.when;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;


/**
 *
 * @author rcarlini
 */
public class ContentDBClientTest {

    private static final String CONTENTDB_URL = "https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections";

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
        expResult.add("It is very important, that you are in a place with very good internet connection, because you will need to do a video call so the <hasTranslation><welcome:ServiceName:hasValue> can make a picture of you.");
        
        List<String> result = instance.getTemplate(collection, term, language);
        assertEquals(expResult, result);
    }
    
    @ParameterizedTest(name = "{0}")
	@CsvSource({ 
		"NotFound,404,'Error on template retrieval. ContentDB failed with code 404. URL: " + CONTENTDB_URL + "'", 
		"Timeout,408,'Error on template retrieval. ContentDB failed with code 408. Request timeout.'", 
		"NotAvailable,503,'Error on template retrieval. ContentDB failed with code 503. Service unavailable.'", 
		"InternalServerError,500,'Error on template retrieval. ContentDB failed with code 500. For query: collection=foo, term=foo, language=foo.'"
	})
    public void ResponseHttpErrorsTest(String testName, int status, String expectedExceptionMessage) throws Exception {
        
    	WelcomeException exception = Assertions.assertThrows(WelcomeException.class, () -> {
    		
    		//Mocking the response (Needed for response.readEntity(String.class) to work)
    		Response mockResponse = Mockito.mock(Response.class);
    		when(mockResponse.getStatus()).thenReturn(status);
    		when(mockResponse.readEntity(String.class)).thenReturn("Mocked response");
    		
    		//Stubbing a client spy to return the mocked response
	    	ContentDBClient spy = Mockito.spy(new ContentDBClient(CONTENTDB_URL));
	    	when(spy.serviceCall("foo", "foo", "foo"))
	    		.thenReturn(mockResponse);
	    	
	    	List<String> list = spy.getTemplate("foo", "foo", "foo");
	    	System.out.println(String.join(" ", list));
	    	
    	});
    	
    	assertEquals(expectedExceptionMessage, exception.getMessage());
    }
    
}
