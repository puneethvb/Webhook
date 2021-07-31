@isTest
private class ProjectCalloutServiceTest {

	@isTest
	static void testSuccessCall(){

		Account acc = new Account();
		acc.Name = 'AbcdEfhjll';
		insert acc;

		Opportunity opp = new Opportunity();
		opp.Name = 'test123456';
		opp.StageName = 'Submitted Project';
		opp.AccountId = acc.Id;
		opp.Amount = 500;
		opp.CloseDate = System.Date.today();
		opp.Type = 'New Project';
		insert opp;

		ServiceTokens__c sToken = new ServiceTokens__c();
		sToken.Name = 'ProjectServiceToken';
		sToken.Token__c = 'qqqqqqqqqqq';
		insert sToken;

		Test.setMock(HttpCalloutMock.Class, new ProjectCalloutServiceMock());

		Test.startTest();
		
		List<Id> oppList1 = new List<Id>();
		oppList1.add(opp.Id);
		ProjectCalloutService.postOpportunityToPMS(oppList1);
		Test.stopTest();
		List<Opportunity> oppList = [SELECT Id,StageName FROm Opportunity];
		System.assertEquals('Submitted Project',oppList[0].StageName);

	}

	@isTest
	static void testfailCall(){

		Account acc = new Account();
		acc.Name = 'AbcdEfhjll';
		insert acc;

		Opportunity opp = new Opportunity();
		opp.Name = 'test123456';
		opp.StageName = 'ReSubmit Project';
		opp.AccountId = acc.Id;
		opp.Amount = 500;
		opp.CloseDate = System.Date.today();
		opp.Type = 'New Project';
		insert opp;

		ServiceTokens__c sToken = new ServiceTokens__c();
		sToken.Name = 'ProjectServiceToken';
		sToken.Token__c = 'qqqqqqqqqqq';
		insert sToken;

		Test.setMock(HttpCalloutMock.Class, new ProjectCalloutServiceMock());

		Test.startTest();
		
		List<Id> oppList1 = new List<Id>();
		oppList1.add(opp.Id);
		ProjectCalloutService.postOpportunityToPMS(oppList1);
		Test.stopTest();
		List<Opportunity> oppList = [SELECT Id,StageName FROm Opportunity];
		System.assertEquals('Resubmit Project',oppList[0].StageName);

	}
}