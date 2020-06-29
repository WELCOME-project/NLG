package edu.upf.taln.welcome.nlg.commons.io;

public class GenerationInput {
    private InputMetadata metadata;
    private InputData data;

    public InputMetadata getMetadata() {
        return metadata;
    }

    public void setMetadata(InputMetadata metadata) {
        this.metadata = metadata;
    }

    public InputData getData() {
        return data;
    }

    public void setData(InputData data) {
        this.data = data;
    }
}
