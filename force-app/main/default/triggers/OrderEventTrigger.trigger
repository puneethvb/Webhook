trigger OrderEventTrigger  on Order_Event__e (after insert)
{
	List<Task> myTasks = new List<Task>();
	User currentUser = [SELECT Id FROM User WHERE Username = 'puneethvb@gmail.com.design' ];
	for(Order_Event__e order:Trigger.new)
	{
		if(order.Has_Shipped__c ==true)
		{
			Task newTask = new Task();
			newTask.OwnerId = UserInfo.getUserId();
			newTask.Priority = 'Medium';
			newTask.Subject = 'Follow up on Shipped Order' + order.Order_Number__c;
			newTask.Status = 'New';
			//newTask.WhatId = order.replayId;
			//newTask.AccountId ='0017F000007ZgBf';
			myTasks.add(newTask);
		}
	}
	insert myTasks;
	System.debug(myTasks);
}