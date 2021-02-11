package edu.upf.taln.welcome.nlg.core;

import com.ibm.icu.util.ULocale;
import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;

import java.util.HashMap;
import java.util.Map;

public class CannedTexts
{
    private final static Map<ULocale, Map<String, String>> texts = new HashMap<>();

    // English
    static {
        Map<String, String> enTexts = new HashMap<>();
        // speech acts
        enTexts.put("Acknowledge_Backchannel", "I see");
        enTexts.put("Agree_or_Accept", "Yes, that's right");
        enTexts.put("Yes_answers", "Yes");
        enTexts.put("Conventional-closing", "It's been nice talking to you. Bye!");
        enTexts.put("No_answers", "No");
        enTexts.put("Response_Acknowledgement", "Ok, I understand");
        enTexts.put("Backchannel_in_question_form", "Is that so?");
        enTexts.put("Affirmative_non_yes_answers", "It is");
        enTexts.put("Reject", "I'm afraid this is not possible");
        enTexts.put("Negative_non_no_answers", "Not really");
        enTexts.put("Signal-non-understanding", "I did not understand you, could you please repeat?");
        enTexts.put("Conventional-opening", "Hi!");
        enTexts.put("Tag-Question", "Right?");
        enTexts.put("Apology", "I'm sorry");
        enTexts.put("Thanking", "Thank you very much");
        // slots
        enTexts.put("confirmCommunication", "Can you hear me?");
        enTexts.put("confirmLanguage", "You speak English, is that correct?");
        enTexts.put("obtainRequest", "How can I help you?");
        enTexts.put("obtainName", "What is your name?");
        enTexts.put("obtainStatus", "First of all, I need to know if you already registered");
        enTexts.put("obtainInterest", "Do you want me to inform you on the First Reception Service?");
        enTexts.put("ObtainInterestRegistration", "Would you like to register?");
        enTexts.put("InformDetailsCompletion", " A module is completed if you attend, at least 75% of the classes");
        enTexts.put("InformDetailsLanguage", "In case you can speak and understand Catalan or Spanish or you have a certificate proving that you already completed a course, you won’t have to take that specific module");
        enTexts.put("InformDetailsTime", "You can take each module separately and you have 2 years to complete them all");
        enTexts.put("InformDetailsValue", "If you apply, you will have access to a set of basic tools that will help you become part of the Catlan society. The certificate can also be useful for job search as an added value to your skills and experience. Furthermore, the Reception Certificate could be used in legal immigration requirements like social ties, modification and/or renewal of residence authorizations, among others");
        enTexts.put("InformLabourModule", "Module B. Labour market knowledge, which consists of a 15h course on labour market and employment");
        enTexts.put("InformLabourModuleAddress", "Module B is offered at the City Council building");
        enTexts.put("InformLabourModuleHours", "Module B is given on Wednesdays from 19:00 to 21:00");
        enTexts.put("InformLanguageModule", "Module A. Languages, which consists of a 90 h Catalan and 90 h Spanish course");
        enTexts.put("InformLanguageModuleAddress", "Module A is offered at nearby Col·legi Sagrat Cor");
        enTexts.put("InformLanguageModuleHours", "Module A is given on Mondays and Fridays from 19:00 to 21:00");
        enTexts.put("InformOverview", "The First Reception Service consists of a number of initial training and information activities especially designed for its users. It includes counselling, initial adult training, and certification of basic skills and competences to make living and working in Catalonia easier. There are three different modules");
        enTexts.put("InformSocietyModule", "Module C. Catalan Society, which consists of a 15 h course specifically on your municipality and the services you can apply for");
        enTexts.put("InformSocietyModuleAddress", "Module C is offered at the City Council building");
        enTexts.put("InformSocietyModuleHours", "Module C is given on Wednesdays from 19:00 to 21:00");
        texts.put(ULocale.ENGLISH, enTexts);
    }


    static String get(ULocale language, String key) throws WelcomeException {
        if (!texts.containsKey(language))
            throw new WelcomeException("Language not supported: " + language.getBaseName());
        if (!texts.get(language).containsKey(key))
            throw new WelcomeException("No canned text found for key: " + key + " (" + language.getBaseName() + ")");
        return texts.get(language).get(key);
    }
}
