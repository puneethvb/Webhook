global class Test_Batch_Static implements Database.Batchable<sObject>,Database.Stateful {
	

	public Map<String,String> stringMap = new Map<String,String>();
	global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM Account';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
	
	system.debug('StringMap:'+stringMap);
	batchService.popMap(stringMap);
	system.debug('StringMap:'+stringMap);
	}
	
	global void finish(Database.BatchableContext BC) {

		system.debug('Map value: '+ stringMap);
		
	}
	
}