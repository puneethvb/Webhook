public class RandomContactFactory
{
	public static List<Contact> generateRandomContacts(Integer count,String lastName)
	{
		List<Contact> conList = new List<Contact>();
		for(Integer i =0;i<count;i++)
		{
			Contact con = new Contact();
			con.FirstName = 'Test'+(i+1);
			con.LastName = lastName;
			conList.add(con);
		}
		return conList;
	}
}