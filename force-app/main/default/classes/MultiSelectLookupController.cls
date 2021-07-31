public with sharing class MultiSelectLookupController {
    
    @AuraEnabled
    public static List<SobjQueryResults> retreiveRecords(String objName, String fields, String filter, String search){

        List<SobjQueryResults> results = new List<SobjQueryResults>();
        List<Sobject> queryRows = new List<Sobject>();
        search = search == '*'? '' : search;
        String str = '%'+search;
        String queryFields = '';
        List<String> fieldList = fields.split(',');
        if(!fieldList.contains('Id')){
            fieldList.add('Id');
            queryFields = String.join(fieldList,',');
        }
        else{
            queryFields = fields;
        }

        String query = 'SELECT '+ String.escapeSingleQuotes(queryFields) 
                        + ' FROM ' + String.escapeSingleQuotes(objName) 
                        + ' WHERE '+ filter + ' LIKE \''+str + '%\''
                        + ' ORDER BY ' + filter + ' LIMIT 50';
        System.debug(query);

        queryRows = Database.query(query);

        for(Sobject obj : queryRows){
            for(String fieldName : fieldList){
                if(fieldName!= 'Id'){
                    SobjQueryResults result = new SobjQueryResults();
                    result.recordId = (String)obj.get('Id');
                    result.recordName = (String)obj.get(fieldName);
                    results.add(result);
                }
            }
        }
        system.debug(results);
        return results;
    }
    
    
    public class SobjQueryResults {

        @AuraEnabled
        public String recordId;
        @AuraEnabled
        public String recordName;
    }
}