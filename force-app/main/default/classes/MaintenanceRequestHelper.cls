public class MaintenanceRequestHelper
{
    
    public static void updateWorkOrders(List<Case> newTriggerList,List<Case> oldTriggerList,Map<Id,Case> newTriggerMap,
    	Map<Id,Case> oldTriggerMap, Boolean isAfter)
    {
        //List<Id> idList = new List<Id>();
        List<Case> oldCaseListWithParts = new List<Case>();
        List<Case> newCaseList = new List<Case>();
        Map<Id,Case> oldNewCaseMap = new Map<Id,Case>();
        Map<Id,List<Work_Part__c>> oldCaseWorkPartMap = new Map<Id,List<Work_Part__c>>();
        if(isAfter)
        {
            oldCaseListWithParts = [SELECT Id,Type,Vehicle__c,Equipment__c,(SELECT Id,Equipment__r.Maintenance_Cycle__c,
            Equipment__c,Quantity__c FROM Work_Parts__r) FROM Case 
            WHERE isClosed = true AND Type IN ('Routine Maintenance','Repair') AND Id IN :newTriggerMap.keySet()];
            for(Case oldCase: oldCaseListWithParts)
            {
            	Case newCase = new Case();
            	newCase.Vehicle__c = oldCase.Vehicle__c;
            	newCase.Equipment__c = oldCase.Equipment__c;
            	newCase.Type = 'Routine Maintenance';
            	newCase.Subject = 'Future Maintenance Request' + 'for' + oldCase.Equipment__c;
            	newCase.Date_Reported__c = System.Date.today();
            	List<Work_Part__c> workPartList = oldCase.Work_Parts__r;
            	newCase.Date_Due__c = System.Date.today().addDays(calculateMinMaintCycle(workPartList));
            	newCaseList.add(newCase);
            	oldNewCaseMap.put(oldCase.Id, newCase);
            	oldCaseWorkPartMap.put(oldCase.Id,workPartList);
            }

            if(newCaseList.size()>0)
            {
            	Database.SaveResult[] insertRes = Database.insert(newCaseList,false);
            	insertWorkParts(oldNewCaseMap,oldCaseWorkPartMap);
            }        
        }
    }

    public static Integer calculateMinMaintCycle(List<Work_Part__c> workPartsReceived)
    {
    	List<Integer> maintCycleList = new List<Integer>();
    	for(Work_Part__c workPart: workPartsReceived)
    	{
    		maintCycleList.add(workPart.Equipment__r.Maintenance_Cycle__c.intValue());
    	}
    	if(maintCycleList.size()>0)
    	{
    		maintCycleList.sort();
    	    return maintCycleList[0];
    	}

    	else
    	return 0;
    }

    public static void insertWorkParts(Map<Id,Case> oldNewCaseMap, Map<Id,List<Work_Part__c>> oldCaseWorkPartMap)
    {
    	List<Work_Part__c> newWorkParts = new List<Work_Part__c>();
    	for(Id oldCaseId: oldNewCaseMap.keySet())
    	{
    		List<Work_Part__c> oldWorkParts = new List<Work_Part__c>();
    		oldWorkParts.addAll(oldCaseWorkPartMap.get(oldCaseId));
    		for(Work_Part__c oldPart: oldWorkParts)
    		{
    			Work_Part__c newPart = new Work_Part__c();
    			newPart.Equipment__c = oldPart.Equipment__c;
    			newPart.Quantity__c = oldPart.Quantity__c;
    			if(oldNewCaseMap.get(oldCaseId).Id!=null)
    			{
    				newPart.Maintenance_Request__c = oldNewCaseMap.get(oldCaseId).Id;
    			    newWorkParts.add(newPart);
    			}
    			
    		}

    	}

    	Database.SaveResult[] result = Database.insert(newWorkParts,false);

    }        
    
}