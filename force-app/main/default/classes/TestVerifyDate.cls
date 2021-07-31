@isTest
private class TestVerifyDate
{
	
	@isTest static void testVerifyMethod()
	{
		Date Date1 = System.Date.today();
		Date Date2 = System.Date.today().addDays(-45);
		Integer totalDays = Date.daysInMonth(Date1.year(), Date1.month());
		Date endOfMonth = Date.newInstance(Date1.year(), Date1.month(), totalDays);
		Date resultDate = VerifyDate.checkDates(Date1,Date2);
		System.assertEquals(endOfMonth,resultDate);

		resultDate = null;
		Date2 = System.Date.today().addDays(45);
		resultDate = VerifyDate.checkDates(Date1,Date2);
		System.assertEquals(endOfMonth,resultDate);

		resultDate = null;
		Date2 = System.Date.today().addDays(29);
		resultDate = VerifyDate.checkDates(Date1,Date2);
		System.assertEquals(Date2,resultDate);		
	}
}