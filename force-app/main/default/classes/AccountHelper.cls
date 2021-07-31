public with sharing class AccountHelper {
    
    @AuraEnabled(cacheable = true)
    public static List<Account> fetchAccountLocations(){
       
        return [SELECT Id, Name, BillingStreet, BillingCity, BillingState, 
                BillingPostalCode, BillingCountry FROM Account WHERE 
                BillingPostalCode!=null AND BillingCity!= null LIMIT 10];

    }
}