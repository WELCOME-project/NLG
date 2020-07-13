package edu.upf.taln.welcome.nlg.commons.input;

import edu.upf.taln.welcome.dms.commons.output.DMOutput;

public class GenerationInput {
    private InputMetadata metadata;
    private DMOutput data;

    public InputMetadata getMetadata() {
        return metadata;
    }

    public void setMetadata(InputMetadata metadata) {
        this.metadata = metadata;
    }

    public DMOutput getData() {
        return data;
    }

    public void setData(DMOutput data) {
        this.data = data;
    }
}
