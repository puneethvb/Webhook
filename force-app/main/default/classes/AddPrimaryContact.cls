public class AddPrimaryContact implements Queueable
{
	private Contact con;
	private String state;
	public AddPrimaryContact(Contact cont,String stte)
	{
		this.con = cont;
		this.state = stte;
	}


	public void execute(QueueableContext context)
	{
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :this.state];
        List<Contact> myContacts = new List<Contact>();
        for(Account acc:accounts)
        {
        	Contact newContact = this.con.clone();
        	newContact.AccountId = acc.Id;
        	myContacts.add(newContact);
        }

        insert myContacts;
	}
}