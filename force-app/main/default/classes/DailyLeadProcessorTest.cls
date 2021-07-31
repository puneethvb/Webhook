@isTest
private class DailyLeadProcessorTest
{
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
	
	@isTest static void testLeadProcessing()
	{
		List<Lead> listOfLeads = PrepareTestData.prepareLeads('Lead123',200,false);
		insert listOfLeads;
		System.Test.startTest();
		DailyLeadProcessor dly = new DailyLeadProcessor();
		String jobId = System.schedule('DailyLeadSource', CRON_EXP, dly);
		System.Test.stopTest();
		System.debug(jobId);
		System.assertEquals(200,[SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
	}	
}