public without sharing class VacationRequestActual implements VacationRequestSchedule.VacationRequest
{
	public void execute(SchedulableContext sc)
	{
		processrequests();
	}

	private void processrequests()
	{
		Integer requestCount = [SELECT count() FROM User_Feedback__c];
		if(requestCount>0)
		{
			try
			{
				VactionRequestBatch vrb = new VactionRequestBatch();
				Id batchId = Database.executeBatch(vrb,1);
			}
			Catch(Exception e)
			{
				
			}
			
		}
	}
	
}