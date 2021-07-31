public with sharing class AuraEnabledController {
    
    @AuraEnabled
    public List<Wrap> wrappers {
        get{
            System.debug('Fetter');
            if(wrappers ==  null){
                wrappers = new List<Wrap>();
                for(Integer i = 0; i< 10; i++){
                    System.debug('inside for');
                    wrap newRap = new Wrap();
                    newRap.count = i;
                    newRap.name = 'Test'+i;
                    wrappers.add(newRap);
                }
            }
            System.debug(wrappers);
            return wrappers;
        } set;}

    public class Wrap{
        
        @AuraEnabled public Integer count{get;set;}
        @AuraEnabled public String name{get;set;}
    }
}