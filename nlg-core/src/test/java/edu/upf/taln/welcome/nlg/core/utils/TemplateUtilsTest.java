package edu.upf.taln.welcome.nlg.core.utils;
    
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import edu.upf.taln.forge.core.template.GenerationTemplate;
import edu.upf.taln.forge.core.template.TemplateCollection;
import edu.upf.taln.forge.core.template.TemplateEntry;
import edu.upf.taln.forge.core.template.utils.TemplateUtils;

/**
 *
 * @author rcarlini
 */
public class TemplateUtilsTest {
    
    //@Test
    public void testTemplateGeneration() throws IOException, Exception {
		String basePath = "src/main/resources/forge/";
		
        File conllFile = new File(basePath, "220117_WELCOME_templates.conll");
        TemplateCollection collection = TemplateUtils.extractFromConll(conllFile);
        
        File templateFile = new File(basePath, "generated_templates.json");
        
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, true);
        mapper.writerWithDefaultPrettyPrinter().writeValue(templateFile, collection);
        
        Map<String, List<String>> mapping = new HashMap<>();
        for (String key : collection.getTemplates().keySet()) {
            GenerationTemplate template = collection.getTemplate(key);
            
            String name = "[not found]";
            for(TemplateEntry entry : template.getEntries()) {
                String form = entry.getForm();
                if (form.startsWith("[")) {
                    name = form.replace("[", "").replace("]", "");
                }
            }
        
            List<String> values = mapping.getOrDefault(name, new ArrayList<>());
            values.add(key);
            mapping.put(name, values);
        }
        
        File mappingFile = new File(basePath, "generated_mapping.json");
        mapper.writerWithDefaultPrettyPrinter().writeValue(mappingFile, mapping);
    }
    
    
}
