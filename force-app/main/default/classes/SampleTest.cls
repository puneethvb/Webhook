@isTest
private class SampleTest
{
	
	@isTest static void test_method_one()
	{
		List<Lead> leadList = PrepareTestData.prepareLeads('abc',9000,false);
		insert leadlist;
		leadlist.clear();
		leadList = PrepareTestData.prepareLeads('abcd',9000,false);
		insert leadlist;
		leadlist.clear();
		leadList = PrepareTestData.prepareLeads('abce',9000,false);
		insert leadlist;
		leadlist.clear();
		leadList = PrepareTestData.prepareLeads('abcf',9000,false);
		insert leadlist;
		leadlist.clear();
		leadList = PrepareTestData.prepareLeads('abg',9000,false);
		insert leadlist;
		leadlist.clear();
		leadList = PrepareTestData.prepareLeads('abch',9000,false);
		insert leadlist;
		Integer i =0;
		List<Lead> leadlist1 = [SELECT Id FROM Lead];
		for(Lead l1:[SELECT Id FROM Lead])
	    i+=1;

	}
	
	
}