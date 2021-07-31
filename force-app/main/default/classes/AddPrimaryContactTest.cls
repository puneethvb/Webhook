@isTest
private class AddPrimaryContactTest
{
	
	@isTest static void testcontact()
	{
		List<Account> accList1 = PrepareTestData.prepareAccounts('ancderf',50,false);
		for(Account a:accList1)
		a.BillingState = 'CA';
		insert accList1;

		List<Account> accList2 = PrepareTestData.prepareAccounts('anbdf',50,false);
		for(Account a:accList2)
		a.BillingState = 'NY';
		insert accList2;

		Test.startTest();
		//Contact sampleCon = new Contact(LastName = 'Test Contact');
		AddPrimaryContact apc = new AddPrimaryContact(new Contact(LastName = 'Test Contact'),'CA');
		System.enQueueJob(apc);
		Test.stopTest();
		System.assertEquals(50,[SELECT count() From Contact WHERE AccountId IN :accList1]);

	}	
}