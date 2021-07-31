public class PlatformEventSample
{
	public static void publishEvent()
	{
		Order_Event__e news = new Order_Event__e(Order_Number__c ='ABCDE12345',Has_Shipped__c = true);
		//news.Location__c ='MurugeshPalya';
		//news.Urgent__c = true;
		//news.News_Conetnt__c = 'Our hub is Green Park';

		Database.SaveResult sr = EventBus.publish(news);
		if(sr.isSuccess())
		System.debug('Successfully Published');
		else 
		{
			for(Database.Error err:sr.getErrors())
			System.debug(err.getStatusCode() + '---'+err.getMessage());
		}
	}
}