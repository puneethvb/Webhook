trigger AccountTrigger on Account (before update) 
{
    
    List<Account> myAccounts = new List<Account>();
    for(Account a : Trigger.new)
    { 
        a.Bad_Contacts__c +=1;
        
    }



}