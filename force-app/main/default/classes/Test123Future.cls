global class Test123Future implements Database.Batchable<sObject> {
	
	String query;
	
	global Test123Future() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id FROM Account';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
	
	System.debug('Gonna call future now');
    futureTest.iAmFutureMethod();

	}
	
	global void finish(Database.BatchableContext BC) {
	system.debug('I am Finish Mthod');	
	}

	@future
	public static void iAmFutureMethod(){
		system.debug('I am the futre method');
	}
	
}