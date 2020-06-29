package edu.upf.taln.welcome.nlg.service;

import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.ServletConfig;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Context;

import org.glassfish.jersey.server.ResourceConfig;

import io.swagger.v3.jaxrs2.integration.resources.OpenApiResource;
import io.swagger.v3.oas.integration.SwaggerConfiguration;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.servers.Server;

@ApplicationPath("api")
public class ServiceApplication extends ResourceConfig {
	
    public ServiceApplication(@Context ServletConfig servletConfig) {
        super();

        OpenAPI oas = new OpenAPI();
        Info info = new Info()
                .title("TALN Natural Language Generation Service")
                .description("Detailed description of the different methods available in the Natural Language Generation service.");

        oas.info(info);

        String basePath = servletConfig.getServletContext().getContextPath();

        Server server = new Server();
        server.setUrl(basePath);
		oas.addServersItem(server);
        
        OpenApiResource openApiResource = new OpenApiResource();

        SwaggerConfiguration oasConfig = new SwaggerConfiguration()
                .openAPI(oas)
                .prettyPrint(true)
//                .resourcePackages(Stream.of("edu.upf.taln.welcome.nlg.service").collect(Collectors.toSet()))
                ;

        openApiResource.setOpenApiConfiguration(oasConfig);
        register(openApiResource);
        
        String packageName = this.getClass().getPackage().getName();
        packages(packageName);
    }	
	
}