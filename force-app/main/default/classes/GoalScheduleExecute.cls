public with sharing class GoalScheduleExecute implements GoalSchedule.iGoalSchedule
{
	public void execute(SchedulableContext sc)
	{
		processQueue();
	}

	public static void processQueue()
	{
		Integer goalQualiferCount = [SELECT Count() FROM Goal_Qualifier__c WHERE Status__c!='Complete' LIMIT 1];
		if(goalQualiferCount>0)
		{
			GoalSchedule__c gs = GoalStaticMethods.getorCreateGoalSchedule();
			Integer isBatchExecuting = [SELECT count() FROM AsyncApexJob WHERE Status IN('Queued','Processed','Preparing')
			AND id = :gs.batchId__c];
			if(gs.batchId__c == null|| (gs.batchId__c!=null && isBatchExecuting==0))
			{
				Integer numberOfBatches = [SELECT count() FROM AsyncApexJob WHERE Status IN('Queued','Processed','Preparing')];
				if(numberOfBatches < 5)
				{
					GoalBatch gb = new GoalBatch();
					gs.batchId__c = Database.executeBatch(gb,1);
					update gs;

				}
			}
		}
	}
}