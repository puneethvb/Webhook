public with sharing class LWCUtil {
    public LWCUtil() {

    }

    @AuraEnabled(Cacheable=true)
    public static Map<String,String> simpleMap(String name){

        Map<String,String> returnMap  = new Map<String,String>();
        returnMap.put(name,'Liverpool');
        returnMap.put('2','Man City');
        returnMap.put('3','bayern');

        return returnMap;        
    }

   @AuraEnabled
    public static List<Account> listOfSobjects(Integer count, String abc){

        String query = 'SELECT Id, Name FROM Account';
        
        query = count > 0 ? query+' LIMIT '+count : query+' LIMIT 10';
        return Database.query(query);        
    }
    

    public Class innerClass1{
        String param1;
        String param2;
        Integer param3;

    }

    @AuraEnabled
    public static string parseData(){

        innerClass1 data1 = new innerClass1();
        data1.param1 = 'p1';
        data1.param2 = 'p2';
        data1.param3 = 10; 
        return JSON.serialize(data1);      
        
    }

    public static void accessCustomSetting(){
        HierCS__c hrMine = HierCS__c.getInstance();
        system.debug(hrMine.Value__c);

        HierCS__c hrMine1 = HierCS__c.getInstance(userinfo.getProfileId());
        system.debug(hrMine1.Value__c);

        HierCS__c hrMine2 = HierCS__c.getOrgDefaults();
        system.debug(hrMine2.Value__c);
    }
}