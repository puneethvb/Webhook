trigger ContactValidateCheck on Contact (after insert,after update, after delete,after undelete)
{
	List<Id> accIds = new List<Id>();
	List<Account> accList = new List<Account>();
	//List<Account>accListToUpdate = new List<Account>();
	
	if(Trigger.isInsert|| Trigger.isUpdate || Trigger.isUndelete)
	{
	  for(Contact c : Trigger.new)
	  accIds.add(c.AccountId);
	}
	
	else if(Trigger.isDelete)
	{
	  for(Contact c : Trigger.old)
	  accIds.add(c.AccountId);
	}

	accList = [SELECT Id,Validated__c,(SELECT Id,Validated__c FROM Contacts) FROM Account WHERE Id IN :accIds];
	for(Account a : accList)
	{
		a.Validated__c = false;
		for(Contact accCon: a.Contacts)
		{
			if(accCon.Validated__c)
			{
				a.Validated__c = true;
				break;
			}
		}
	}
	update accList;
}