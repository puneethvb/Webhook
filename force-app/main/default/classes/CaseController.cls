public with sharing class CaseController {
    
    @AuraEnabled(cacheable = true)
    public static List<Case> fetchSuggestedCases(String caseId){
        Case caseObj = [SELECT Id, Subject, Type FROM Case WHERE Id =:caseId];
        List<Case> returnList = new List<Case>();
        String searchString = String.join(caseObj.Subject.split(' '),'\' OR \'')+'*';
        System.debug(searchString);

        List<List<Sobject>> searchList = [FIND :searchString IN ALL FIELDS RETURNING Case(Id,CaseNumber,
                                          Subject WHERE Id != :caseObj.Id AND isClosed = true AND Type = :caseObj.Type
                                          ORDER BY CreatedDate DESC LIMIT 20)];
        if(searchList.size() > 0){
            returnList = (List<Case>)searchList[0];
        }

        return returnList;        
    }
}