package edu.upf.taln.welcome.nlg.core;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.util.ULocale;

import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.nlg.commons.output.GenerationOutput;

/**
 *
 * @author rcarlini
 */
public class SentenceSplittingTest {

    public void generate(String jsonldPath, String textOutput, List<String> displayOutput, List<String> ttsOutput) throws Exception {
        
        File inputFile = new File(jsonldPath);

        ObjectMapper mapper = new ObjectMapper();
        DialogueMove move = mapper.readValue(inputFile, DialogueMove.class);
        
        LanguageGenerator generator = new LanguageGenerator();
        GenerationOutput output = generator.generate(move, ULocale.ENGLISH);
        
        assertEquals(textOutput, output.getText());
        assertEquals(displayOutput, output.getDisplayChunks());
        assertEquals(ttsOutput, output.getChunks());
    }
    
    @Test
    public void testSentenceSplitting() throws Exception {
        String jsonldPath = "src/test/resources/testSentenceSplitting/yes_no_question.json";
        String textResult = "Please, say \"yes\" or \"no\".\n\n" + 
        		"Welcome to the CV creation service.\n\n" + 
        		"This service will show you how to compile a CV which you will be able to print and present to recruiters.\n\n" + 
        		"I will guide you through different sections of the CV and we will collaboratively introduce all necessary information to them.\n\n" + 
        		"Keep in mind that the information you provide should be as precise and clear as possible.\n\n" + 
        		"It should also be in line with the range of positions you aim to apply for and help you present yourself from the best side.";
        List<String> displayOutput = new ArrayList<>();
        displayOutput.add("Please, say \"yes\" or \"no\".");
        displayOutput.add("Welcome to the CV creation service.");
        displayOutput.add("This service will show you how to compile a CV which you will be able to print and present to recruiters.");
        displayOutput.add("I will guide you through different sections of the CV and we will collaboratively introduce all necessary information to them.");
        displayOutput.add("Keep in mind that the information you provide should be as precise and clear as possible.");
        displayOutput.add("It should also be in line with the range of positions you aim to apply for and help you present yourself from the best side.");
        List<String> ttsOutput = new ArrayList<>();
        ttsOutput.add("Please, say \"yes\" or \"no\".");
        ttsOutput.add("Welcome to the CV creation service.");
        ttsOutput.add("This service will show you how to compile a CV which you will be able to print and present to recruiters.");
        ttsOutput.add("I will guide you through different sections of the CV and we will collaboratively introduce all necessary information to them.");
        ttsOutput.add("Keep in mind that the information you provide should be as precise and clear as possible.");
        ttsOutput.add("It should also be in line with the range of positions you aim to apply for and help you present yourself from the best side.");
        generate(jsonldPath, textResult, displayOutput, ttsOutput);
    }
    
    @Test
    public void testAssistAndContacts() throws Exception {
        String jsonldPath = "src/test/resources/testSentenceSplitting/assistAndContacts.json";
        String textResult = "In this case I cannot assist you. Please contact CARITAS in order to schedule an appointment with a professional for further information.\n\n" + 
        		"For further information about CARITAS you can visit our page https://www.caritas-hamm.de/einrichtungen/beratungszentrum/beratungszentrum.";
        List<String> displayOutput = new ArrayList<>();
        displayOutput.add("In this case I cannot assist you. Please contact CARITAS in order to schedule an appointment with a professional for further information.");
        displayOutput.add("For further information about CARITAS you can visit our page https://www.caritas-hamm.de/einrichtungen/beratungszentrum/beratungszentrum.");
        List<String> ttsOutput = new ArrayList<>();
		ttsOutput.add("In this case I cannot assist you. Please contact CARITAS in order to schedule an appointment with a professional for further information.");
		ttsOutput.add("For further information about CARITAS you can visit our webpage. The link is on the screen.");
        generate(jsonldPath, textResult, displayOutput, ttsOutput);
    }
    
    @Test
    public void testPraksisContact() throws Exception {
        String jsonldPath = "src/test/resources/testSentenceSplitting/praksisContact.json";
        String textResult = "a. Praksis Community Center (Athens).\n\n" + 
        		"Address: 24, Sarpidonos Street, Athens, Greece.\n\n" + 
        		"Tel: 210-8213704.\n\n" + 
        		"Email: info@praksis.gr.\n\n" + 
        		"b. Praksis Polyclinic (Thessaloniki).\n\n" + 
        		"Address: 1, Arkadioupoleos & Agiou Dimitriou Streets, Thessaloniki, Greece.\n\n" + 
        		"Tel: 2310-556145.\n\n" + 
        		"Email: info@praksis.gr.";
        List<String> displayOutput = new ArrayList<>();
        displayOutput.add("a. Praksis Community Center (Athens).");
        displayOutput.add("Address: 24, Sarpidonos Street, Athens, Greece.");
        displayOutput.add("Tel: 210-8213704.");
        displayOutput.add("Email: info@praksis.gr.");
        displayOutput.add("b. Praksis Polyclinic (Thessaloniki).");
        displayOutput.add("Address: 1, Arkadioupoleos & Agiou Dimitriou Streets, Thessaloniki, Greece.");
        displayOutput.add("Tel: 2310-556145.");
        displayOutput.add("Email: info@praksis.gr.");
        List<String> ttsOutput = new ArrayList<>();
        ttsOutput.add("You can see their contact details on the screen.");
        generate(jsonldPath, textResult, displayOutput, ttsOutput);
    }
    
    @Test
    public void testFormDisclaimer() throws Exception {
        String jsonldPath = "src/test/resources/testSentenceSplitting/formDisclaimer.json";
        String textResult = "Thank you. Here is a pre-filled form using the data you entered during your registration to TestApp.\n\n" + 
        		"Please keep in mind that this pre-filled form doesn't replace the online full-registration procedure that you must complete through the official website of the Spain Asylum Service (https://www.caritas-hamm.de/einrichtungen/beratungszentrum/beratungszentrum).";
        List<String> displayOutput = new ArrayList<>();
        displayOutput.add("Thank you. Here is a pre-filled form using the data you entered during your registration to TestApp.");
        displayOutput.add("Please keep in mind that this pre-filled form doesn't replace the online full-registration procedure that you must complete through the official website of the Spain Asylum Service (https://www.caritas-hamm.de/einrichtungen/beratungszentrum/beratungszentrum).");
        List<String> ttsOutput = new ArrayList<>();
        ttsOutput.add("Thank you. Here is a pre-filled form using the data you entered during your registration to TestApp.");
        ttsOutput.add("Please keep in mind that this pre-filled form doesn't replace the online full-registration procedure that you must complete through the official website of the Spain Asylum Service.");
        ttsOutput.add("You can see the link on the screen.");
        generate(jsonldPath, textResult, displayOutput, ttsOutput);
    }
}
