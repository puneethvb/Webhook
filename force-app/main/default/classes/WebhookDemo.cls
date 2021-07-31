@RestResource(urlMapping='/api/webhooks/pushDetails/*')
global with sharing class WebhookDemo {
    

    @HttpPost
    
    global static void handleNotification(){
        try {
            RestRequest request = RestContext.request;
            RestResponse response = RestContext.response;
            
        } catch (Exception ex) {

            System.debug(ex.getMessage());
            
        }
        
    }

}