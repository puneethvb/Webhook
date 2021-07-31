public with sharing class ContactAndLeadSearch {
	
	public static List<List<SObject>> searchContactsAndLeads(String name){
		List<List<SObject>> searchList = [FIND :name IN NAME FIELDS RETURNING LEAD(name),Contact(name)];
		return searchList;

	}
}