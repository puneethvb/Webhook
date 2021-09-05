public with sharing class CustomMetadataUtility {
    
    public static List<Bucketed_Picklist__mdt> getBucketedPicklists(Id objId){

        List<Bucketed_Picklist__mdt> bucketedPickLIst = new List<Bucketed_Picklist__mdt>();
        if(objId == null){
            return bucketedPickLIst;
        }
        String objName = String.valueOf(objId.getSObjectType());
        bucketedPickLIst = [SELECT DeveloperName, object__r.qualifiedApiName, field__r.qualifiedApiName 
                            FROM Bucketed_Picklist__mdt WHERE object__r.qualifiedApiName = :objName];
        
        return bucketedPickLIst;

    }

    public static List<Picklist_Bucket__mdt> getPicklistBicketWithValues(String search, List<Bucketed_Picklist__mdt> bucketList){

        return [SELECT DeveloperName, Bucketed_Picklist__c, (SELECT label,developerName FROM Bucketed_Picklist_Value__r)
               FROM Picklist_Bucket__mdt WHERE Bucketed_Picklist__c IN :bucketList AND 
               Id IN (SELECT Picklist_Bucket__c FROM Bucketed_Picklist_Value__mdt WHERE label = :search)];

    }

}
