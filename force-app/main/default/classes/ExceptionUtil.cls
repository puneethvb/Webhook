public with sharing class ExceptionUtil {
    
    public class ExceptionParam{
        String processName;
        String objectName;
        String exceptionDetails;
        String exceptionType;

        public ExceptionParam(String processName,String objectName,String exceptionDetails,String exceptionType){
            this.processName = processName;
            this.objectName = objectName;
            this.exceptionDetails = exceptionDetails;
            this.exceptionType = exceptionType;
        }
    }
    public static void logException( List<ExceptionParam> params){

        List<Exception_Log__c> logs = new List<Exception_Log__c>();        
        for(ExceptionParam param : params){
            Exception_Log__c log = new Exception_Log__c();
            log.Exception_Type__c = param.exceptionType;
            log.Exception_Details__c = param.exceptionDetails;
            log.Object_Name__c = param.objectName;
            log.Process_Name__c = param.processName;
            logs.add(log);
        }

        if(!logs.isEmpty()){
            insert logs;
        }
        
    }

    public static void publishLogEvent(List<ExceptionParam> params){
        List<Exception_Log_PE__e> logs = new List<Exception_Log_PE__e>();
        for(ExceptionParam param : params){
            Exception_Log_PE__e log = new Exception_Log_PE__e();
            log.Exception_Type__c = param.exceptionType;
            log.Exception_Details__c = param.exceptionDetails;
            log.Object_Name__c = param.objectName;
            log.Process_Name__c = param.processName;
            logs.add(log);
        }
        if(!logs.isEmpty()){
            EventBus.publish(logs);
        }

    }

    public class genericException extends Exception{}

}