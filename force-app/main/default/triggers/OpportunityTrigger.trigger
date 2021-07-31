trigger OpportunityTrigger on Opportunity (after insert) {

    if(Trigger.isAfter && Trigger.isInsert){
        OpportunityUtil.populateOppTeam(Trigger.new);
    }

}