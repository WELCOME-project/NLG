package edu.upf.taln.welcome.nlg.service;

import edu.upf.taln.welcome.dms.commons.output.DMOutput;
import edu.upf.taln.welcome.dms.commons.output.DMOutputData;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;
import edu.upf.taln.welcome.dms.commons.output.TemplateData;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;

import edu.upf.taln.welcome.nlg.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.nlg.commons.input.LanguageConfiguration;
import edu.upf.taln.welcome.nlg.commons.input.ServiceDescription;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;
import java.util.Map;


/**
 * Analyze text and return results in JSON format
 * 
 * @author jens.grivolla
 * 
 */
@Path("/nlg")
@Produces(MediaType.APPLICATION_JSON)
public class NLGService {

	/**
	 * Logger for this class and subclasses.
	 */
	protected final Log log = LogFactory.getLog(getClass());

	@Context
	ServletConfig config;

	public NLGService() throws WelcomeException {
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
	@Operation(summary = "Performs a deep syntactic analysis of the input data.",
		description = "Returns the result of the deep syntatic analysis, it is, a predicate-argument structure.",
		responses = {
		        @ApiResponse(description = "The deep analysis result.",
		        			content = @Content(schema = @Schema(implementation = DMOutput.class)
		        ))
	})
	public GenerationOutput analyze(
			@Parameter(description = "Container for analysis input data.", required = true) DMOutput container) throws WelcomeException {

        DMOutputData data = container.getData();
        List<SpeechAct> speechActs = data.getSpeechActs();
        
        String text = "";
        if (speechActs.isEmpty()) {
            text = "[ERROR: No speech acts found!]";
        } else {
        
            SpeechAct first = speechActs.get(0);
            switch(first.getType()) {
                case "conventional opening":
                    if (speechActs.size() == 1) {
                        text = "Hello.";
                    } else {
                        SpeechAct second = speechActs.get(1);
                        switch(second.getType()) {

                            case "Yes-no question":
                                text = "Hi, I believe you’re speaking in English, is that correct?";
                                break;

                            case "declarative wh-question":
                                
                                Map<String, TemplateData> saData = second.getData();
                                TemplateData tData = saData.get("request_info");
                                if (tData.getName() == null) {
                                    text = "Ok. In this case, I first need some personal data from you. "
                                        + "Please tell me your name, age, country of origin, "
                                        + "since when you are here in Catalonia, and your official residence address.";
                                } else {
                                    text = "I’ll also need the street name and number of your current address.";
                                }
                                break;


                            default:
                                break;
                        }
                    }
                    break;
                    
                case "response acknowledgement":
                    
                    text = "Great! ";
                    text += "Karim, you need to register at the closest resident registration office using your current address in Terrassa. "
                        + "When you have an apartment on your own, you will need to update your registration.\n";
                    
                    text +="The registration office is in the Raval de Montserrat, 14 street. "
                        + "The opening hours are from 9:00 to 15:00. "
                        + "You will need to bring with you your passport. "
                        + "Once you have registered, we will process your application.\n";
                    
                    text += "I can already give you some information on the First Reception Service. "
                        + "It consists of three modules: the language module, the labour market information module, and the Catalan society module. "
                        + "The language teaching module is a 90 hours course. "
                        + "At Col·legi Sagrat Cor nearby a course is offered on Mondays and Fridays from 19:00 to 21:00. "
                        + "The labour and Catalan society courses take place here at the City Council on Wednesdays from 19:00 to 21:00."
                        + "I can already give you some information...\n";
                    
                    text += "Bye-bye. ";
                    break;
                    
                default:
                    text = "[ERROR: Unknown/Unsupported speech act type! (" + first.getType() +")]";
                    break;
            }
        }
        
        GenerationOutput output = new GenerationOutput();
        output.setText(text);
        
		return output;
	}

}