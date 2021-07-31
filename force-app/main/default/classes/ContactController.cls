public with sharing class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){        
        try{
            Integer i = 1/0;
            system.debug([SELECT Id,FirstName, LastName, Email FROM Contact]);
            return [SELECT Id,FirstName, LastName, Email FROM Contact];

        }
       catch(Exception ex){
           throw new AuraHandledException(ex.getMessage());
       }

    }


}