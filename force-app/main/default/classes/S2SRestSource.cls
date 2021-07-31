@RestResource(urlMapping = '/accountCreation')
global with sharing class S2SRestSource {

    global class request{
        String name {get;set;}
        String Industry{get;set;}
    }
    
    @HttpPost
    global static String createAccount(request req){

        Account newAcc = new Account(Name = req.name, Industry = req.Industry); 
        try{
            insert newAcc;
            return newAcc.Id;
        }
        catch(Exception ex){
            return ex.getMessage();

        }

    }
}