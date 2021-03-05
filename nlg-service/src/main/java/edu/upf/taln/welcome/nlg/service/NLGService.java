package edu.upf.taln.welcome.nlg.service;

import com.apicatalog.jsonld.api.JsonLdError;
import com.apicatalog.jsonld.document.Document;
import com.apicatalog.jsonld.document.DocumentParser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.util.ULocale;
import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.nlg.commons.input.LanguageConfiguration;
import edu.upf.taln.welcome.nlg.commons.input.ServiceDescription;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;
import edu.upf.taln.welcome.nlg.core.LanguageGenerator;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;

import javax.servlet.ServletConfig;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 * Analyze text and return results in JSON format
 *
 *
 */
@Path("/nlg")
@Produces(MediaType.APPLICATION_JSON)
public class NLGService {

	private static final String OPENING_DIP_INPUT = "{\n" +
			"  \"speechActs\" : [ {\n" +
			"    \"@id\" : \"welcome:Open_Question_0\",\n" +
			"    \"@type\" : \"welcome:SpeechAct\",\n" +
			"    \"welcome:hasLabel\" : {\n" +
			"      \"@id\" : \"welcome:Open_Question\",\n" +
			"      \"@type\" : \"welcome:SpeechActLabel\"\n" +
			"    },\n" +
			"    \"welcome:hasSlot\" : {\n" +
			"      \"@id\" : \"welcome:obtainRequest\",\n" +
			"      \"@type\" : [ \"welcome:SystemDemand\" ],\n" +
			"      \"welcome:hasTemplate\" : null,\n" +
			"      \"welcome:hasInputRDFContents\" : [ \"{\\\"@id\\\":\\\"welcome:Unknown\\\"}\" ],\n" +
			"      \"welcome:hasStatus\" : [ {\n" +
			"        \"@id\" : \"welcome:Pending\"\n" +
			"      } ],\n" +
			"      \"welcome:hasNumberAttemps\" : 0,\n" +
			"      \"welcome:confidenceScore\" : 0.0,\n" +
			"      \"welcome:isOptional\" : false\n" +
			"    }\n" +
			"  } ],\n" +
			"  \"@id\" : \"welcome:move_0\",\n" +
			"  \"@type\" : \"welcome:DialogueMove\"\n" +
			"}";

	private static final String OPENING_DIP_OUTPUT = "{\n" +
			"  \"text\" : \"How can I help you?\"\n" +
			"}";

	private static final String OBTAIN_STATUS_DIP_INPUT = "{\n" +
			"  \"speechActs\" : [ {\n" +
			"    \"@id\" : \"welcome:Wh_Question_1\",\n" +
			"    \"@type\" : \"welcome:SpeechAct\",\n" +
			"    \"welcome:hasLabel\" : {\n" +
			"      \"@id\" : \"welcome:Wh_Question\",\n" +
			"      \"@type\" : \"welcome:SpeechActLabel\"\n" +
			"    },\n" +
			"    \"welcome:hasSlot\" : {\n" +
			"      \"@id\" : \"welcome:obtainStatus\",\n" +
			"      \"@type\" : [ \"welcome:SystemDemand\" ],\n" +
			"      \"welcome:hasTemplate\" : null,\n" +
			"      \"welcome:hasInputRDFContents\" : [ \"{\\\"@id\\\":\\\"welcome:Unknown\\\"}\" ],\n" +
			"      \"welcome:hasStatus\" : [ {\n" +
			"        \"@id\" : \"welcome:Pending\"\n" +
			"      } ],\n" +
			"      \"welcome:hasNumberAttemps\" : 0,\n" +
			"      \"welcome:confidenceScore\" : 0.0,\n" +
			"      \"welcome:isOptional\" : false\n" +
			"    }\n" +
			"  } ],\n" +
			"  \"@id\" : \"welcome:move_1\",\n" +
			"  \"@type\" : \"welcome:DialogueMove\"\n" +
			"}";

	private static final String OBTAIN_STATUS_DIP_OUTPUT = "{\n" +
			"  \"text\" : \"First of all, I need to know if you already registered\"\n" +
			"}";

	private static final String PROPOSE_SERVICE_DIP_INPUT = "{\n" +
			"  \"speechActs\" : [ {\n" +
			"    \"@id\" : \"welcome:Yes_No_Question_2\",\n" +
			"    \"@type\" : \"welcome:SpeechAct\",\n" +
			"    \"welcome:hasLabel\" : {\n" +
			"      \"@id\" : \"welcome:Yes_No_Question\",\n" +
			"      \"@type\" : \"welcome:SpeechActLabel\"\n" +
			"    },\n" +
			"    \"welcome:hasSlot\" : {\n" +
			"      \"@id\" : \"welcome:obtainInterest\",\n" +
			"      \"@type\" : [ \"welcome:SystemInfo\" ],\n" +
			"      \"welcome:hasTemplate\" : null,\n" +
			"      \"welcome:hasInputRDFContents\" : [ \"{\\\"@id\\\":\\\"welcome:Unknown\\\"}\" ],\n" +
			"      \"welcome:hasStatus\" : [ {\n" +
			"        \"@id\" : \"welcome:Pending\"\n" +
			"      } ],\n" +
			"      \"welcome:hasNumberAttemps\" : 0,\n" +
			"      \"welcome:confidenceScore\" : 0.0,\n" +
			"      \"welcome:isOptional\" : false\n" +
			"    }\n" +
			"  } ],\n" +
			"  \"@id\" : \"welcome:move_2\",\n" +
			"  \"@type\" : \"welcome:DialogueMove\"\n" +
			"}";

	private static final String PROPOSE_SERVICE_DIP_OUTPUT = "{\n" +
			"  \"text\" : \"Do you want me to inform you on the First Reception Service?\"\n" +
			"}";

	private final LanguageGenerator generator = new LanguageGenerator(ULocale.ENGLISH); // only English for the time being
	private final Logger logger = Logger.getLogger(NLGService.class.getName());

	@Context
	ServletConfig config;

	public NLGService() { }

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
			requestBody = @RequestBody(
					content = @Content(mediaType = MediaType.APPLICATION_JSON,
							schema = @Schema(implementation = DialogueMove.class),
							examples = {
									@ExampleObject(name = "Example using Opening DIP", value = OPENING_DIP_INPUT),
									@ExampleObject(name = "Example using Obtain Registration Status DIP", value = OBTAIN_STATUS_DIP_INPUT),
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
											@ExampleObject(name = "Example using Obtain Registration Status DIP", value = OBTAIN_STATUS_DIP_OUTPUT),
											@ExampleObject(name = "Example using Propose First Reception Service DIP", value = PROPOSE_SERVICE_DIP_OUTPUT)
									}
							))
			})

	/*
	 * Unmarshalls JSON-LD edu.upf.taln.welcome.nlg.commons.input to POJO representations of dialogue moves, and passes it to the linguistic generator --if NLG is required.
	 * The resulting texts is returned wrapped in a JSON message.
	 */
	public GenerationOutput generate(
			@Parameter(description = "Dialogue move used as generation edu.upf.taln.welcome.nlg.commons.input data.", required = true) JsonNode input) throws WelcomeException {
		try
		{
			StringReader inputReader = new StringReader(input.toString());
			Document inputDoc = DocumentParser.parse(com.apicatalog.jsonld.http.media.MediaType.JSON_LD, inputReader);
			String json = inputDoc.getJsonContent().map(Object::toString).orElse("");

			ObjectMapper mapper = new ObjectMapper();
			DialogueMove move = mapper.readValue(json, DialogueMove.class);
			final String text = generator.generate(move);

			GenerationOutput output = new GenerationOutput();
			output.setText(text);

			return output;
		} catch (JsonLdError | IOException | NullPointerException ex) {
			logger.log(Level.SEVERE, "Failed to generate text", ex);
			throw new WelcomeException(ex);
		}
	}
}