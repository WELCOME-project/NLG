package edu.upf.taln.welcome.nlg.core.forge;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.configuration.BaseConfiguration;
import org.apache.commons.configuration.PropertiesConfiguration;

import edu.upf.taln.buddy.model.project.ProjectConfiguration;
import edu.upf.taln.buddy.util.MATEException;

import edu.upf.taln.forge.core.configuration.GenerationProjectConfiguration;
import edu.upf.taln.forge.commons.ForgeException;


/**
 *
 * @author rcarlini
 */
public abstract class Proto2BaseConfiguration implements GenerationProjectConfiguration {

	public static final String PROTO2_TEMPLATES_PATH = "/forge/generated_templates.json";

	private List<String> grammars;
	private ArrayList<String> resources;
	private PropertiesConfiguration mainConf;
	private BaseConfiguration levelConf;

    public Proto2BaseConfiguration() throws ForgeException {
        loadBuddyConfig();
    }
	
    protected final void loadBuddyConfig() {

		String[] grammarsArr = new String[] {
			"10_Con_Sem.rl",
			"11_1_Con_Agg1.rl",
			"11_2_Con_Agg2.rl",
			"11_3_Con_Agg3.rl",
			"11_4_Con_Agg4.rl",
			"13_Sem_SemPoS.rl",
			"15_SemPoS_SemCommMark.rl",
			"17_SemCommMark_SemComm.rl",
			"20_SemComm_DSynt.rl",
			"30_DSynt_SSynt.rl",
			"35_SSynt_PostProc.rl",
			"37_1_SSynt_Agg1.rl",
			"37_2_SSynt_Agg2.rl",
			"40_SSynt_DMorph_linearize.rl",
			"50_DMorph_SMorph.rl",
			"60_Smorph_Sentence.rl"
		};
		this.grammars = new ArrayList(Arrays.asList(grammarsArr));

		String[] resourcesArr = new String[]{
			"EN_lexicon_MS.dic",
			"concepticon.dic",
			"project_WELCOME.dic",
		};
		this.resources = new ArrayList(Arrays.asList(resourcesArr));

		this.mainConf = new  PropertiesConfiguration();
		mainConf.setProperty("projectDir", "/forge/proto2");
		mainConf.setProperty("encoding", "UTF8");
		mainConf.setProperty("skipErrors", "false");
		mainConf.setProperty("ruleSets", String.join(", ", grammars));
		mainConf.setProperty("resources", String.join(", ", resources));
		mainConf.setProperty("allowOverlaps", "true");
		mainConf.setProperty("concatenate", "true");

		this.levelConf = new BaseConfiguration();
		levelConf.setProperty("level.Sem", "sem");
		levelConf.setProperty("level.SSynt", "slex");
		levelConf.setProperty("level.DSynt", "dlex");
		levelConf.setProperty("level.Level", "name");
		levelConf.setProperty("level.OtherLevel", "otherName");

		levelConf.setProperty("map.SSynt", "SSynt, SSyntLin, SSyntDPro, DSynt, DMorph");
		levelConf.setProperty("map.DSynt", "SSynt, DSynt, DSyntDAgg, Sem");
		levelConf.setProperty("map.Sem", "DSynt");
		levelConf.setProperty("map.Level", "OtherLevel");
    }
	
	public void setGrammars(List<String> newGrammars) {
		this.grammars = newGrammars;
		mainConf.setProperty("ruleSets", String.join(", ", this.grammars));		
	}
	
	public void addResources(List<String> newResources) {
		this.resources.addAll(newResources);
		mainConf.setProperty("resources", String.join(", ", this.resources));		
	}
	
	@Override
	public String getTemplatePath() {
		return PROTO2_TEMPLATES_PATH;
	}

	@Override
	public ProjectConfiguration getBuddyConfiguration() throws ForgeException {
            
		try {
			ProjectConfiguration projectConf = ProjectConfiguration.loadProjectInfo(mainConf, levelConf);
			projectConf.setPackagedProject(true);
			
			return projectConf;
			
		} catch (MATEException ex) {
            throw new ForgeException("Exception raised while loading Buddy project.", ex);
		}
	}
	
}

