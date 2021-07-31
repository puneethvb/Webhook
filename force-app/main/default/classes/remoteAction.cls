public with sharing class remoteAction {
    
    @remoteAction
    public static Account findAccount(String accName){

        Account acc = [SELECT Industry FROM Account WHERE name = :accName LIMIT 1];
        return acc;

    }
}