package edu.upf.taln.welcome.nlg.core.utils;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.List;
import java.util.Map;
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

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;

/**
 *
 * @author rcarlini
 */
public class ContentDBClient {
	
	 private static final Logger logger = Logger.getLogger(ContentDBClient.class.getSimpleName());

    // Sample url: https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections?collection=UtteranceTemplatesFirstPrototype&term=TInformConnection&language=en
    private final WebTarget target;

    // The url must be similar to https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections
    public ContentDBClient(String url) throws NoSuchAlgorithmException, KeyManagementException {
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
        target = client.target(url);
    }
    
    protected Response serviceCall(String collection, String term, String language) {
    	return target                
                .queryParam("collection", collection)
                .queryParam("term", term)
                .queryParam("language", language)
                .request(MediaType.APPLICATION_JSON_TYPE)
                .get();
    }
    
    public List<String> getTemplate(String collection, String term, String language) throws WelcomeException {

        Response response = serviceCall(collection, term, language);
        
        if (response.getStatus() == Response.Status.OK.getStatusCode()) {
            
            GenericType<Map<String, List<String>>> type = new GenericType<>() {};
            Map<String, List<String>> templateInfo = response.readEntity(type);
            
            List<String> templates = templateInfo.get(term);
        
            return templates;

        } else {
        	errorManagement(response, collection, term, language);
        	return null;
        }
    }
    
    private void errorManagement(Response response, String collection, String term, String language) throws WelcomeException {
    	String responseStr = response.readEntity(String.class);
        ObjectMapper om = new ObjectMapper()
        		.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    	
        logger.severe("Error on template retrieval.\nContentDB failed with code " + response.getStatus() + ".");
        
        WelcomeException we;
        if (response.getStatus() == Response.Status.SERVICE_UNAVAILABLE.getStatusCode()) {
        	throw new WelcomeException("Error on template retrieval. ContentDB failed with code " + response.getStatus() + ". Service unavailable.");
        
        } else if(response.getStatus() == Response.Status.NOT_FOUND.getStatusCode()) {
        	throw new WelcomeException("Error on template retrieval. ContentDB failed with code " + response.getStatus() + ". URL: " + target.getUri());
        
        }else if(response.getStatus() == Response.Status.REQUEST_TIMEOUT.getStatusCode()) {
        	throw new WelcomeException("Error on template retrieval. ContentDB failed with code " + response.getStatus() + ". Request timeout.");
        
        } else {
		    try {
		        Exception newEx = om.readValue(responseStr, Exception.class);
		        we = new WelcomeException(newEx);
	
		    } catch (IOException e1) {
		        logger.severe("Unable to load Exception.");
		        logger.severe("Response content:\n" + responseStr);
		        throw new WelcomeException("Error on template retrieval. ContentDB failed with code " + response.getStatus() + ". "
		        		+ "For template: <collection> " + collection + " <term> " + term + " <language> " + language);
		    }
        }
	    throw we;
    }
    
}
