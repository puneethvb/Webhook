public with sharing class SchemaExample {
    public SchemaExample() {

    }

    public static void getTheDescribeInfo(Sobject sObj){

        //getting the token for an Sobject
        Schema.SObjectType token = sObj.getSObjectType();
        //Schema.SObjectType token = Account.SObjectType;     

        //getting sobjectDescribe
        Schema.DescribeSObjectResult describeRes = token.getDescribe();
        //Schema.DescribeSObjectResult describeRes = token.Account;

       //Name of the object
       String name = describeRes.getName();
       System.debug('Name : '+name);
       // permissions
       Boolean isAccessabile = describeRes.isAccessible();
       system.debug('isAccessabile: '+isAccessabile);

       Boolean isCreatable = describeRes.isCreateable();
       system.debug('isCreatable: '+isCreatable);

       Boolean isCustom = describeRes.isCustom();
       system.debug('isCustom: '+isCustom);
       //getRecordtype details

       List<Schema.RecordTypeInfo> recTypes = describeRes.getRecordTypeInfos();
       system.debug(recTypes[0].getDeveloperName());

       //Map of all field describe
       Map<String,Schema.SObjectField> fieldMap = describeRes.fields.getMap();
       Schema.DescribeFieldResult fieldDesc;
       for(String fieldName : fieldMap.keySet()){
            fieldDesc = fieldMap.get(fieldName).getDescribe();
            break;
       }

       system.debug(fieldDesc.getName());

    }
}