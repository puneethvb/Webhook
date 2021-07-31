@isTest
public without sharing class TestDataFactory
{
	public static List<Vehicle__c> createVehicles(Integer count, String nameString,
		Boolean insertRecords,String typeOfVeh) 
	{
		List<Vehicle__c> listOfVehicles = new List<Vehicle__c>();
		for(Integer i =0;i<count;i++)
		{
			Vehicle__c newVehicle = new Vehicle__c();
			newVehicle.Name = nameString + i;
			newVehicle.Type__c = typeOfVeh;
			listOfVehicles.add(newVehicle);
		}

		if(insertRecords)
		{
			insert listOfVehicles;
		}

		return listOfVehicles;
	}

	public static List<Product2> createEquipments(Integer count, String nameString,
		Boolean insertRecords,List<String> sku)
	{
		List<Product2> equipmentList = new List<Product2>();
		for(Integer i =0; i<count;i++)
		{
			Product2 newProduct = new Product2();
			newProduct.Name = nameString + i;
			newProduct.isActive = true;
			newProduct.Cost__c = 100;
			newProduct.Replacement_Part__c = true;
			newProduct.Current_Inventory__c = 10;
			newProduct.Lifespan_Months__c   = 3;
			newProduct.Maintenance_Cycle__c	= i+10;
			if(sku!=null)
			newProduct.Warehouse_SKU__c = sku[i];
			equipmentList.add(newProduct);
		}

		if(insertRecords)
		{
			insert equipmentList;
		}
		return equipmentList;
	}

	public static List<Case> createCases(Integer count, String typeOfCase,
		Boolean insertRecords,List<Vehicle__c> listOfVehicles,List<Product2> equipmentList)
	{
		List<Case> caseList = new List<Case>();
		Integer vehicIndex = 0;
		Integer equipIndex = 0;
		for(Integer i = 0; i<count; i++)
		{
			Case newCase = new Case();
			newCase.Type = typeOfCase;
			if(vehicIndex>=listOfVehicles.size())
			vehicIndex = 0;
			newCase.Vehicle__c = listOfVehicles[vehicIndex].Id;
			if(equipmentList!=null)
			{
				if(equipIndex>= equipmentList.size())
			    equipIndex = 0;		
			    newCase.Equipment__c = equipmentList[equipIndex].Id;
			    equipIndex++;

			}
			
			vehicIndex++;
			
            newCase.Subject = 'Repair or Future Maintenance Request';
            newCase.Date_Reported__c = System.Date.today().addDays(-20);
            newCase.Date_Due__c = System.Date.today();
            caseList.add(newCase);
		}
		if(insertRecords)
		{
			insert caseList;
		}
		return caseList;
	}

	public static List<Work_Part__c> createWorkParts(List<Case> caseList, List<Product2> equipmentList,Integer count,
		Boolean insertRecords)
	{
		List<Work_Part__c> workParts = new List<Work_Part__c>();
		Integer numOfCases = caseList.size();
		for(Integer i =0; i<numOfCases;i++)
		{
			for(Integer x = 0; x<count;x++)
			{
				Work_Part__c newWorkPart = new Work_Part__c();
				newWorkPart.Maintenance_Request__c = caseList[i].id;
				newWorkPart.Equipment__c = equipmentList[x].Id;
				newWorkPart.Quantity__c = i+10;
				workParts.add(newWorkPart);
			}
		}
		if(insertRecords)
		{
			insert workParts;
		}

		return workParts;
	}
}