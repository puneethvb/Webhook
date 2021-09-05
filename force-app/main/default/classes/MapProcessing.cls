public with sharing class MapProcessing {
    @AuraEnabled public Map<String, List<RecallInfo>> recallsByVin {get; set;}
    public class RecallInfo{
        @AuraEnabled public String description {get; set;}
        @AuraEnabled public String recallLink {get; set;}
        public RecallInfo(String description, String recallLink){
            this.description = description;
            this.recallLink = recallLink;
        }
    }

    @AuraEnabled(cacheable=true)
    public static Map<String,List<RecallInfo>> getMap(){
        try {

            System.debug(URL.getSalesforceBaseURL().toExternalForm());
            Map<String, List<RecallInfo>> map1 = new Map<String,List<RecallInfo>>();

            RecallInfo rc1 = new RecallInfo('I am description 1', URL.getSalesforceBaseURL().toExternalForm() + '/0017F00000OKnEGQA1');
            RecallInfo rc2 = new RecallInfo('I am description 2', URL.getSalesforceBaseURL().toExternalForm() + '/0017F00000OKnEGQA1');
            RecallInfo rc3 = new RecallInfo('I am description 3', URL.getSalesforceBaseURL().toExternalForm() + '/0017F00000OKnEGQA1');
            
            map1.put('xxxxxxxxxxxxx',new List<RecallInfo>());
            map1.get('xxxxxxxxxxxxx').add(rc1);
            map1.get('xxxxxxxxxxxxx').add(rc2);
            map1.put('yyyyyyyyyyyyy',new List<RecallInfo>());
            map1.get('yyyyyyyyyyyyy').add(rc3);
            map1.put('zzzzzzzzzzzz',new List<RecallInfo>());

            return map1;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

system.debug(MapProcessing.getMap());