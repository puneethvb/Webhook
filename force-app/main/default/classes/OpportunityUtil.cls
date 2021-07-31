public with sharing class OpportunityUtil {
    public OpportunityUtil() {

    }

    public static void populateOppTeam(List<Opportunity> triggerNew){

        Map<Id,Set<Id>> accToOpp = new Map<Id,Set<Id>>();
        Map<Id,Id> accTeamToUser = new Map<Id,Id>();
        Set<Id> oppIds = new Set<Id>();
        List<OpportunityTeamMember> oppTeamMembers = new List<OpportunityTeamMember>();
        List<OpportunitySplit> oppSplits = new List<OpportunitySplit>();
        System.Savepoint sp = Database.setSavePoint();
        try{
            for(Opportunity opp: triggerNew){
                if(opp.accountId!=null){
                    if(!accToOpp.containsKey(opp.accountId)){
                        accToOpp.put(opp.accountId,new Set<Id>());
                    }
                    accToOpp.get(opp.accountId).add(opp.Id);
                    oppIds.add(opp.Id);
                }
            }
    
            for(AccountTeamMember accTeam : [SELECT Id,AccountId,UserId FROM AccountTeamMember WHERE AccountId IN :accToOpp.keySet() 
                                             AND TeamMemberRole = 'Sales Manager']){            
                accTeamToUser.put(accTeam.AccountId,accTeam.UserId);
            }
    
            for(Id accId : accTeamToUser.keySet()){
                for(Id oppId: accToOpp.get(accId)){
                    OpportunityTeamMember oppTeamMember = new OpportunityTeamMember();
                    oppTeamMember.OpportunityId = oppId;
                    oppTeamMember.UserId = accTeamToUser.get(accId);
                    oppTeamMember.TeamMemberRole = 'Sales Manager'; 
                    oppTeamMember.OpportunityAccessLevel = 'edit';
                    oppTeamMembers.add(oppTeamMember);
    
                }            
            }
    
            if(!oppTeamMembers.isEmpty() && Limits.getDMLStatements() < Limits.getLimitDMLStatements()){
                insert oppTeamMembers;
            }

        }

        catch(Exception ex){
            /*
            for(Opportunity opp : (List<Opportunity>)Trigger.new){
                opp.addError('Something bad happened');
            }
            */
            /*
            String details = ex.getCause()+' '+ex.getMessage()+' '+ex.getStackTraceString();
            List<ExceptionUtil.ExceptionParam> logs = new List<ExceptionUtil.ExceptionParam>();
            ExceptionUtil.ExceptionParam log = new ExceptionUtil.ExceptionParam('Opportunity Team Member Creation',
                                                                                'Opportunity',details,ex.getTypeName());
            logs.add(log);
            ExceptionUtil.logException(logs);
            */
            String details = ex.getCause()+' '+ex.getMessage()+' '+ex.getStackTraceString();
            List<ExceptionUtil.ExceptionParam> logs = new List<ExceptionUtil.ExceptionParam>();
            ExceptionUtil.ExceptionParam log = new ExceptionUtil.ExceptionParam('Opportunity Team Member Creation',
                                                                                'Opportunity',details,ex.getTypeName());
            logs.add(log);
            ExceptionUtil.publishLogEvent(logs);
            throw new ExceptionUtil.genericException('A technical issue happened, please contact Your System Admin!');
        }

        try {

            for(OpportunityTeamMember oppTeamMember : [SELECT userId,OpportunityId FROm OpportunityTeamMember WHERE OpportunityId 
                                                        IN :oppIds AND TeamMemberRole = 'Sales Manager']){
                OpportunitySplit oppSplit = new OpportunitySplit();
                //oppSplit.OpportunityId = oppTeamMember.OpportunityId;
                oppSplit.SplitOwnerId = oppTeamMember.UserId;
                oppSplit.SplitPercentage = 30;
                oppSplit.SplitTypeId = '1497F000000gT6PQAU';
                oppSplits.add(oppSplit);
            }
            if(!oppSplits.isEmpty()){
                insert oppSplits;
            }
            
        } 
        catch (Exception ex) {
            String details = ex.getCause()+' '+ex.getMessage()+' '+ex.getStackTraceString();
            List<ExceptionUtil.ExceptionParam> logs = new List<ExceptionUtil.ExceptionParam>();
            ExceptionUtil.ExceptionParam log = new ExceptionUtil.ExceptionParam('Opportunity Team Member Creation',
                                                                                'Opportunity',details,ex.getTypeName());
            logs.add(log);
            ExceptionUtil.publishLogEvent(logs);
            Database.rollback(sp);            
        }          
    }
}