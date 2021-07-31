public with sharing class GoalConfigurationController 
{
	public static final String SSCHEDULE = 'ScheduleStatus';
	public List<Goal_Qualifier__c> goalQalifierList{get;set;}
	public Boolean hasErrors{get;private set;} 
	public String errorMessage{get;private set;}
	public Boolean showCompleted{get;set;}
	public Boolean listHasItems{get{return(this.goalQalifierList.size()>0);}private set;}	
	public Boolean isScheduleEnabled
	{
		get
		{
			Boolean retVal = false;
			GoalSchedule__c gs = GoalStaticMethods.getorCreateGoalSchedule();
			if(gs.CronId__c!=null && [SELECT count() FROM CronTrigger WHERE Id = :gs.CronId__c]==1)
			retVal = true;
			return retVal;
		}
		private set;

	}

	public String scheduleStatus{get{return(this.isScheduleEnabled == false? 'Stopped' : 'Running' );}}
	public Boolean hasGoalQualifiers
	{
		get
		{
			Boolean retVal =  false;
			if(this.goalQalifierList.size()>0)
			for(Goal_Qualifier__c gq : goalQalifierList)
			if(gq.Status__c !='Complete')
			retVal = true;
			return retVal;
		}
		private set;
	}

	public GoalConfigurationController()
	{
		GoalSchedule__c gs = GoalStaticMethods.getGoalSchedule();
		if(gs!=null)
		this.showCompleted = gs.Show_Completed__c;
		loadGoalQualifiers();
	}

	private void loadGoalQualifiers()
	{
		String query = 'SELECT Id, Name, Account__c, Account__r.Name, Contact__c, Contact__r.Name, Lead__c, Lead__r.Name, ';
		query += 'Opportunity__c, Opportunity__r.Name, Goal_Participant__c, Goal_Participant__r.User__c, ';
		query += 'Goal_Participant__r.User__r.Name, CreatedDate, Status__c ';
		query += 'FROM Goal_Qualifier__c ';
		if(this.showCompleted != true)
			query += 'WHERE Status__c != \'complete\' ';
		query += 'ORDER BY CreatedDate';

		this.goalQalifierList = Database.query(query);
		System.debug(goalQalifierList);

	}

	public PageReference enableSchedule()
	{
		GoalSchedule__c gs = GoalStaticMethods.getorCreateGoalSchedule();
		try
		{
			gs.CronId__c =  System.schedule('GoalSchedule', GoalSchedule.CRONSCD, new GoalSchedule());
			update gs;
		}
		catch(Exception e)
		{
			this.hasErrors = true;
			this.errorMessage = e.getMessage();
		}
		return null;	
	}

	public PageReference disableSchedule()
	{
		GoalSchedule__c gs = GoalStaticMethods.getorCreateGoalSchedule();
		try
		{
			System.abortJob(gs.CronId__c);
		}
		catch (Exception e){}
		gs.CronId__c = null;
		update gs;
		return null;
	}

	public PageReference processQueue()
	{
		GoalScheduleExecute.processQueue();
		return null;
	}

	public PageReference toggleShowCompleted()
	{
		GoalSchedule__c gs = GoalStaticMethods.getorCreateGoalSchedule();
		gs.Show_Completed__c = this.showCompleted;
		update gs;
		loadGoalQualifiers();
		return null;
	}
}