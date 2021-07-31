public with sharing class AnimalLocator
{
	public static String getAnimalNameById(Integer idNum)
	{
		Http ht = new Http();
		String retvalue;
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+idNum);
		request.setMethod('GET');
		HttpResponse response = ht.send(request);
		if(response.getStatusCode()==200)
		{
			JSON2Apex results = parse(response.getBody());
			retvalue = results.animal.name;
		}

		else 
		{
			System.debug('something went wrong');
		}
		return retvalue;
	}

	public class JSON2Apex {
		public Animal animal;
	}

	public class Animal {
		public Integer id;
		public String name;
		public String eats;
		public String says;
	}

	
	public static JSON2Apex parse(String json) {
		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
	}
}