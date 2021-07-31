public with sharing class UnlimitedPaginationController {
    

    @AuraEnabled
    public static List<Account> getAccounts(String prevRef, String nextRef, Integer recordsLimit){
        
        String query =  'SELECT ID, Name, AccountReference__c, Site FROM Account';
        query = (prevRef == null && nextRef == null) ? query+= ' Order By AccountReference__c ASC LIMIT :recordsLimit' : query;
        query = (prevRef == null && nextRef != null) ? query+= ' WHERE AccountReference__c > :nextRef Order By AccountReference__c ASC LIMIT :recordsLimit':query;
        query = (prevRef != null && nextRef != null) ? query+= ' WHERE AccountReference__c >= :prevRef AND AccountReference__c <= :nextRef Order By AccountReference__c' : query;
        query = (prevRef != null && nextRef == null) ? query+= ' WHERE AccountReference__c > :prevRef Order By AccountReference__c ASC LIMIT :recordsLimit' : query;
        System.debug('query: '+query);
        List<Account> accounts = Database.query(query);
        System.debug('accounts: '+accounts.size());
        accounts = accounts.size() > 0 ? accounts : null;
        return accounts;
    }

    @AuraEnabled
    public static List<Account> searchAccounts(String prevRef, String nextRef, Integer recordsLimit, String name){
        
        String query =  'SELECT ID, Name, AccountReference__c, Site FROM Account';
        String searchKey = name != null ? '%'+name.trim()+'%' : null;
        System.debug(searchKey);
        query = (prevRef == null && nextRef == null) ? query+= ' WHERE Name LIKE: searchKey Order By AccountReference__c ASC LIMIT :recordsLimit' : query;
        query = (prevRef == null && nextRef != null) ? query+= ' WHERE Name LIKE: searchKey AND AccountReference__c > :nextRef Order By AccountReference__c ASC LIMIT :recordsLimit':query;
        query = (prevRef != null && nextRef != null) ? query+= ' WHERE Name LIKE: searchKey AND AccountReference__c >= :prevRef AND AccountReference__c <= :nextRef Order By AccountReference__c' : query;
        query = (prevRef != null && nextRef == null) ? query+= ' WHERE Name LIKE: searchKey AND AccountReference__c > :prevRef Order By AccountReference__c ASC LIMIT :recordsLimit' : query;
        System.debug('query: '+query);
        List<Account> accounts = Database.query(query);
        System.debug('accounts: '+accounts.size());
        accounts = accounts.size() > 0 ? accounts : null;
        return accounts;
    }

    @AuraEnabled
    public static Boolean saveRecords(String selectedRecsJSON){
        Boolean returnVal = false;
        Set<Id> accIds = new Set<Id>();
        Map<Id,Account> accounts;
        List<RecordLineItems> recLineItems = (List<RecordLineItems>)JSON.deserialize(selectedRecsJSON,List<RecordLineItems>.Class);
        if(recLineItems != null && !recLineItems.isEmpty()){
            for(RecordLineItems rec : recLineItems){
                accIds.add(rec.Id);                
            }
            accounts = new Map<Id,Account>([SELECT Id,site FROM Account WHERE Id IN :accIds]);
            if(!accounts.isEmpty()) {
                for(RecordLineItems rec : recLineItems){
                    accounts.get(rec.Id).site = rec.site;                
                }
                
                try{
                    update accounts.values();
                    returnVal =  true;
                }
                catch(Exception ex){
                    AuraHandledException aux = new AuraHandledException(ex.getMessage());
                    aux.setMessage(ex.getMessage());
                    throw aux;
                }
            }

        }
        return returnVal;
    }

    public class RecordLineItems{
        String id;
        String name;
        String accountRef;
        String site;
    }

}