@isTest
private class MaintenanceRequestIsTest {
	
	@isTest static void test_method_one() 
	{
		List<Vehicle__c> vehicleList = TestDataFactory.createVehicles(1,'TestVehicle',true,'Economy');
		List<Product2> equipments = TestDataFactory.createEquipments(3,'TestEquipment',true);
		List<Case> caseList = TestDataFactory.createCases(1,'Repair',true,vehicleList,equipments);
		List<Case> casesToUpdate = new List<Case>();

		for(Case newCase: caseList)
		{
			newCase.Subject += 'negative';
			casesToUpdate.add(newCase);
		}
		update casesToUpdate;
		List<Case> newCasesCreated = new List<Case>();
		newCasesCreated = [SELECT Id FROM Case WHERE Type = 'Routine Maintenance' AND
		Date_Reported__c = today];
		System.assertEquals(0,newCasesCreated.size());

		List<Work_Part__c> workParts = TestDataFactory.createWorkParts(caseList,equipments,3,true);

		casesToUpdate.clear();
		for(Case newCase: caseList)
		{
			newCase.Status = 'Closed';
			newCase.Reason = 'Breakdown';
			casesToUpdate.add(newCase);
		}
		update casesToUpdate;
		newCasesCreated.clear();
		newCasesCreated = [SELECT Id,Vehicle__c,Equipment__c,Date_Due__c FROM Case WHERE Type = 'Routine Maintenance' AND
		Date_Reported__c = today];
		List<Work_Part__c> newWorkParts = [SELECT Id FROM Work_Part__c WHERE Maintenance_Request__c =:
		newCasesCreated[0].Id ];
		System.assertEquals(1,newCasesCreated.size());
		System.assertEquals(caseList[0].Vehicle__c,newCasesCreated[0].Vehicle__c);
		System.assertEquals(caseList[0].Equipment__c,newCasesCreated[0].Equipment__c);
		System.assertEquals(Date.today().addDays(10),newCasesCreated[0].Date_Due__c);
		System.assertEquals(3,newWorkParts.size());

		List<Case> caseForCov = TestDataFactory.createCases(1,'Repair',true,vehicleList,null);
		caseForCov[0].Status = 'Closed';
		caseForCov[0].Reason = 'Breakdown';
		update caseForCov;
	}
	
	@isTest static void test_method_two() {
		List<Vehicle__c> vehicleList = TestDataFactory.createVehicles(1,'TestVehicle',true,'Economy');
		List<Product2> equipments = TestDataFactory.createEquipments(3,'TestEquipment',true);
		List<Case> caseList = TestDataFactory.createCases(300,'Repair',true,vehicleList,equipments);
		List<Case> casesToUpdate = new List<Case>();
		List<Case> newCasesCreated = new List<Case>();
		for(Case newCase: caseList)
		{
			newCase.Status = 'Closed';
			newCase.Reason = 'Breakdown';
			casesToUpdate.add(newCase);
		}
		update casesToUpdate;
		newCasesCreated = [SELECT Id,Vehicle__c,Equipment__c,Date_Due__c FROM Case WHERE Type = 'Routine Maintenance' AND
		Date_Reported__c = today];
		//List<Work_Part__c> newWorkParts = [SELECT Id FROM Work_Part__c WHERE Maintenance_Request__c =:
		//newCasesCreated[0].Id ];
		System.assertEquals(300,newCasesCreated.size());
		//System.assertEquals(caseList[0].Vehicle__c,newCasesCreated[0].Vehicle__c);
		//System.assertEquals(caseList[0].Equipment__c,newCasesCreated[0].Equipment__c);
		//System.assertEquals(Date.today().addDays(10),newCasesCreated[0].Date_Due__c);
		//System.assertEquals(3,newWorkParts.size());
		
	}
	
}