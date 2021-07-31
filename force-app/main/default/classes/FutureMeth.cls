public with sharing class FutureMeth {
    
    @Future
    public static void futureMethod(){
        //DataBase.executeBatch(new BatchSample(), 100);
        System.debug('Can not call batch from future');
    }

    public static void generateError(){

        try{
            String s;
            if(s.length() > 0){
                System.debug('I will not be executed');
            }
        }
        catch(exception ex){
            List<Exception> exList =  new List<Exception>();
            exList.add(ex);
            ErrorLogger errLogger = new ErrorLogger(exList);
            errLogger.publishError();
        }

    }
}