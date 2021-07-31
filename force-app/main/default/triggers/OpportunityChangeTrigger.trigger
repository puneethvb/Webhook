trigger OpportunityChangeTrigger on OpportunityChangeEvent (after insert) {

    List<Task> tasks = new List<Task>();
    for(OpportunityChangeEvent event : Trigger.new){
        EventBus.ChangeEventHeader header = event.ChangeEventHeader;
        if(header.changeType == 'UPDATE' && event.isWon){

            Task tk = new Task();
            tk.Subject = 'Follow up on won opportunities: ' + header.recordIds;
            tk.OwnerId = header.CommitUser;
            tasks.add(tk);
        } 
    }

    if(tasks.size() > 0 ){
        insert tasks;
    }

}