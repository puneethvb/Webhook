public with sharing class PaginationDemoController {
    

    @AuraEnabled(cacheable=true)
    public static List<Contact> fetchContacts(){
        
        return [SELECT Id, Name FROm Contact];
    }
}
