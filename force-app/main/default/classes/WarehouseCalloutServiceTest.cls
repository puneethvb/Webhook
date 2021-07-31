@isTest
private class WarehouseCalloutServiceTest
{
	@isTest
	static void testCallOut()
	{
		List<Product2> equipForCov = new List<Product2>();
		List<String> sku = new List<String>();
		sku.add('100003');
		equipForCov = TestDataFactory.createEquipments(1,'Test',true,sku);

		System.Test.setMock(HttpCalloutMock.Class,new WarehouseCalloutServiceMock());
		System.Test.startTest();
		WarehouseCalloutService.runWarehouseEquipmentSync();
		System.Test.stopTest();
		List<Product2> equipments = [SELECT Id FROm Product2];
		System.assertEquals(22,equipments.size());

	}
 
}