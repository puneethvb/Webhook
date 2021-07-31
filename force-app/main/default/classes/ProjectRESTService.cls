@restResource(urlMapping = '/Project/*')
global inherited sharing class ProjectRESTService {
    //Implement service logic here
    @httpPost
    global static String postProjectData( String ProjectRef,String ProjectName, String OpportunityId,
    	                           Date StartDate, Date EndDate, Double Amount, String Status){

    	List<Project__c> projects = [SELECT Id,Name,Billable_Amount__c,End_Date__c,Opportunity__c,ProjectRef__c,
    	                             Start_Date__c,Status__c FROM Project__c WHERE ProjectRef__c =:ProjectRef];
    	Project__c newProject = new Project__c();
    	if(projects!=null && projects.size()>0){
    		newProject = projects[0];
    	}
        savePoint sp = Database.setSavepoint();
    	try{
    		newProject.Billable_Amount__c = Amount;
    		newProject.ProjectRef__c = ProjectRef;
    		newProject.Name = ProjectName;
    		if(newProject.Opportunity__c==null){
    			newProject.Opportunity__c = OpportunityId;
    		}
    		newProject.Start_Date__c = StartDate;
    		newProject.End_Date__c = EndDate;
    		newProject.Status__c = Status;
    		upsert newProject;
            Opportunity opp;
    		if(OpportunityId!=null && OpportunityId.trim().length()>0){

    		opp = [SELECT id,DeliveryInstallationStatus__c FROM Opportunity
    		                   WHERE Id =:OpportunityId];
    		opp.DeliveryInstallationStatus__c = 'In Progress';

    	}
    		update Opp;


    		return 'OK';
    	}
    	catch(Exception ex){
    		Database.rollback(sp);
    		return ex.getMessage();
    	}



    	
    }
}