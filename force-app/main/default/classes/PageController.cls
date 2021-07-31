public with sharing class PageController {
	
	public class MyWrapper
	{
		public Contact con{get; Private set;}
		public Opportunity opp{get;Private set;}

		public MyWrapper(Contact pageCon, Opportunity pageOpp)
		{
			this.con = pageCon;
			this.opp = pageOpp;
		}
	}

	public List<MyWrapper> wrapperList{get;Private set;}

	public PageController()
	{
		Map<Id,Contact> conMap = new Map<Id,Contact>([SELECT Id,Name FROM Contact WHERE Id in(SELECT ContactId FROM 
			OpportunityContactRole WHERE IsPrimary = true)]);
		Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>([SELECT Id,Name FROM Opportunity WHERE Id IN(SELECT OpportunityId
			FROM OpportunityContactRole WHERE IsPrimary= true)]);
		List<OpportunityContactRole> oprConList = new List<OpportunityContactRole>([SELECT ContactId,OpportunityId FROM OpportunityContactRole
			WHERE IsPrimary = true]);
		this.wrapperList = new List<MyWrapper>();
		for(OpportunityContactRole opr : oprConList )
		{
			this.wrapperList.add(new MyWrapper(conMap.get(opr.ContactId),oppMap.get(opr.OpportunityId)));

		}
	}
}