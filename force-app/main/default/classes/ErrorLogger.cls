public without Sharing class ErrorLogger {
    
    List<Exception> exceptions;
    public ErrorLogger(List<Exception> exceptions){
        this.exceptions = exceptions;
    }

    public void publishError(){
        List<Error_Event__e> errorEvents = new List<Error_Event__e>();
        for(Exception except: exceptions){
            Error_Event__e err = new Error_Event__e();
            err.User_Name__c = userInfo.getUserName();
            system.debug(except.getStackTraceString().length());
            Integer len = except.getStackTraceString().length() > 100000 ? 100000 : except.getStackTraceString().length();
            err.Stack_Trace__c = except.getStackTraceString().subString(1,len);
            err.Exception_Type__c = except.getTypeName();
            err.Message__c = except.getMessage();
            errorEvents.add(err);
        }

        if(!errorEvents.isEmpty()){
            List<Database.SaveResult> srResults = Eventbus.publish(errorEvents);
            for(Database.SaveResult sr : srResults){
                System.debug(sr.isSuccess());
            }
        }
    }

}