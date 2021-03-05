package edu.upf.taln.welcome.nlg.core;

import com.ibm.icu.util.ULocale;
import edu.upf.taln.welcome.dms.commons.exceptions.WelcomeException;
import edu.upf.taln.welcome.dms.commons.input.Slot;
import edu.upf.taln.welcome.dms.commons.output.DialogueMove;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;
import edu.upf.taln.welcome.dms.commons.output.SpeechActLabel;

import java.util.logging.Logger;
import java.util.stream.Collectors;

public class LanguageGenerator {
    private final ULocale language;
    private final Logger logger = Logger.getLogger(LanguageGenerator.class.getName());

    public LanguageGenerator(ULocale language)
    {
        this.language = language;
    }

    public String generate(DialogueMove move)
    {
        return move.speechActs.stream()
                .map(act -> {
                    if (!hasTemplateId(act.slot) && !hasRDFContents(act.slot))
                        return getCannedText(act);
                    else if (hasTemplateId(act.slot))
                        return getTemplateText(act);
                    else
                        return getGeneratedText(act);

                }) // only canned text supported at the moment
                .collect(Collectors.joining(". "));
    }

    private boolean hasTemplateId(Slot slot)
    {
        if (slot.template == null || slot.template.isEmpty())
            return false;
        else return slot.template.get(0) != null && !slot.template.get(0).id.isEmpty();
    }

    private boolean hasRDFContents(Slot slot)
    {
        if (slot.rdf == null || slot.rdf.isEmpty())
            return false;
        else return !slot.rdf.get(0).isEmpty() && !slot.rdf.get(0).contains("welcome:Unknown");
    }

    private String getCannedText(SpeechAct act)
    {
        try {
            if (act.label == SpeechActLabel.Apology || act.label == SpeechActLabel.Conventional_opening ||
                    act.label == SpeechActLabel.Conventional_closing) {
                return CannedTexts.get(language, act.label.toString());
            } else {
                return CannedTexts.get(language, act.slot.id);
            }
        }
        catch (WelcomeException e)
        {
            logger.severe("Failed to find canned text for speech act " + act.label + "-" + act.slot.type);
            return "";
        }
    }

    private String getTemplateText(SpeechAct act)
    {
        return ""; // not implemmented yet
    }

    private String getGeneratedText(SpeechAct act)
    {
        return ""; // not implemmented yet
    }

}
