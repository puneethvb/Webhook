public with sharing class BatchSample implements Database.batchable<sObject> {

    public Database.queryLocator start(Database.batchableContext BC){
        return Database.getQueryLocator('SELECT ID FROM Account');
    }

    public void execute(Database.batchableContext BC, List<SObject> scope){
        system.debug('inside execute');
    }

    public void finish(Database.batchableContext BC){
        
    }
    

}