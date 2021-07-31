public class ParkServiceMock implements WebServiceMock
{
	public void doInvoke(Object stub,Object soapRequest,
		Map<String,Object> responseMap,String endPoint,
		String soapAction, String requestName, String responseNamespace,
		String responseName,String responseType)
	{
		ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
		List<String> res = new List<String>{'abc','cde'};
		response_x.return_x = res;
	    responseMap.put('response_x',response_x);
	}
}