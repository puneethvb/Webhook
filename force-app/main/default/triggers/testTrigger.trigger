trigger testTrigger on Account (before insert,after insert) 
{
  List<Contact> cList = new List<Contact>();
  Integer i = 0; 
  for(Account a: trigger.new)
  {
    Contact c = new Contact();
    c.LastName = 'abc' + i;
    //c.AccountId = a.id;
    cList.add(c);
    i+=1;
  }
  
  insert cList;
}