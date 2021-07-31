global class GoalSchedule implements Schedulable 
{
	public static final String CRONSCD = '0 0 0-23 * * ?';

	public interface iGoalSchedule
	{
		void execute(SchedulableContext sc);

	}

	global void execute(SchedulableContext sc)
	{
		Type t = Type.forName('GoalScheduleExecute');
		if(t!=null)
		{
			iGoalSchedule ig = (iGoalSchedule)t.newInstance();
			ig.execute(sc);
		}
	}
	
}