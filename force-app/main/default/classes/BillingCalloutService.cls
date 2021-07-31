public inherited sharing class BillingCalloutService {
    //Implement business and callout logic methods here

    public static void callBillingService(List<Project__c> triggerNew, Map<Id,Project__c> triggernewMap,
    	                                  List<Project__c> triggerOld, Map<Id,Project__c> triggeroldMap){

    	Map<String,Double> projectForCallOutMap = new Map<String,Double>();

    	for(Project__c proj : triggerNew){
            System.debug('Inside for loop');
    		if(proj.Status__c == 'Billable' && triggeroldMap.get(proj.Id).Status__c!= 'Billable'){
                System.debug('Found Billable');
    			projectForCallOutMap.put(proj.ProjectRef__c,proj.Billable_Amount__c);
    		}
    	}

    	if(projectForCallOutMap.size() >0){
    		system.debug('Calling future');
    		makeFutureCallOuts(projectForCallOutMap);
    	}
    }

    @future(callout=true) 
    public static void makeFutureCallOuts(Map<String,Double> projectsList){

    	ServiceCredentials__c userCredentials = ServiceCredentials__c.getInstance('BillingServiceCredential');
    	for(String projRef: projectsList.keySet()){
    		BillingServiceProxy bProxy = new BillingServiceProxy();
    		BillingServiceProxy.project project = new BillingServiceProxy.project();
    		project.username = userCredentials.Username__c;
    		project.password = userCredentials.Password__c;
    		project.projectid = projRef;
    		project.billAmount = projectsList.get(projRef);
    		BillingServiceProxy.InvoicesPortSoap11 webCallObject = new BillingServiceProxy.InvoicesPortSoap11();
    	    String status = webCallObject.billProject(project);
    	    system.debug('The status is :'+status);
    	}
    }
}