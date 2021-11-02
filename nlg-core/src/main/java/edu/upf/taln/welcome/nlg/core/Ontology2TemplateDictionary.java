package edu.upf.taln.welcome.nlg.core;

import java.util.HashMap;
import java.util.Map;

public class Ontology2TemplateDictionary {
	private static Ontology2TemplateDictionary instance = null;
	private final Map<String, String> dictionary = new HashMap<>();

    private Ontology2TemplateDictionary()
    {
    	String base = "https://raw.githubusercontent.com/gtzionis/WelcomeOntology/main/welcome.ttl#";
        dictionary.put(base + "Name", "STNamePartName");
        dictionary.put(base + "FirstSurname", "STNamePartSurnames");
        dictionary.put(base + "Birthday", "STBirthdayPartBirthday");
        dictionary.put(base + "BirthMonth", "STBirthdayPartBirthMonth");
        dictionary.put(base + "BirthYear", "STBirthdayPartBirthYear");
        dictionary.put(base + "Country", "STLocationPartCountry");
        dictionary.put(base + "CountryOfBirth", "STLocationPartCountryOfBirth");
        dictionary.put(base + "City", "STLocationPartCity");
        dictionary.put(base + "CityOfBirth", "STLocationPartCityOfBirth");
        dictionary.put(base + "StreetName", "STLocationStreet");
        dictionary.put(base + "StreetNumber", "STLocationStreetNumber");
    }
    public static Ontology2TemplateDictionary getInstance() {
    	if (instance == null) {
    		instance = new Ontology2TemplateDictionary();
    	}
    	return instance;
    }
    
    public String get(String ontologyValue) { return dictionary.get(ontologyValue); }
}
