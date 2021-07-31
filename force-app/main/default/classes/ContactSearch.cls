public class ContactSearch {

	public static List<Contact> searchForContacts(String lName, String postalCode){

		List<Contact> conList = new List<Contact>();
		conList = [SELECT Id,Name FROM Contact WHERE lastName =:lName AND MailingPostalCode =:postalCode];
		return conList;
	}
}