public class AccountHandler{
public static Account insertNewAccount(String name){
Account a = new Account(Name = name);
Database.saveResult sRes = Database.insert(a,false);
if(sRes.isSuccess())
return a;
else 
return null;

}
}