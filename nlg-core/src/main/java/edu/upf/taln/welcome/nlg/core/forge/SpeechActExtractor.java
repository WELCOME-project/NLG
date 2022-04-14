package edu.upf.taln.welcome.nlg.core.forge;

import java.io.File;
import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;
import edu.upf.taln.forge.core.template.TemplateData;

import edu.upf.taln.forge.core.template.TemplateDataCollection;
import edu.upf.taln.forge.core.template.utils.DataExtractor;
import edu.upf.taln.welcome.dms.commons.input.Slot;
import edu.upf.taln.welcome.dms.commons.output.SpeechAct;

/**
 *
 * @author rcarlini
 */
public class SpeechActExtractor implements DataExtractor<SpeechAct> {

	private static final ObjectMapper mapper = new ObjectMapper();

	public SpeechActExtractor() {
	}

	@Override
	public SpeechAct loadData(File inputFile) throws IOException {
		SpeechAct input = mapper.readValue(inputFile, SpeechAct.class);
		return input;
	}

	@Override
	public TemplateDataCollection extractData(File inputFile) throws IOException {
		SpeechAct input = loadData(inputFile);
		TemplateDataCollection data = extractData(input);
		return data;
	}

	@Override
	public TemplateDataCollection extractData(SpeechAct input) {
        TemplateDataCollection dataCollection = new TemplateDataCollection();

		Slot slot = input.slot;
		switch(slot.id) {
			case "frs:obtainName":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("stateName");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
//			case "obtainNameConfirmation":
//				break;
			case "frs:obtainFirstSurname":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("stateFirstSurname");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
//			case "obtainFirstSurnameConfirmation":
//				break;
			case "frs:obtainSecondSurname":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("stateSecondSurname");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
//			case "obtainSecondSurnameConfirmation":
//				break;
//			case "obtainConfirmationUpdateAddress":
//				break;
			case "pps:obtainCity":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("city");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainStreetName":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("streetName");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainStreetType":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("streetType");
				String streetName = "[no_name_found]";
				templateData.putVariable("streetName", streetName);
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainStreetNumber":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("giveStreetNumber");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainBuildingName":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("buildingName");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainEntrance":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("entranceName");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainBuildingType":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("buildingType");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainFloorNumber":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("floor");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
//			case "obtainApartmentNumber":
//				break;
			case "frs:obtainPostCode":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("postalCode");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainProvince":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("province");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
			case "frs:obtainMunicipality":
			{
				TemplateData templateData = new TemplateData();
				templateData.setTemplateKey("municipality");
				dataCollection.put(templateData.getTemplateKey(), templateData);
			}
				break;
//			case "obtainMoreDegreeTitle":
//				break;
//			case "obtainMoreDegreeCertificate":
//				break;
//			case "obtainMoreSchool":
//				break;
//			case "obtainMoreYear":
//				break;
//			case "obtainCurrentOccupation":
//				break;
//			case "obtainEmployerName":
//				break;
//			case "obtainEmployerAddress":
//				break;
//			case "obtainStartingDate":
//				break;
//			case "obtainMainActivities":
//				break;
//			case "obtainPreviousOccupation":
//				break;
//			case "obtainPreviousEmployerName":
//				break;
//			case "obtainPreviousEmployerAddress":
//				break;
//			case "obtainPreviousStartingDate":
//				break;
//			case "obtainPreviousEndDate":
//				break;
//			case "obtainPreviousMainActivities":
//				break;
//			case "obtainDrivingLicense":
//				break;
//			case "obtainCar":
//				break;
			default:
				break;
		}
		
		return dataCollection;
	}
	
}
