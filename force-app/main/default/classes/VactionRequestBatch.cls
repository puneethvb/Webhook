public without sharing class VactionRequestBatch implements Database.Batchable<sObject> 
{
	
	String query;
	User_Feedback__c vacRequest = new User_Feedback__c();
	List<Id> errorList = new List<Id>();

	
	public Database.QueryLocator start(Database.BatchableContext BC) 
	{
		query = 'SELECT Id,Backup_PSL__c,Transfer_Completed__c,Transfer_Tasks__c,Backup_PSL__r.Id,Vacation_Requestor__r.Id,';
		query+= 'Vacation_Cancelled__c,Vacation_End_Date__c,Vacation_Requestor__c,';
		query+= 'Vacation_Start_Date__c FROM User_Feedback__c';
		return Database.getQueryLocator(query);
	}

   	public void execute(Database.BatchableContext BC, List<sObject> batchObjects)
   	{
   		this.vacRequest = (User_Feedback__c)batchObjects[0];
   		//Process new requests.
   		if(!(this.vacRequest.Transfer_Completed__c && this.vacRequest.Vacation_Cancelled__c))
   		{
   			if(evaluateTransferCriteria(this.vacRequest.Vacation_Start_Date__c))
   			transferRecords(false,this.vacRequest.Vacation_Requestor__r.Id,this.vacRequest.Backup_PSL__r.Id);
   		}
   		else if(this.vacRequest.Transfer_Completed__c && this.vacRequest.Vacation_Cancelled__c)
   		{
   			transferRecords(true,this.vacRequest.Backup_PSL__r.Id,this.vacRequest.Vacation_Requestor__r.Id);
   		}
   		else if(this.vacRequest.Transfer_Completed__c)
   		{
   			if(evaluateTransferCriteria(this.vacRequest.Vacation_End_Date__c))
   			transferRecords(true,this.vacRequest.Backup_PSL__r.Id,this.vacRequest.Vacation_Requestor__r.Id);
   		}
   		else
   		{
   			deleteVacationRequest();
   		}
   	}
	
	public void finish(Database.BatchableContext BC)
	{
		System.debug('Finished Job');
		if(errorList.size()>0)
		System.debug('errors' + errorList);
	}

	private Boolean evaluateTransferCriteria(Date dateToCheck)
	{
		Boolean checkStatus = false;
		if(dateToCheck<=System.today())
		checkStatus = true;
		return checkStatus;
	}

	private void transferRecords(Boolean reTransfer, Id fromUser, Id toUser)
	{
		List<Case> listofCasestoTransfer = new List<Case>();
		listofCasestoTransfer = [SELECT Id,OwnerId FROM Case WHERE IsClosed=false AND OwnerId=:fromUser];
		for(Case c: listofCasestoTransfer)
		{
			c.OwnerId = toUser;
		}
		
		Database.SaveResult[] srList = Database.update(listofCasestoTransfer,false);
		for(Database.SaveResult s1:srList)
		{
			if(!s1.isSuccess())
			this.errorList.add(s1.getId());
		}

		if(reTransfer)
		{
			deleteVacationRequest();
		}
		else
		{
			this.vacRequest.Transfer_Completed__c = true;
			update this.vacRequest;
		}

	}

	private void deleteVacationRequest()
	{
		delete this.vacRequest;
	}
	
}