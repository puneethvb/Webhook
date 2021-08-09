public with sharing class SchemaMethods {

   
    public static void globalDesc(){

        Map<String,Schema.SObjectType> allObjectsMap = Schema.getGlobalDescribe();
        Integer i = 0;
        for(String obj : allObjectsMap.keySet()){
            System.debug(obj);
            system.debug(allObjectsMap.get(obj));
            i++;
            if(i > 10){
                break;
            }
        }
    }

    
}
