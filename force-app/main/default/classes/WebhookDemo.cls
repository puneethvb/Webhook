@RestResource(urlMapping='/api/webhooks/pushDetails/*')
global with sharing class WebhookDemo {
    

    @HttpPost
    
    global static void handleNotification(){
        try {
            RestRequest request = RestContext.request;
            RestResponse response = RestContext.response;

            JSONParser parser = JSON.createParser(request.requestBody.toString()); 
            List<CommitClass> commits = new List<CommitClass>();
            String repoName;
            List<Git_Hub_Webhook__c> webhooks = new List<Git_Hub_Webhook__c>();
            while(parser.nextToken()!=null){
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText()=='full_name'){

                    system.debug('Inside full name');
                    
                    parser.nextToken();
                    
                    repoName = parser.getText();
                    system.debug('repoName: '+repoName);
                }
                if(parser.getCurrentToken()==JSONToken.FIELD_NAME && parser.getText()=='commits'){
                    System.debug('inside commits');
                    //System.debug(parser.nextToken());
                    //system.debug('next token: '+parser.nextToken());
                    if(parser.nextToken()==JSONToken.START_ARRAY){
                        System.debug('inside start array');
                        while(parser.nextToken()!=null){
                            if(parser.getCurrentToken()== JSONToken.START_OBJECT){
                                System.debug('inside Start Object');
                                commits.add((CommitClass)parser.readValueAs(CommitClass.class)) ;
                            }
                        }
                    }
                }
            }
            System.debug(commits.size());
            if(!commits.isEmpty()){
                for(CommitClass commitClass : commits){
                    Git_Hub_Webhook__c webhook = new Git_Hub_Webhook__c();
                    webhook.Repository_name__c = repoName;
                    webhook.Publisher_Name__c = CommitClass.author.name;
                    webhook.published_URL__c = CommitClass.url;
                    webhooks.add(webhook);
                }
            }
            System.debug(webhooks.size());
            if(!webhooks.isEmpty()){
                insert webhooks;
            }
            
        } catch (Exception ex) {

            System.debug(ex.getMessage());
            
        }
        
    }

    public class CommitClass{
        public String id;
        public String tree_id;
        public Boolean distinct;
        public String message;
        public DateTime timestamp;
        public String url;
        public Author author;
        public Committer committer;
        public List<String> added;
        public List<String> removed;
        public List<String> modified;

        public CommitClass(String id, String tree_id,Boolean distinct,String message,DateTime timestamp,String url,Author author, Committer committer,List<String> added,List<String> removed,List<String> modified){
            id= id;
            tree_id = tree_id;
            distinct = distinct;
            message = message;
            timestamp =timestamp;
            url = url;
            author =author;
            committer = committer;
            added =added;
            removed =removed;
            modified=modified;
        }
    }

    public class Author{
        public String name;
        public String email;
    }

    public class Committer{
        public String name;
        public String email;
    }

}