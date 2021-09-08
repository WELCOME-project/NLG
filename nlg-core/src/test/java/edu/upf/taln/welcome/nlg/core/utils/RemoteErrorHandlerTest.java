package edu.upf.taln.welcome.nlg.core.utils;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.core.Response;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.mockito.Mockito;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;

public class RemoteErrorHandlerTest {
    
    @ParameterizedTest(name = "{0}")
	@CsvSource({ 
		"MatchingError,404,'Not found',",
		"DefaultError,500,'500: Mocked response',",
		"MessageWithParameter,400,'400: Bad request','Bad request'"
	})
    public void ResponseHttpErrorsTest(String testName, int status, String expectedExceptionMessage, String messageParam) throws Exception {
        
    	RemoteErrorHandler errorHandler;
    	
    	Map<Response.Status, String> error2msg = new HashMap<>();
        error2msg.put(Response.Status.NOT_FOUND,   "Not found");
        error2msg.put(Response.Status.BAD_REQUEST, "{status}: {testParam}");
    	errorHandler = new RemoteErrorHandler(error2msg, new HashMap<>(), "{status}: {response}") ;
    	
		//Mocking the response
		Response mockResponse = Mockito.mock(Response.class);
		when(mockResponse.getStatus()).thenReturn(status);
		when(mockResponse.readEntity(String.class)).thenReturn("Mocked response");
    	
		Map<String, String> values = new HashMap<>();
		if (messageParam != null) {
			values.put("testParam", messageParam);
		}
    	WelcomeException exception = errorHandler.transformError(mockResponse, values);

    	assertEquals(expectedExceptionMessage, exception.getMessage());
    }
    
    @ParameterizedTest(name = "{0}")
	@CsvSource({ 
		"ConstructorValue,404,'Error in Test',Test",
	})
    public void ConstructorMessageValuesTest(String testName, int status, String expectedExceptionMessage, String messageParam) throws Exception {
        
    	RemoteErrorHandler errorHandler;
    	
    	Map<String, String> valueMap = new HashMap<>();
        valueMap.put("projectName", messageParam);
    	errorHandler = new RemoteErrorHandler(new HashMap<>(), valueMap, "Error in {projectName}") ;
    	
		//Mocking the response
		Response mockResponse = Mockito.mock(Response.class);
		when(mockResponse.getStatus()).thenReturn(status);
		when(mockResponse.readEntity(String.class)).thenReturn("Mocked response");
    	
    	WelcomeException exception = errorHandler.transformError(mockResponse);

    	assertEquals(expectedExceptionMessage, exception.getMessage());
    }
    
}
