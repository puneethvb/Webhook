@isTest
private class WarehouseSyncScheduleTest
{
	
	@isTest static void test_method_one() 
	{
		List<Product2> equipForCov = new List<Product2>();
		List<String> sku = new List<String>();
		sku.add('100003');
		equipForCov = TestDataFactory.createEquipments(1,'Test',true,sku);

        System.Test.setMock(HttpCalloutMock.Class,new WarehouseCalloutServiceMock());
		System.Test.startTest();
		WarehouseSyncSchedule sh = new WarehouseSyncSchedule();
		String sch = '0 0 0 15 3 ? *';
		String jobId = System.schedule('TestJob1', sch, sh);
		CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
		System.Test.stopTest();
		System.assertEquals('0 0 0 15 3 ? *',ct.CronExpression);
		//System.assertEquals(1,ct.TimesTriggered);
		List<Product2> equipments = [SELECT Id FROm Product2];
		//System.assertEquals(22,equipments.size());
		

	}
		
}