@isTest
private class AnimalLocatorTest
{
	
	@isTest static void testAnimal()
	{
		Test.setMock(HttpCalloutMock.Class, new AnimalLocatorMock());
		String name = AnimalLocator.getAnimalNameById(2);
		System.assertEquals('bear',name);
	}
}