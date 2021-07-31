public with sharing class GoalStaticMethods 
{
	public static GoalSchedule__C getorCreateGoalSchedule()
	{
		GoalSchedule__C gs = getGoalSchedule();
		if(gs == null)
		{
			gs = new GoalSchedule__C(Name = 'GoalSchedule');
			insert gs;
		}
		return gs;
	}

	public static GoalSchedule__c getGoalSchedule()
	{
		return GoalSchedule__c.getInstance('GoalSchedule');
	}


}