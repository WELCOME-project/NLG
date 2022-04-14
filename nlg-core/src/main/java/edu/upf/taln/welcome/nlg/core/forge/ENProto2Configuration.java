package edu.upf.taln.welcome.nlg.core.forge;

import java.util.ArrayList;
import java.util.Arrays;

import edu.upf.taln.forge.commons.ForgeException;
    
/**
 *
 * @author rcarlini
 */
public class ENProto2Configuration extends Proto2BaseConfiguration {
    
    public ENProto2Configuration() throws ForgeException {
		super();
		String[] resourcesArr = new String[]{
			"EN_control.dic",
			"EN_language_info.dic",
			"EN_lexicon_SMALL.dic",
			"EN_morphologicon.dic",
			"EN_semanticon.dic",
		};
		ArrayList resources = new ArrayList(Arrays.asList(resourcesArr));
		this.addResources(resources);
    }
}

