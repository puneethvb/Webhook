@isTest
private class LeadProcessorTest
{
	
	@isTest static void testLeadBatch() 
	{
		List<Lead> leads = PrepareTestData.prepareLeads('abc',200,false);
		insert leads;
		LeadProcessor lProcessor = new LeadProcessor();
		System.Test.startTest();
		Id batchId = Database.executeBatch(lProcessor);
		System.Test.stopTest();
		System.assertEquals(200,[SELECT count() FROM Lead WHERE LeadSource ='Dreamforce']);
	}	
}