global class AccountTestBatch implements Database.Batchable<sObject>,Database.Stateful {
	
	String query;
	public Integer i =0;
	public List<Account> accList = new List<Account>();
	

	global AccountTestBatch(){
		//accList = new List<Account>();
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id,Name FROM Account LIMIT 10';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Account> scope)
   	{
       Account a = scope[0];
       i++;
       if(i==4)
       a.name = '';
       else 
       a.name= a.name+' updated';
       update a;
       accList.add(a);
	   futureTest();
	
	}
	
	global void finish(Database.BatchableContext BC) {

		System.debug(accList.size());
		
	}
	
	@future
	public static void futureTest(){
		System.debug('hjhjhjhj');
	}
}