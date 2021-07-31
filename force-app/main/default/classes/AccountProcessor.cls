public with sharing class AccountProcessor
{
	@future
	public static void countContacts(List<Id> accountIds)
	{
		 List<Account> listOfAccounts = [SELECT Id,Name,Number_of_Contacts__c FROM Account WHERE Id IN :accountIds];
		 //Map<Id,List<Contact>> accConMap = new Map<Id,List<Contact>>();
		 List<Contact> listOfContacts = [SELECT AccountId FROM Contact WHERE AccountId IN :accountIds];
		 for(Account acc:listOfAccounts)
		 {
		 	acc.Number_of_Contacts__c = 0;
		 	for(Contact cc:listOfContacts)
		 	{
		 		if(cc.AccountId == acc.Id)
		 		acc.Number_of_Contacts__c += 1;
		 	}

		 }

		 update listOfAccounts;

	}
}