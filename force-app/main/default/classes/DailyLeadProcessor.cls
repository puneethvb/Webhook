public class DailyLeadProcessor implements Schedulable
{
	public void execute(SchedulableContext sc)
	{
		List<Lead> dailyLeads = [SELECT Id,LeadSource FROM Lead WHERE LeadSource=null LIMIT 200];
		for(Lead currentLead:dailyLeads)
		currentLead.LeadSource = 'Dreamforce';
		update dailyLeads;
	}
}