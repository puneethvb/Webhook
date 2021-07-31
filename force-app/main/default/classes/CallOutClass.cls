public with sharing class CallOutClass 
{
	public static HttpResponse callout(String endpoint)
	{
		HttpRequest hReq = new HttpRequest();
		hReq.setEndpoint(endpoint);
		hReq.setMethod('GET');
		Http h = new Http();
		HttpResponse resp = h.send(hReq);
		return resp;
	}
}