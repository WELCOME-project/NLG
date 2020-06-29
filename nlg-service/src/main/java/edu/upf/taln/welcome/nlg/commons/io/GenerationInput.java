package edu.upf.taln.welcome.nlg.commons.io;

public class GenerationInput {
    private WelcomeMetadata metadata;
    private WelcomeData data;

    public WelcomeMetadata getMetadata() {
        return metadata;
    }

    public void setMetadata(WelcomeMetadata metadata) {
        this.metadata = metadata;
    }

    public WelcomeData getData() {
        return data;
    }

    public void setData(WelcomeData data) {
        this.data = data;
    }
}
