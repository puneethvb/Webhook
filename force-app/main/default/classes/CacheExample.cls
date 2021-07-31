public with sharing class CacheExample
{
	public CacheExample()
	{
		Cache.OrgPartition orgPart = Cache.Org.getPartition('local.CurrencyCache');
		System.debug(orgPart);
		orgPart.put('example','0.76');
		String cachedRate = (String)orgPart.get('example');
		System.debug(cachedRate);
	}
}