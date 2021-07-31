@isTest
public class TestOpportunityChangeTrigger {
    
    @isTest static void testCreateAndUpdateOpportunity(){

        Test.enableChangeDataCapture();
        Opportunity opp = new Opportunity();
        opp.Name = 'Sell 100 Widgets';
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today().addMonths(3);
        insert opp;
        Test.getEventBus().Deliver();
        Opportunity oppNew = [SELECT Id,StageName FROM Opportunity LIMIT 1];
        oppNew.StageName = 'Closed Won';
        update oppNew;
        Test.getEventBus().Deliver();
        List<Task> tasks = [SELECT Id FROm Task];
        System.assertEquals(1,tasks.size());
    } 

}