@isTest
private class AccountManagerTest
{
	
	@isTest static void testgetMethod()
	{
		Account acc = new Account(Name ='Test1');
		insert acc;
		Contact cc1 = new Contact(FirstName = 'fscc1',LastName = 'LNCC1',AccountId = acc.Id);
		insert cc1;
		RestRequest request = new RestRequest();
		request.requestURI = 'https://ap5.salesforce.com/services/apexrest/Accounts/' + acc.Id + '/contacts';
		request.httpMethod='GET';
		RestContext.request = request;
		Account result = AccountManager.getAccount();
		System.assert(result!=null);
		System.assertEquals(acc.Id,result.Id);
	}
}