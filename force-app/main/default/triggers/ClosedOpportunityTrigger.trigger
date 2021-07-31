trigger ClosedOpportunityTrigger on Opportunity (after insert,after update){
    //if(Trigger.isInsert){
        /*system.debug('before update');
        userTeamMember usrT = [SELECT Id,OpportunityAccessLevel,TeamMemberRole,UserId FROM  UserTeamMember Where OwnerId = :Trigger.new[0].ownerId LIMIt 1];
        OpportunityTeamMember opp = new OpportunityTeamMember();
        opp.OpportunityAccessLevel = usrt.OpportunityAccessLevel;
        opp.OpportunityId = Trigger.new[0].Id;
        opp.TeamMemberRole = usrt.TeamMemberRole;
        opp.UserId = usrt.userId;
        insert opp;  
        system.debug('after update');*/
    //}
    List<OpportunityTeamMember> oppList = [SELECT OpportunityAccessLevel, TeamMemberRole,UserId FROM OpportunityTeamMember where OpportunityId = :Trigger.new[0].Id ];
    List<OpportunityTeamMember> teamList = new List<OpportunityTeamMember>();
    for(OpportunityTeamMember opp1 : oppList){
        OpportunityTeamMember team = new OpportunityTeamMember();
        team.OpportunityAccessLevel = opp1.OpportunityAccessLevel;
        team.OpportunityId = Trigger.new[0].Id;
        team.UserId = opp1.UserId;
        teamList.add(team);
    }

    insert teamList;

    if(trigger.isUpdate){

        if(trigger.new[0].stageName == 'Closed Won'){
            system.debug('I am here');
            oppTriggerHelper.updateShare(Trigger.new[0].Id);
        }

    }
    

}