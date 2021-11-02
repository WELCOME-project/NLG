package edu.upf.taln.welcome.nlg.commons.output;

import java.util.List;

/**
 *
 * @author rcarlini
 */
public class GenerationOutput {
	
	public enum ChunkType {Slot, Sentence, Paragraph};
	
    private String text;
    private List<String> chunks;
	private ChunkType chunkType;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }     

	public List<String> getChunks() {
        return chunks;
    }

    public void setChunks(List<String> chunks) {
        this.chunks = chunks;
    }

	public ChunkType getChunkType() {
		return chunkType;
	}

	public void setChunkType(ChunkType chunkType) {
		this.chunkType = chunkType;
	}
}
