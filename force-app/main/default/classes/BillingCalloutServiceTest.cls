@isTest
private class BillingCalloutServiceTest {
  //Implement mock callout tests here

  @isTest
  static void testWebService(){

  	  Opportunity opp = new Opportunity(Name = 'Test12Opp',StageName = 'Prospecting',CloseDate = system.today());
      insert opp;
      Project__c proj = new Project__c(Name='TestProj',ProjectRef__c = 'Test1234',Billable_Amount__c = 1000,
  	                               Opportunity__c = opp.id,Status__c = 'Running');
      insert proj;

      ServiceCredentials__c userCredentials = new ServiceCredentials__c(Name = 'BillingServiceCredential',
      	                                                                Username__c = 'User1',
      	                                                                Password__c = 'password');

      insert userCredentials;
      Test.setMock(WebServiceMock.Class, new BillingCalloutServiceMock());
      proj.Status__c = 'Billable';
      update proj;
  }

  @isTest
  static void successTest(){
  	//userCredentials = ServiceCredentials__c.getInstance('BillingServiceCredential');
    BillingServiceProxy bProxy = new BillingServiceProxy();
    BillingServiceProxy.project project = new BillingServiceProxy.project();
    project.username = 'user';
    project.password = 'password';
    project.projectid = 'Test12345';
    project.billAmount = 1000;
    Test.setMock(WebServiceMock.Class, new BillingCalloutServiceMock());
    BillingServiceProxy.InvoicesPortSoap11 webCallObject = new BillingServiceProxy.InvoicesPortSoap11();
    String status = webCallObject.billProject(project);

    system.assertEquals('ok',status);
  }

  @isTest
  static void failTest(){

  	//ServiceCredentials__c userCredentials = ServiceCredentials__c.getInstance('BillingServiceCredential');
    BillingServiceProxy bProxy = new BillingServiceProxy();
    BillingServiceProxy.project project = new BillingServiceProxy.project();
    project.username = 'Usr1';
    project.password = 'password';
    project.projectid = null;
    project.billAmount = 1000;
    Test.setMock(WebServiceMock.Class, new BillingCalloutServiceMockFailure());
    BillingServiceProxy.InvoicesPortSoap11 webCallObject = new BillingServiceProxy.InvoicesPortSoap11();
    String status = webCallObject.billProject(project);

    system.assertEquals('failed',status);

  }
}