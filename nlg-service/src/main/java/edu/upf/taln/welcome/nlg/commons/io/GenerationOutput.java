package edu.upf.taln.welcome.nlg.commons.io;

import javax.validation.constraints.NotNull;

/**
 *
 * @author rcarlini
 */
public class GenerationOutput {
    
    @NotNull
    private String conll;

    public String getConll() {
        return conll;
    }

    public void setConll(String conll) {
        this.conll = conll;
    }    
}
