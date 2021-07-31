public with sharing class AccountTriggerHandler 
{
	public static Boolean isrecursive = false;
	public static Boolean checkRecursive()
	{
		Boolean retValue = true;
		if(!isrecursive)
		retValue = false;
		isrecursive = true;
		return retValue;
	}
}