public with sharing class ParkLocator
{
	public static List<String> country(String countryName)
	{
		ParkService.ParksImplPort ps = new ParkService.ParksImplPort();
		//String countryName = 'India';
		List<String> results = ps.byCountry(countryName);
		return results;
	}
}