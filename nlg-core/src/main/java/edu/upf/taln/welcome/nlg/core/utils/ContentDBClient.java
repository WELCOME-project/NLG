package edu.upf.taln.welcome.nlg.core.utils;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.logging.Logger;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.commons.text.StringSubstitutor;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;

/**
 *
 * @author rcarlini
 */
public class ContentDBClient {
	
	private static final Logger logger = Logger.getLogger(ContentDBClient.class.getSimpleName());

    static class RemoteErrorHandler {

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
     
    // Sample url: https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections?collection=UtteranceTemplatesFirstPrototype&term=TInformConnection&language=en
    private final WebTarget target;
    private final RemoteErrorHandler errorHandler;

    // The url must be similar to https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections
    public ContentDBClient(String url) throws WelcomeException {
        try {                        
            Client client = initClient();
            target = client.target(url);

            errorHandler = initErrorHandler();
            
        } catch (NoSuchAlgorithmException | KeyManagementException ex) {
            throw new WelcomeException("Failed to initialize the ContentDB client!", ex);
        }            
    }
    
    private Client initClient() throws NoSuchAlgorithmException, KeyManagementException {
        // HTTPS setup
        TrustManager[] certs = new TrustManager[]
        {
            new X509TrustManager()
            {
                @Override
                public X509Certificate[] getAcceptedIssuers()
                {
                    return null;
                }

                @Override
                public void checkServerTrusted(X509Certificate[] chain, String authType)
                        throws CertificateException
                {
                }

                @Override
                public void checkClientTrusted(X509Certificate[] chain, String authType)
                        throws CertificateException
                {
                }
            }
        };        
        
        SSLContext ctx = SSLContext.getInstance("SSL");
        ctx.init( null, certs, new SecureRandom());        
        
        Client client = ClientBuilder.newBuilder()
                .hostnameVerifier((String hostname, SSLSession session) -> true)
                .sslContext(ctx)
                .build();
        
        return client;
    }
    
    private RemoteErrorHandler initErrorHandler() {
        
        String baseMessage = "Error on template retrieval. ContentDB failed with code {status}.";
        Map<Response.Status, String> error2msg = new HashMap<>();
        error2msg.put(Response.Status.SERVICE_UNAVAILABLE,  baseMessage + " Service unavailable.");
        error2msg.put(Response.Status.NOT_FOUND,            baseMessage + " URL: {uri}");
        error2msg.put(Response.Status.REQUEST_TIMEOUT,      baseMessage + " Request timeout.");

        Map<String, String> values = new HashMap<>();
        values.put("uri", ""+target.getUri());
        
        String defaultMessage = baseMessage + " For query: collection={collection}, term={term}, language={language}.";
        
        RemoteErrorHandler handler = new RemoteErrorHandler(error2msg, values, defaultMessage);
        
        return handler;
    }
    
    protected Response serviceCall(String collection, String term, String language) {
         Response response = target
                 .queryParam("collection", collection)
                 .queryParam("term", term)
                 .queryParam("language", language)
                 .request(MediaType.APPLICATION_JSON_TYPE)
                 .get();
         
        return response;
    }
    
    public List<String> getTemplate(String collection, String term, String language) throws WelcomeException {

        Response response = serviceCall(collection, term, language);
        
        if (response.getStatus() == Response.Status.OK.getStatusCode()) {
            
            GenericType<Map<String, List<String>>> type = new GenericType<>() {};
            Map<String, List<String>> templateInfo = response.readEntity(type);
            
            List<String> templates = templateInfo.get(term);
        
            return templates;

        } else {
            Map<String, String> values = new HashMap<>();
            values.put("collection", collection);
            values.put("term", term);
            values.put("language", language);

            WelcomeException exception = errorHandler.transformError(response, values);
            throw exception;
        }
    }
}
