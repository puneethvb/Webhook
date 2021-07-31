public class LeadProcessor implements Database.Batchable<sObject>,Database.Stateful
{
	
	String query;
	public Integer leadsProcessed = 0;	

	public Database.QueryLocator start(Database.BatchableContext BC)
	{
		query = 'SELECT LeadSource FROM Lead';		
		return Database.getQueryLocator(query);
	}

   	public void execute(Database.BatchableContext BC, List<Lead> scope)
   	{
   		for(Lead lead:scope)
   		lead.LeadSource = 'Dreamforce';
   		update scope;	
   		leadsProcessed+=1;
	}
	
	public void finish(Database.BatchableContext BC)
	{
		System.debug(leadsProcessed);
	}
	
}