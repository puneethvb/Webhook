@isTest
public class AnimalsCalloutsTest implements HttpCalloutMock
{
	
	@isTest static void testGetCallout()
	{
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		mock.setStaticResource('GetAnimalResource');
		mock.setHeader('Conetnt-Type', 'application/json;Charset=UTF:8');
		mock.setStatusCode(200);
		System.Test.setMock(HttpCalloutMock.class,mock);
		HttpResponse response = AnimalsCallouts.makeGetCallout();

		System.assertEquals(200,response.getStatusCode());
		Map<String,Object> animals = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
		List<Object> countofAnim = (List<Object>)animals.get('animals');
		System.assertEquals(3,countofAnim.size());
	}
	
	public HttpResponse respond(HttpRequest req)
	{
		HttpResponse resp = new HttpResponse();
		resp.setStatusCode(200);
		resp.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
		resp.setHeader('Conetnt-Type', 'application/json;Charset=UTF:8');
		return resp;
	}

	@isTest static void testPostCallout() 
	{
		System.Test.setMock(HttpCalloutMock.class,new AnimalsCalloutsTest());
		HttpResponse resp = AnimalsCallouts.makePostCallout();
	}
	
}