public class ProjectCalloutServiceMock implements HttpCalloutMock {

	public HttpResponse respond(HttpRequest req){

		HttpResponse resp = new HttpResponse();
		resp.setHeader('Content-Type', 'application/json');
		resp.setStatus('OK');
		resp.setStatusCode(201);
		return resp;
	}
}