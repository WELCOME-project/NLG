package edu.upf.taln.welcome.nlg.core.utils;

import com.ibm.icu.util.ULocale;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
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

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;

/**
 *
 * @author rcarlini
 */
public class ContentDBClient {
	
	private static final Logger logger = Logger.getLogger(ContentDBClient.class.getSimpleName());

    // Sample url: https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections?collection=UtteranceTemplatesFirstPrototype&term=TInformConnection&language=en
    private final WebTarget target;
    private final RemoteErrorHandler errorHandler;

    // The url must be similar to https://18.224.42.120/welcome/integration/workflow/dispatcher/contentDBCollections
    public ContentDBClient(String url) throws WelcomeException {
        try {                        
            Client client = initClient();
            target = client.target(url);

            errorHandler = initErrorHandler();
            
            logger.info("Using content DB from: " + url);
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

    public String getTemplate(String collection, String term, ULocale language) throws WelcomeException {
        return getTemplate(collection, term, language.getISO3Language());
    }
    
    public String getTemplate(String collection, String term, String language) throws WelcomeException {
        
        List<String> templates = getTemplates(collection, term, language);
        
        String template = null;
        if (templates == null || templates.isEmpty()) {
            String message = "No template found for templateId " + term + " in collection \"" + collection + "\" for language " + language + ".";
            logger.severe(message);
            
        } else {
            if (templates.size() > 1) {
                String message = "Multiple templates found for templateId " + term + " in collection \"" + collection + "\" for language " + language + ".";
                logger.warning(message);
                //throw new WelcomeException(message);
            }
            template = templates.get(0);
        }
        
        return template;
    }    
    
    public List<String> getTemplates(String collection, String term, String language) throws WelcomeException {

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
