package edu.upf.taln.welcome.nlg.core.utils;

import java.util.List;
import java.util.Map;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.net.ssl.SSLSession;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

/**
 *
 * @author rcarlini
 */
public class ContentDBClient {

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
    
    public List<String> getTemplate(String collection, String term, String language) throws WelcomeException {

        Response response = target                
                .queryParam("collection", collection)
                .queryParam("term", term)
                .queryParam("language", language)
                .request(MediaType.APPLICATION_JSON_TYPE)
                .get();
        
        if (response.getStatus() == Response.Status.OK.getStatusCode()) {
            
            GenericType<Map<String, List<String>>> type = new GenericType<>() {};
            Map<String, List<String>> templateInfo = response.readEntity(type);
            
            List<String> templates = templateInfo.get(term);
        
            return templates;

        } else {
            throw new WelcomeException("Template retrieval from contentDB failed with http error code " + response.getStatus() + ".");
        }
    }
    
}
