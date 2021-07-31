public with sharing class RefreshContacttController {
   
    @AuraEnabled(cacheable=true)
    public static List<Contact> fetchContacts(){
        
        return [SELECT Id, FirstName, LastName, Email FROM Contact LIMIT 10];
    }


}