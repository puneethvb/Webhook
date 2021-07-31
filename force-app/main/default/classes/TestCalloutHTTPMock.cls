@isTest
public class TestCalloutHTTPMock implements HttpCalloutMock
    {
	
	public HttpResponse respond(HttpRequest hreq) 
	{
		HttpResponse retVal = new HttpResponse();
		retVal.setHeader('Content-Type', 'application/json');
		retVal.setBody('{"FirstName" : "Seb","LastName" : "Vettel"}');
		retVal.setStatusCode(200);
		return retVal;
	}
	
	@isTest static void testcallout() 
	{
		System.Test.setMock(HttpCalloutMock.class, new TestCalloutHTTPMock());
		HttpResponse resp = CallOutClass.callout('http://abcdefghegfj.dsed.com/');
		System.assertEquals('application/json',resp.getHeader('Content-Type'));
		System.assertEquals('{"FirstName" : "Seb","LastName" : "Vettel"}',resp.getBody());
		System.assertEquals(200,resp.getStatusCode());
	}

	@isTest static void teststaticcallout()
	{
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		mock.setHeader('Content-Type', 'application/json');
		mock.setStaticResource('calloutmock');
		mock.setStatusCode(200);
		Test.setMock(HttpCalloutMock.Class, mock);
		HttpResponse resp = CallOutClass.callout('http://new/newes/');
		System.assertEquals('application/json',resp.getHeader('Content-Type'));
		System.assertEquals('{"FirstName" : "Valetteri", "LastName" : "Bottas"}',resp.getBody());
		System.assertEquals(200,resp.getStatusCode());
	}
	
	@isTest static void testmultistaticCallout()
	{
		MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
		mock.setStaticResource('http://link1/', 'calloutmock');
		mock.setStaticResource('https://link2/', 'calloutmock1');
		mock.setHeader('Content-Type', 'application/json');
		mock.setStatusCode(200);
		Test.setMock(HttpCalloutMock.class, mock);
		HttpResponse resp = CallOutClass.callout('http://link1/');
		System.assertEquals('{"FirstName" : "Valetteri", "LastName" : "Bottas"}',resp.getBody());
		resp = CallOutClass.callout('https://link2/');
		System.assertEquals('{"FirstName" : "Sergio", "LastName" : "Perez"}',resp.getBody());
	}
}