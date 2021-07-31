@isTest
private class ParkLocatorTest
{
	
	@isTest static void testPark()
	{
		Test.setMock(WebServiceMock.Class, new ParkServiceMock());
		List<String> parks = ParkLocator.country('Japan');
		System.assertEquals(2,parks.size());
	}
}