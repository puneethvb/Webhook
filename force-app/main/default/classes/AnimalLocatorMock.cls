public class AnimalLocatorMock implements HttpCalloutMock
{
	public HttpResponse respond(HttpRequest req)
	{
		HttpResponse response = new HttpResponse();
		response.setHeader('Content-Type', 'application/json;UTF:8');
		response.setStatusCode(200);
		response.setBody('{"animal":{"id":2,"name":"bear","eats":"berries, campers, adam seligman","says":"yum yum"}}');
		return response;
	}
}