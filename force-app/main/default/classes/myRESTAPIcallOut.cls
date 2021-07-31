public with sharing class myRESTAPIcallOut {
    
    public myRESTAPIcallOut() {

    }

    public String clientId{get;set;}
    public String clientSecret{get;set;}
    public String userName{get;set;}
    public String password{get;set;}
    public String accessToken{get;set;}

    public void  retriveAccessToken(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        String Body='grant_type=password&'; 
        body=body+'client_id='+clientid+'&'; 
        body=body+'client_secret='+clientSecret+'&';
         body=body+'username='+username+'&';
          body=body+'password='+password;
        request.setBody(body);
        System.debug(body);
        HttpResponse resp = http.send(request);
        System.JSONParser parser = JSON.createParser(resp.getbody());
        while(parser.nextValue()!=null){
            if(parser.getCurrentName()=='access_token'){
                accessToken = parser.getText();
            }
        }



    }
}