public class ControllerTestVF {
    
    public String accId {get;set;}
    public String testName {get;set;}
    
    public ControllerTestVF(){
        accId = ApexPages.currentPage().getParameters().get('accId');
        testName = ApexPages.currentPage().getParameters().get('testName');
    }

}