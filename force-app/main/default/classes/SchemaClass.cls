public with sharing class SchemaClass
{
	public static void globalDescribe()
	{
		Map<String,Schema.SObjectType> gd = new Map<String,Schema.SObjectType>();
		gd = Schema.getGlobalDescribe();
		System.debug(gd);
	}
}