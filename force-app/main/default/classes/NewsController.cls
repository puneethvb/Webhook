public with sharing class NewsController {  

    @AuraEnabled
    public static Map<String,Object> retreiveNews(){

        Map<String,Object> JSONData = new Map<String,Object>();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:News_API//v2/top-headlines?country=us&category=business&apiKey=82587b69f1784b75bae01fb5b3252085');
        req.setMethod('GET');

        try{
            Http http = new Http();
            HttpResponse response = http.send(req);
            if(response.getStatusCode() == 200){
                if(String.isNotBlank(response.getBody())){
                    JSONData = (Map<String,Object>)JSON.deserializeUnTyped(response.getBody());
                }                
            }
            else{
                throw new CalloutException(response.getBody());
            }
        }
        catch(Exception ex){
            /*AuraHandledException auraExc = new AuraHandledException(ex.getMessage());
            auraExc.setMessage(ex.getMessage());
            throw auraExc;*/
            throw ex;
        }
        JSONData = JSONData.isEmpty() ? null : JSONData;

        return JSONData;
    }
    


}