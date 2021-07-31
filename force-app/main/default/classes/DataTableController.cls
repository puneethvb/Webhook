public with sharing class DataTableController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Industry, AnnualRevenue,Phone FROM Account WHERE AnnualRevenue > 0 LIMIT 10];
    }
}