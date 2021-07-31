@isTest
public class PrepareTestData {
	
	public static List<Contact> PrepareContacts(String prefix,Integer count,Boolean insertNow)
	{
		List<Contact> myContacts = new List<Contact>();
		for(Integer i =0;i<count;i++)
		{
			Contact con = new Contact(LastName = prefix+i);
			myContacts.add(con);
		}
		if(insertNow)
		insert myContacts;
		return myContacts;
	}

	public static List<Lead> prepareLeads(String prefix, Integer count, Boolean insertNow)
	{
		List<Lead> listOfLeads = new List<Lead>();
		for(Integer i= 0;i<count;i++)
		{
			Lead ld = new Lead(LastName = prefix+i,Company = 'Company'+i,Status = 'Open - Not Contacted');
			listOfLeads.add(ld);
		}
		if(insertNow)
		insert listOfLeads;
		return listOfLeads;
	}

	public static List<Account> prepareAccounts(String prefix, Integer count, Boolean insertNow)
	{
		List<Account> listOfAccounts = new List<Account>();
		for(Integer i= 0;i<count;i++)
		{
			Account acc = new Account(Name = prefix+i);
			listOfAccounts.add(acc);
		}
		if(insertNow)
		insert listOfAccounts;
		return listOfAccounts;
	}		
}