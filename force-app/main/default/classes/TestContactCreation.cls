@isTest
private class TestContactCreation 
    {
	
	@isTest static void CreateContactInsert() 
	{
		List<Contact> newContacts = PrepareTestData.PrepareContacts('Contact Test',100,false);
		System.assertEquals(100,newContacts.size());
		System.assertEquals(0,[SELECT count() from Contact]);
	}
	
	@isTest static void CreateContactNoInsert() 
	{
		List<Contact> newContacts = PrepareTestData.PrepareContacts('Contact',200,true);
		System.assertEquals(200,[SELECT count() FROM Contact]);
	}
	@isTest static void ContactCreateStaticRes()
	{
		List<Contact> newContacts = (List<Contact>)System.Test.LoadData(Contact.sObjectType,'Contacts');
		System.assertEquals(3,newContacts.size());
	}
	
}