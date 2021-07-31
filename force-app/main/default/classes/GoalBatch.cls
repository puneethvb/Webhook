public with sharing class GoalBatch implements Database.Batchable<SObject>,Database.Stateful,Database.AllowsCallouts
{
	public List<Goal_Qualifier__c> errorList {get;private set;}

	public GoalBatch() 
	{
		this.errorList = new List<Goal_Qualifier__c>();
	}

	public Database.QueryLocator Start(Database.BatchableContext bc)
	{
		String query = 'SELECT ';
		query += 'Id, Name, Account__c, Account__r.Name, Contact__c, Contact__r.Name, Lead__c, Lead__r.Name, ';
		query += 'Opportunity__c, Opportunity__r.Name, Goal_Participant__c, Goal_Participant__r.User__c,'; 
		query += 'Goal_Participant__r.User__r.Name, CreatedDate, Status__c '; 
		query += 'FROM Goal_Qualifier__c '; 
		query += 'WHERE Status__c != \'Complete\' '; 
		query += 'ORDER BY CreatedDate';
		return Database.getQueryLocator(query);
	}

	public void execute(Database.BatchableContext bc,List<SObject> bathObjects)
	{
		Goal_Qualifier__c gq = (Goal_Qualifier__c)bathObjects[0];
		if(GoalBatchExecute.mockCallout(gq))
		{
			gq.Status__c = 'Complete';
		}
		else
		{
			gq.Status__c = 'InComplete';
			this.errorList.add(gq);
		}
		update gq;
	}

	public void finish(Database.BatchableContext bc)
	{
		if(this.errorList.size() > 0)
		System.debug('Not All Completed');
	}
}