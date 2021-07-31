public Class FutureClass{
    
    @future
    public static void futMethod(){
        
        system.debug('Future Meth0d');
        System.enqueueJob(new QueuableClass());
    }
}