package edu.upf.taln.welcome.nlg.service;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map.Entry;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;

import org.apache.commons.lang3.tuple.Pair;

import com.fasterxml.jackson.databind.JsonNode;
import com.ibm.icu.util.ULocale;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;

import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.dms.commons.utils.JsonLDUtils;
import edu.upf.taln.welcome.nlg.commons.input.LanguageConfiguration;
import edu.upf.taln.welcome.nlg.commons.input.ServiceDescription;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;
import edu.upf.taln.welcome.nlg.commons.utils.LanguageConverter;
import edu.upf.taln.welcome.nlg.core.LanguageGenerator;


/**
 * Analyze text and return results in JSON format
 *
 *
 */
@Path("/nlg")
@Produces(MediaType.APPLICATION_JSON)
public class NLGService {

	private static final String OPENING_DIP_INPUT = "{\n" + 
			"  \"@context\" : {\n" + 
			"    \"w3c\" : \"http://www.w3.org/2001/XMLSchema#\",\n" + 
			"    \"rdf\" : \"http://www.w3.org/1999/02/22-rdf-syntax-ns#\",\n" + 
			"    \"welcome\" : \"https://raw.githubusercontent.com/gtzionis/WelcomeOntology/main/welcome.ttl#\",\n" + 
			"    \"daml\" : \"http://www.daml.org/services/owl-s/1.1/ActorDefault.owl#\",\n" + 
			"    \"rdf:subject\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"rdf:predicate\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasSlot\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasOntologyType\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasStatus\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:isCurrentDIP\" : {\n" + 
			"      \"@type\" : \"w3c:boolean\"\n" + 
			"    },\n" + 
			"    \"welcome:hasDIPStatus\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasInputRDFContents\" : {\n" + 
			"      \"@container\" : \"@set\"\n" + 
			"    },\n" + 
			"    \"welcome:hasTCNAnswer\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:confidenceScore\" : {\n" + 
			"      \"@type\" : \"w3c:float\"\n" + 
			"    },\n" + 
			"    \"welcome:hasNumberAttempts\" : {\n" + 
			"      \"@type\" : \"w3c:int\"\n" + 
			"    },\n" + 
			"    \"welcome:isOptional\" : {\n" + 
			"      \"@type\" : \"w3c:boolean\"\n" + 
			"    },\n" + 
			"    \"welcome:hasSpeechActs\" : {\n" + 
			"      \"@container\" : \"@list\"\n" + 
			"    }\n" + 
			"  },\n" + 
			"  \"@id\" : \"move_88\",\n" + 
			"  \"@type\" : \"welcome:DialogueMove\",\n" + 
			"  \"welcome:hasSpeechActs\" : [ {\n" + 
			"    \"@id\" : \"Open_Question_88\",\n" + 
			"    \"@type\" : \"welcome:SpeechAct\",\n" + 
			"    \"welcome:hasLabel\" : \"Open_Question\",\n" + 
			"    \"welcome:hasSlot\" : {\n" + 
			"      \"@id\" : \"welcome:obtainRequest\",\n" + 
			"      \"@type\" : null,\n" + 
			"      \"welcome:hasTemplateId\" : \"TObtainMatterConcern\",\n" + 
			"      \"welcome:hasOntologyType\" : \"https://raw.githubusercontent.com/gtzionis/WelcomeOntology/main/welcome.ttl#ServiceRequest\",\n" + 
			"      \"welcome:hasInputRDFContents\" : [ {\n" + 
			"        \"@id\" : \"welcome:Unknown\"\n" + 
			"      } ],\n" + 
			"      \"welcome:hasStatus\" : \"welcome:Pending\",\n" + 
			"      \"welcome:hasNumberAttemps\" : 0,\n" + 
			"      \"welcome:confidenceScore\" : 1.0,\n" + 
			"      \"welcome:isOptional\" : false\n" + 
			"    }\n" + 
			"  } ]\n" + 
			"}";

	private static final String OPENING_DIP_OUTPUT = "{\n" + 
			"  \"text\" : \"How can I help you?\"\n" + 
			"}";

	private static final String FILL_PERSONAL_INFO_DIP_INPUT = "{\n" + 
			"  \"@context\" : {\n" + 
			"    \"w3c\" : \"http://www.w3.org/2001/XMLSchema#\",\n" + 
			"    \"rdf\" : \"http://www.w3.org/1999/02/22-rdf-syntax-ns#\",\n" + 
			"    \"welcome\" : \"https://raw.githubusercontent.com/gtzionis/WelcomeOntology/main/welcome.ttl#\",\n" + 
			"    \"daml\" : \"http://www.daml.org/services/owl-s/1.1/ActorDefault.owl#\",\n" + 
			"    \"rdf:subject\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"rdf:predicate\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasSlot\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasOntologyType\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasStatus\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:isCurrentDIP\" : {\n" + 
			"      \"@type\" : \"w3c:boolean\"\n" + 
			"    },\n" + 
			"    \"welcome:hasDIPStatus\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasInputRDFContents\" : {\n" + 
			"      \"@container\" : \"@set\"\n" + 
			"    },\n" + 
			"    \"welcome:hasTCNAnswer\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:confidenceScore\" : {\n" + 
			"      \"@type\" : \"w3c:float\"\n" + 
			"    },\n" + 
			"    \"welcome:hasNumberAttempts\" : {\n" + 
			"      \"@type\" : \"w3c:int\"\n" + 
			"    },\n" + 
			"    \"welcome:isOptional\" : {\n" + 
			"      \"@type\" : \"w3c:boolean\"\n" + 
			"    },\n" + 
			"    \"welcome:hasSpeechActs\" : {\n" + 
			"      \"@container\" : \"@list\"\n" + 
			"    }\n" + 
			"  },\n" + 
			"  \"@id\" : \"move_52\",\n" + 
			"  \"@type\" : \"welcome:DialogueMove\",\n" + 
			"  \"welcome:hasSpeechActs\" : [ {\n" + 
			"    \"@id\" : \"Yes_No_Question_52\",\n" + 
			"    \"@type\" : \"welcome:SpeechAct\",\n" + 
			"    \"welcome:hasLabel\" : \"Yes_No_Question\",\n" + 
			"    \"welcome:hasSlot\" : {\n" + 
			"      \"@id\" : \"frs:confirmFirstSurname\",\n" + 
			"      \"@type\" : null,\n" + 
			"      \"welcome:hasTemplateId\" : \"TConfirmSurname\",\n" + 
			"      \"welcome:hasOntologyType\" : \"http://www.w3.org/2001/XMLSchema#boolean\",\n" + 
			"      \"welcome:hasInputRDFContents\" : [ {\n" + 
			"        \"@type\" : \"rdf:Statement\",\n" + 
			"        \"rdf:subject\" : \"welcome:FirstSurname\",\n" + 
			"        \"rdf:predicate\" : \"welcome:hasValue\",\n" + 
			"        \"rdf:object\" : {\n" + 
			"          \"@id\" : null,\n" + 
			"          \"@type\" : null,\n" + 
			"          \"@value\" : \"Doe\"\n" + 
			"        }\n" + 
			"      } ],\n" + 
			"      \"welcome:hasStatus\" : \"welcome:Pending\",\n" + 
			"      \"welcome:hasNumberAttemps\" : 0,\n" + 
			"      \"welcome:confidenceScore\" : 0.0,\n" + 
			"      \"welcome:isOptional\" : false\n" + 
			"    }\n" + 
			"  } ]\n" + 
			"}";

	private static final String FILL_PERSONAL_INFO_DIP_OUTPUT = "{\n" + 
			"  \"text\" : \"I understand that your surname is Doe. Is this correct?\"\n" + 
			"}";

	private static final String PROPOSE_SERVICE_DIP_INPUT = "{\n" + 
			"  \"@context\" : {\n" + 
			"    \"w3c\" : \"http://www.w3.org/2001/XMLSchema#\",\n" + 
			"    \"rdf\" : \"http://www.w3.org/1999/02/22-rdf-syntax-ns#\",\n" + 
			"    \"welcome\" : \"https://raw.githubusercontent.com/gtzionis/WelcomeOntology/main/welcome.ttl#\",\n" + 
			"    \"daml\" : \"http://www.daml.org/services/owl-s/1.1/ActorDefault.owl#\",\n" + 
			"    \"rdf:subject\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"rdf:predicate\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasSlot\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasOntologyType\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasStatus\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:isCurrentDIP\" : {\n" + 
			"      \"@type\" : \"w3c:boolean\"\n" + 
			"    },\n" + 
			"    \"welcome:hasDIPStatus\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:hasInputRDFContents\" : {\n" + 
			"      \"@container\" : \"@set\"\n" + 
			"    },\n" + 
			"    \"welcome:hasTCNAnswer\" : {\n" + 
			"      \"@type\" : \"@id\"\n" + 
			"    },\n" + 
			"    \"welcome:confidenceScore\" : {\n" + 
			"      \"@type\" : \"w3c:float\"\n" + 
			"    },\n" + 
			"    \"welcome:hasNumberAttempts\" : {\n" + 
			"      \"@type\" : \"w3c:int\"\n" + 
			"    },\n" + 
			"    \"welcome:isOptional\" : {\n" + 
			"      \"@type\" : \"w3c:boolean\"\n" + 
			"    },\n" + 
			"    \"welcome:hasSpeechActs\" : {\n" + 
			"      \"@container\" : \"@list\"\n" + 
			"    }\n" + 
			"  },\n" + 
			"  \"@id\" : \"move_89\",\n" + 
			"  \"@type\" : \"welcome:DialogueMove\",\n" + 
			"  \"welcome:hasSpeechActs\" : [ {\n" + 
			"    \"@id\" : \"Yes_No_Question_89\",\n" + 
			"    \"@type\" : \"welcome:SpeechAct\",\n" + 
			"    \"welcome:hasLabel\" : \"Yes_No_Question\",\n" + 
			"    \"welcome:hasSlot\" : {\n" + 
			"      \"@id\" : \"frs:obtainInterest\",\n" + 
			"      \"@type\" : null,\n" + 
			"      \"welcome:hasTemplateId\" : \"TObtainInterestInform\",\n" + 
			"      \"welcome:hasOntologyType\" : \"http://www.w3.org/2001/XMLSchema#boolean\",\n" + 
			"      \"welcome:hasInputRDFContents\" : [ {\n" + 
			"        \"@id\" : \"welcome:reifiedInterest\",\n" + 
			"        \"@type\" : \"rdf:Statement\",\n" + 
			"        \"rdf:subject\" : \"welcome:ServiceName\",\n" + 
			"        \"rdf:predicate\" : \"welcome:hasValue\",\n" + 
			"        \"rdf:object\" : {\n" + 
			"          \"@id\" : null,\n" + 
			"          \"@type\" : null,\n" + 
			"          \"@value\" : \"First Reception Service in Catalonia\"\n" + 
			"        }\n" + 
			"      } ],\n" + 
			"      \"welcome:hasStatus\" : \"welcome:Pending\",\n" + 
			"      \"welcome:hasNumberAttemps\" : 0,\n" + 
			"      \"welcome:confidenceScore\" : 0.0,\n" + 
			"      \"welcome:isOptional\" : false\n" + 
			"    }\n" + 
			"  } ]\n" + 
			"}";

	private static final String PROPOSE_SERVICE_DIP_OUTPUT = "{\n" + 
			"  \"text\" : \"Do you want me to inform you on the First Reception Service in Catalonia?\"\n" + 
			"}";

    private final Logger logger = Logger.getLogger(NLGService.class.getName());

	@Context
	ServletConfig config;

	private final LanguageGenerator generator;
    private URL contextFile;

	public NLGService() throws WelcomeException {
        try {
            contextFile = NLGService.class.getResource("/welcome-nlg-context.jsonld");
            if (contextFile == null) {
                throw new WelcomeException("JSONLD context file not found!");
            }
            
            String templatesUrl = System.getenv("CONTENTDB_URL");
            if (templatesUrl != null) {
            	generator = new LanguageGenerator(templatesUrl);
            } else {
            	generator = new LanguageGenerator();
            }
        
		} catch (Exception ex) {
			logger.log(Level.SEVERE, "Unexpected error! Failed to initialize service", ex);
			throw new WelcomeException(ex);
        }
    }

	@GET
	@Path("/description")
	@Operation(summary = "Retrieves the available configurations.",
			description = "Returns the list of available configurations, it is, the list of languages and available analysis module for each one.",
			responses = {
					@ApiResponse(description = "The available configurations",
							content = @Content(schema = @Schema(implementation = ServiceDescription.class)
							))
			})
	public ServiceDescription getAvailableConfigurations() throws WelcomeException {

		LanguageConfiguration es_config = new LanguageConfiguration();
		es_config.setLanguage("es");

		List<LanguageConfiguration> configList = new ArrayList<>();
		configList.add(es_config);

		ServiceDescription description = new ServiceDescription();
		description.setConfigurations(configList);

		return description;
	}


	@POST
	@Path("/generate")
	@Consumes(MediaType.APPLICATION_JSON)
	@Operation(summary = "Performs natural language generation from the edu.upf.taln.welcome.nlg.commons.input data generated by DMS.",
			description = "Returns the text derived from the DMS edu.upf.taln.welcome.nlg.commons.output.",
			parameters = {
				    @Parameter(in = ParameterIn.HEADER,
				        name = "X-Language",
				        description = "Templates Language",
				        required = false,
				        schema = @Schema(type = "string")
				    )
				},
			requestBody = @RequestBody(
					content = @Content(mediaType = MediaType.APPLICATION_JSON,
							schema = @Schema(implementation = DialogueMove.class),
							examples = {
									@ExampleObject(name = "Example using Opening DIP", value = OPENING_DIP_INPUT),
									@ExampleObject(name = "Example using Fill Personal Info DIP", value = FILL_PERSONAL_INFO_DIP_INPUT),
									@ExampleObject(name = "Example using Propose First Reception Service DIP", value = PROPOSE_SERVICE_DIP_INPUT)
							}
					)
			),
			responses = {
					@ApiResponse(description = "JSON containing a single element corresponding to the generated natural language text.",
							content = @Content(mediaType = MediaType.APPLICATION_JSON,
									schema = @Schema(implementation = GenerationOutput.class),
									examples = {
											@ExampleObject(name = "Example using Opening DIP", value = OPENING_DIP_OUTPUT),
											@ExampleObject(name = "Example using Fill Personal Info DIP", value = FILL_PERSONAL_INFO_DIP_OUTPUT),
											@ExampleObject(name = "Example using Propose First Reception Service DIP", value = PROPOSE_SERVICE_DIP_OUTPUT)
									}
							))
			})

	/*
	 * Unmarshalls JSON-LD edu.upf.taln.welcome.nlg.commons.input to POJO representations of dialogue moves, and passes it to the linguistic generator --if NLG is required.
	 * The resulting texts is returned wrapped in a JSON message.
	 */
	public Response generate(@Context HttpHeaders headers,
			@Parameter(description = "Dialogue move used as generation edu.upf.taln.welcome.nlg.commons.input data.", required = true) JsonNode input) throws WelcomeException {
		
		StringBuffer strb = new StringBuffer(); 
		MultivaluedMap<String, String> rh = headers.getRequestHeaders();
		strb.append("Headers:\n");
		for(Entry<String, List<String>> header : rh.entrySet()) {
			strb.append("\t" + header.getKey() + ": [" + String.join(", ", header.getValue()) + "]\n");
		}
		logger.log(Level.INFO, strb.toString());
		
		String language = "eng";
		List<String> languageArray = headers.getRequestHeader("X-Language");
		if(languageArray != null) {
			language = languageArray.get(0);
		}
		logger.log(Level.INFO, "Language: " + language);
		
		ULocale locale = ULocale.forLocale(new Locale(LanguageConverter.convertLanguage(language)));
		
		try
		{
			DialogueMove move = JsonLDUtils.readMove(input.toString());
            Pair<GenerationOutput, ULocale> output = generator.generate(move, locale); // only English for the time being

            ResponseBuilder rBuild = Response
					.ok(output.getLeft(), MediaType.APPLICATION_JSON)
					.header("x-language", output.getRight().getISO3Language());
            return rBuild.build();
            
        } catch (WelcomeException ex) {
            throw ex;
            
		} catch (Exception ex) {
			logger.log(Level.SEVERE, "Failed to generate text", ex);
			throw new WelcomeException(ex);
		}
	}
	
	
	@GET
	@Path("/status")
	@Operation(summary = "Retrieve the services status.",
		description = "Returns a status description of the service.",
		responses = {
		        @ApiResponse(description = "The services status.",
		        			content = @Content(schema = @Schema(implementation = StatusOutput.class)
		        ))
	})
	public StatusOutput getStatus() throws WelcomeException {
		ServletContext application = config.getServletContext();
		String build;
		try {
			build = new String(application.getResourceAsStream("META-INF/MANIFEST.MF").readAllBytes());
		} catch (IOException e) {
			throw new WelcomeException();
		}
		return new StatusOutput(build);
	}
	
	@GET
	@Path("/status/log")
	@Operation(summary = "Retrieve the service log.",
		description = "Returns a specific amount of log messages.",
		responses = {
		        @ApiResponse(description = "The log messages.",
		        			content = @Content(schema = @Schema(implementation = StatusLogOutput.class)
		        ))
	})
	public StatusLogOutput getLog(@QueryParam("limit") int limit) throws WelcomeException {
		return new StatusLogOutput();
	}

}