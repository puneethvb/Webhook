public with sharing class GoalTrackerV1 
{
	private static final String SACCOUNT = 'Account';
	private static final String SLEAD = 'Lead';
	private static final String SCONTACT = 'Contact';
	private static final String SOPPORTUNITY = 'Opportunity';

	public static void GoalTracker(List<SObject> sObjects) 

	{
		Set<Id> goalParticipantIds = new Set<Id>();
		Set<Id> goalIds = new Set<Id>();
		String objType = getObjType(sObjects[0]);
		Map<String,Goal_participant__c> goalPartcipantUserMap = new Map<String,Goal_participant__c>();
		List<Goal_participant__c> goalParticipants = getGoalParticipants(objType,sObjects,goalParticipantIds,goalPartcipantUserMap);

		if(goalParticipants.size()>0)
		{
			List<Goal__c> goals = getGoals(goalParticipants,goalIds);
			Map<String,Goal_Qualifier__c> previouslyQualififed = getPreviouslyQualified(goalIds,goalParticipantIds);
			List<Goal_Qualifier__c> goalQualifiers = new List<Goal_Qualifier__c>();
			goalQualifiers = evaluateGoals(objType,sObjects,goals,previouslyQualififed,goalPartcipantUserMap);
			insert goalQualifiers;
		}		
	}

	private static List<Goal_participant__c> getGoalParticipants(String objType,List<SObject> sObjects,Set<Id> goalParticipantIds,
		Map<String,Goal_participant__c> goalPartcipantUserMap)
	{
		List<Id> ownerIds = new List<Id>();
		for(SObject so: sObjects)
		{
			ownerIds.add((Id)so.get('OwnerId'));
		}

		List<Goal_participant__c> goalParticipants = [SELECT Id,Goal__c,User__c,Goal__r.Id
		FROM Goal_participant__c WHERE Goal__r.Object__c=:objType AND User__c IN :ownerIds];
		for(Goal_participant__c g : goalParticipants)
		{
			goalParticipantIds.add(g.Id);
			goalPartcipantUserMap.put((g.User__c+''+g.Goal__r.Id).toLowerCase(),g);
		}
		return goalParticipants;

	}

	private static String getObjType(SObject sobj)
	{
		String retVal= '';
		if(sobj instanceof Account)
		retval= SACCOUNT;
		else if(sobj instanceof Lead)
		retval= SLEAD;
		else if(sobj instanceof Opportunity)
		retval= SOPPORTUNITY;
		else if(sobj instanceof Contact)
		retval= SCONTACT;
		return retVal;

	}

	private static List<Goal__c> getGoals(List<Goal_participant__c> goalParticipants, Set<Id> goalIds)
	{
		for(Goal_participant__c gp:goalParticipants)
		{
			goalIds.add(gp.Goal__r.Id);
		}
		return [SELECT Id,Object__c,Field_Value__c,Field_Name__c FROM Goal__c WHERE Id IN :goalIds];

	}

	private static Map<String,Goal_Qualifier__c> getPreviouslyQualified(Set<Id> goalIds,Set<Id> goalParticipantIds)
	{
		Map<String,Goal_Qualifier__c> goalQualifiers =  new Map<String,Goal_Qualifier__c>();
		List<Goal_Qualifier__c> tmpList =[SELECT Id,Goal_participant__c,Account__c,Contact__c,Opportunity__c,Lead__c,
		Goal_participant__r.Goal__c,Goal_participant__r.User__c FROM Goal_Qualifier__c WHERE
		Goal_participant__r.Goal__c IN :goalIds AND Goal_participant__c IN :goalParticipantIds];
		for(Goal_Qualifier__c gq: tmpList)
		{
			String qObject ='';
			if(gq.Account__c != null)
			qObject = gq.Account__c;
			else if (gq.Contact__c!=null)
			qObject = gq.Contact__c;
			else if(gq.Lead__c!= null)
			qObject = gq.Lead__c;
			else if(gq.Opportunity__c!=null)
			qObject = gq.Opportunity__c;
		
		goalQualifiers.put((gq.Goal_Participant__r.Goal__c+''+gq.Goal_Participant__r.User__c+''+
			qObject).toLowerCase(),gq);
	}
		return goalQualifiers;
	}

	private static List<Goal_Qualifier__c> evaluateGoals(String objType, List<SObject> sObjects,List<Goal__c> goals,
		Map<String,Goal_Qualifier__c> previouslyQualififed,Map<String,Goal_participant__c> goalPartcipantUserMap)
	{
		List<Goal_Qualifier__c> goalQualifiers = new List<Goal_Qualifier__c>();
		for(Goal__c g:goals)
		{
			for(SObject s:sObjects)
			{
				if((String) s.get(g.Field_Name__c)==g.Field_Value__c &&
					!previouslyQualififed.containsKey((g.Id + '' + (String) s.get('OwnerId') + s.Id).toLowerCase()) && 
					goalPartcipantUserMap.containsKey(((String) s.get('OwnerId') + g.Id).toLowerCase()))
				{
					Goal_Qualifier__c tmp = new Goal_Qualifier__c();
					tmp.Goal_participant__c = 
						goalPartcipantUserMap.get(((String) s.get('OwnerId') + g.Id).toLowerCase()).Id;

					if(objType == SACCOUNT)
						tmp.Account__c = s.Id;
					else if(objType == SCONTACT)
						tmp.Contact__c = s.Id;
					else if(objType == SLEAD)
						tmp.Lead__c = s.Id;
					else if(objType == SOPPORTUNITY)
						tmp.Opportunity__c = s.Id;

					goalQualifiers.add(tmp);
				}
			}
		}
		return goalQualifiers;
	}
		
}