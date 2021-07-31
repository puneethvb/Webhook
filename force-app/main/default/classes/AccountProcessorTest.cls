@isTest
private class AccountProcessorTest
{
	
	@isTest static void testgetCount()
	{
		Account acc = new Account(Name='testing something');
		insert acc;
		List<Contact> conList = PrepareTestData.PrepareContacts('abc',5,false);
		for(Contact cc: conList)
		cc.AccountId = acc.Id;
		insert conList;
		List<Id> accIds = new List<Id>();
		accIds.add(acc.Id);
		System.Test.startTest();
		AccountProcessor.countContacts(accIds);
		System.Test.stopTest();
		Account updAcc = [SELECT Number_of_Contacts__c FROM Account WHERE Id =:acc.Id];
		System.assertEquals(5,updAcc.Number_of_Contacts__c);
	}
	
	
}