package edu.upf.taln.welcome.nlg.core.forge;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.commons.lang3.StringUtils;

import edu.upf.taln.forge.commons.ForgeException;
import edu.upf.taln.forge.core.Generator;
import edu.upf.taln.forge.core.configuration.GenerationProjectConfiguration;
import edu.upf.taln.forge.core.template.TemplateDataCollection;
import edu.upf.taln.forge.core.template.utils.DataExtractor;
import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;

/**
 *
 * @author rcarlini
 */
public class ForgeBasedGenerator {
	
	private static final Logger logger = Logger.getLogger(ForgeBasedGenerator.class.getName());

	private final Generator generator;
	private final List<List<String>> paragraphTemplates;

	public ForgeBasedGenerator(GenerationProjectConfiguration config) throws WelcomeException {
		try {
			generator = new Generator(config);
		} catch (ForgeException ex) {
			throw new WelcomeException(ex);
		}
		
		paragraphTemplates = new ArrayList<>();
		paragraphTemplates.add(Arrays.asList(new String[]{
			"stateName",
//			"confirmationName",
			"stateFirstSurname",
//			"confirmationSurname",
//			"haveSecondSurname",
			"stateSecondSurname",
//			"confirmationSecondSurname",
//			"confirmationHaveSecondSurname",
//			"confirmationFullName",
//			"updateAddress",
			"address",
			"city",
			"streetName",
			"streetType",
			"giveStreetNumber",
			"buildingName",
			"entranceName",
			"buildingType",
			"floor",
//			"apartmentNumber",
			"postalCode",
			"province",
			"municipality",
//			"highestDegree",
//			"haveCertificate",
//			"nameInstitution",
//			"finishDateDegree",
//			"currentOccupation",
//			"currentMainActivities",
//			"employer",
//			"employerAddress",
//			"startingDate",
//			"previousOccupation",
//			"previousMainActivities",
//			"previousEmployer",
//			"previousEmployerAddress",
//			"previousStartingDate",
//			"previousEndDate",
//			"drivingLicense",
//			"ownCar",
		}));
		
	}
	
	public String generate(SpeechAct input, int timeout, boolean skipErrors) throws WelcomeException {
				
        DataExtractor extractor = new SpeechActExtractor();
		TemplateDataCollection data = extractor.extractData(input);

		List<String> paragraphs = new ArrayList<>();
		for (List<String> enabledTemplates : paragraphTemplates) {
			try {
				String result = generator.generateWithTimeout(data, enabledTemplates, timeout);
				if (!result.isBlank()) {
					String postprocessed = postprocess(result);
					paragraphs.add(postprocessed);
				}

			} catch (Exception ex) {
				
                if (skipErrors) {
                    logger.log(Level.SEVERE, ex.getMessage());
                } else {
					WelcomeException wex;
					if (ex instanceof WelcomeException) {
						wex = (WelcomeException) ex;
					} else {
						wex = new WelcomeException("Unexpected error! (" + ex.getClass().getName() + ": " + ex.getMessage() + ")", ex);
					}
				
                    throw wex;
                }
			}
		}

		String text = String.join("\n\n", paragraphs);
		return text;
	}

    private String postprocess(String generatedText) {
        
        String[] sentences = generatedText.split("(\\. )|( \\.)");
        
        StringBuilder contents = new StringBuilder();
        for (String sentence : sentences) {
            sentence = sentence.trim();
            sentence = StringUtils.capitalize(sentence);
            sentence = sentence.replace(" ,", ",");
            sentence = sentence.replace(" '", "'");
            
            String[] tokens = sentence.split(" ");
            for (int idx=0; idx < tokens.length; idx++) {
                if (!tokens[idx].startsWith("http://")) {
                    tokens[idx] = tokens[idx].replace("_", " ");
                }
            }
            
            contents.append(StringUtils.join(tokens, " "));
            contents.append(". ");
        }
        
        return contents.toString();
    }
	
}
