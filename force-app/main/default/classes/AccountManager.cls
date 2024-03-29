@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager
{
	
	@HttpGet
	global static Account getAccount()
	{
		//AccountandContacts result = new AccountandContacts();
		RestRequest request = RestContext.request;
		String accountId = request.requestURI.subStringBetween('/Accounts/','/contacts');
		Account acc = [SELECT Id,Name,(SELECT Id,Name FROM Contacts) FROM Account WHERE Id =:accountId];
		return acc;
	}
}