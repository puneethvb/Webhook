@isTest
private class ProjectRESTServiceTest {
  //Implement Apex REST service tests here
  @isTest
  static void postProjectDataTest(){
  	RestRequest request = new RestRequest();
    request.requestURI = '/Project';
    request.httpMethod = 'POST';
    RestContext.request = request;

    Opportunity newOpp = new Opportunity(Name = 'Test Opp123456',StageName = 'Prospecting',CloseDate = system.today());
    insert newOpp;
    String result = ProjectRESTService.postProjectData('TestABCDEF','Proj1',newOpp.Id,system.today(),system.today().addDays(10),
  	                                                  2000,'Running');

    System.assertEquals('OK',result);
    Opportunity updatedOpp = [SELECT Id,DeliveryInstallationStatus__c FROM Opportunity WHERE Id = :newOpp.Id];
    System.assertEquals('In progress',updatedOpp.DeliveryInstallationStatus__c);

    result = ProjectRESTService.postProjectData('TestABCDEF','Proj1','ABCDEFR',system.today(),system.today().addDays(10),
  	                                                  2000,'Running');

  }
  
}