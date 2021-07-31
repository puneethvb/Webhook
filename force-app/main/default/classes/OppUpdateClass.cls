public with sharing class OppUpdateClass {
    public OppUpdateClass() {

    }

    @AuraEnabled
    public static string updateOpp(String oppId, String accId, String casId){
        try {
            Opportunity opp = [SELECT Id,accountId FROM Opportunity where ID = :oppId ];
            opp.accountId = accId;
            update opp;
            return 'Success';            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
}