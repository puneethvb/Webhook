trigger AccountTrig on Account (after update) {

    //FutureMeth.generateError();
    //Integer i =1/0;
    
    for(Account a : Trigger.new){
        a.Name ='punee';
    }

}