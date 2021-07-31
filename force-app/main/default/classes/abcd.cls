global class abcd implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {

global Database.QueryLocator start(Database.BatchableContext info) {

String Query = 'Select id From Account LIMIt 10';
return Database.getQueryLocator(query);

}
 global void execute(Database.BatchableContext BC, list<sObject>sOlist) {
 
 system.debug('1');
 }
 global void finish(Database.BatchableContext BC) {
 }
}