package edu.upf.taln.welcome.nlg.commons.output;


import javax.validation.constraints.NotNull;

/**
 *
 * @author rcarlini
 */
public class GenerationOutput {
    
    @NotNull
    private String text;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }    
}
