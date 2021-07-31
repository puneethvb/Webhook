public with sharing class ExchangeRatesController
{
	public List<Currency_Rates__c> listOfRates{get;set;}
	public Cache.orgPartition part = Cache.Org.getPartition('local.CurrencyCache');
	public ExchangeRatesController() 
	{
		this.listOfRates = (List<Currency_Rates__c>)this.part.get('todaysRates');
		System.debug(listOfRates);
		if(listOfRates== null)
		loadCache();
	}

	public void loadCache()
	{
		List<Currency_Rates__c> listFromSOQL = [SELECT Name,Conversion_Rate__c FROM Currency_Rates__c];
		this.part.put('todaysRates',listFromSOQL);
		this.listOfRates = (List<Currency_Rates__c>)this.part.get('todaysRates');
		System.debug('I am loading cache');
	}
}