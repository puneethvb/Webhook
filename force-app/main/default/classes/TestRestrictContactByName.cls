@isTest
private class TestRestrictContactByName {
    
    @isTest static void test_method_one()
    {
        Contact con1 = new Contact();
        con1.LastName = 'INVALIDNAME';
        Test.startTest();
        try
        {
        	Database.SaveResult savRes = Database.insert(con1);

        }

        catch (Exception ee)
        {

        }
        
        Test.stopTest();
    }   
}