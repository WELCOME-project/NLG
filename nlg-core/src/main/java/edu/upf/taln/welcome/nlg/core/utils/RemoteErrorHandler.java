package edu.upf.taln.welcome.nlg.core.utils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import javax.ws.rs.core.Response;

import org.apache.commons.text.StringSubstitutor;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;

class RemoteErrorHandler {

	private static final Logger logger = Logger.getLogger(RemoteErrorHandler.class.getSimpleName());
	
    private static ObjectMapper om = new ObjectMapper()
                .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

    private final Map<Response.Status, String> error2msg = new HashMap<>();
    private final Map<String, String> values = new HashMap<>();
    private String defaultMessage = "Remote response error! No default or specific message found for HTTP error code {status}.";
    
    /**
     * Rest response error handler. Uses the input messageMap to map http error codes to messages.
     * Messages can have placeholders in curly braces format ({status}) that will be replaced
     * using the values map. By default, 'status' and 'response' values are retrieved from the
     * response and available as values.
     * 
     * @param messageMap HTTP error code to message map.
     * @param valueMap Placeholder values map.
     * @param defaultMessage Default message, used if no entry for an error code is found.
     */
    public RemoteErrorHandler(Map<Response.Status, String> messageMap, Map<String, String> valueMap, String defaultMessage) {
        this.error2msg.putAll(messageMap);
        this.values.putAll(valueMap);
        this.defaultMessage = defaultMessage;
    }
    
    /**
     * Rest response error handler. Uses the input messageMap to map HTTP error codes to messages.
     * Messages can have placeholders in curly braces format ({status}) that will be replaced
     * using the values map. By default, 'status' (the HTTP status code) and 'response' (the
     * response payload) are retrieved from the response and available as values.
     * 
     * @param messageMap HTTP error code to message map.
     * @param values Placeholder values map.
     */
    public RemoteErrorHandler(Map<Response.Status, String> messageMap, Map<String, String> valueMap) {
        this.error2msg.putAll(messageMap);
        this.values.putAll(valueMap);
    }

    public WelcomeException transformError(Response response) {
        return transformError(response, new HashMap<>());
    }
    
    public WelcomeException transformError(Response response, Map<String, String> additionalValues) {
        
        int status = response.getStatus();
        String responseStr = response.readEntity(String.class);
        
        Map<String, String> tempValues = new HashMap<>(values);
        tempValues.putAll(additionalValues);
        tempValues.put("status", ""+status);
        tempValues.put("response", responseStr);
        
        Exception newEx = null;
        try {
	        newEx = om.readValue(responseStr, Exception.class);

	    } catch (IOException e1) {
	        logger.severe("Unable to load Exception.");
	        logger.severe(StringSubstitutor.replace("Response content:\n{response}", tempValues, "{", "}"));
	    }

        Response.Status statusEnum = Response.Status.fromStatusCode(status);
        String msg = this.error2msg.get(statusEnum);
        if (msg == null) {
            msg = this.error2msg.getOrDefault("default", defaultMessage);
        }
        msg = StringSubstitutor.replace(msg, tempValues, "{", "}");
        logger.severe(msg);
        
        WelcomeException we;
        if (newEx == null) {
            we = new WelcomeException(msg);
        } else {
            we = new WelcomeException(msg, newEx);
        }
        
        return we;
    }
}