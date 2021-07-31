public with sharing class oppTriggerHelper {
    //@future
   public static void updateShare(String oppId){

       OpportunityShare oppShare = [SELECT Id,OpportunityAccessLevel FROm OpportunitySHare WHERE opportunityId = :oppID and rowCause = 'Team' LIMIT 1];
       oppShare.OpportunityAccessLevel = 'Read';
       update oppShare;

   }
}